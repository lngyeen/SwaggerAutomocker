//
//  SwaggerAutomockerExtensions.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/30/21.
//

import Foundation
import Telegraph

public typealias HTTPRequest = Telegraph.HTTPRequest
public typealias HTTPResponse = Telegraph.HTTPResponse
public typealias HTTPStatus = Telegraph.HTTPStatus
public typealias HTTPVersion = Telegraph.HTTPVersion
public typealias HTTPHeaders = Telegraph.HTTPHeaders

public enum PathParamsParserError: Int, Error, LocalizedError {
    // Throw when entered paths are not equal
    case pathComponentsNotEqual
        
    public var description: String {
        switch self {
        case .pathComponentsNotEqual:
            return"The provided paths are not equal."
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .pathComponentsNotEqual:
            return NSLocalizedString(
                "The provided paths are not equal.",
                comment: "Not equal paths"
            )
        }
    }
}

public extension MockServer {
    static func pathParamsFrom(requestPath: String, endpointPath: String) throws -> [String: String] {
        let requestComponents = requestPath.components(separatedBy: "/")
        let endpointComponents = endpointPath.components(separatedBy: "/")
        
        guard requestComponents.count == endpointComponents.count else { throw PathParamsParserError.pathComponentsNotEqual }
        
        let difference = zip(endpointComponents, requestComponents).compactMap { $0.0 == $0.1 ? nil : ($0.0.replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: ""), $0.1) }
        let pathParams = Dictionary(difference, uniquingKeysWith: { first, _ in first })
        
        return pathParams
    }
    
    static func genDataSourceExtensionFor(endpoints: [MockServerEndpoint]) -> String {
        let groupEndpointsByPath = Dictionary(grouping: endpoints, by: { $0.path })
        var string: String = ""
        string += "extension MockServerResponseDataSource {"
        string += "\n    func mockServer(_ mockServer: MockServer, responseFor request: HTTPRequest, to endpoint: MockServerEndpoint, possibleResponses: [HTTPResponse]) -> HTTPResponse? {"
        string += "\n        print(request.fullDescription)"
        string += "\n\n        let pathParams = (try? MockServer.pathParamsFrom(requestPath: request.path, endpointPath: endpoint.path)) ?? [:]"
        string += "\n\n        switch endpoint.path {"
        for (endpointPath, endpoints) in groupEndpointsByPath {
            string += "\n        case \"\(endpointPath)\":"
            
            string += "\n            switch endpoint.method {"
            for endpoint in endpoints {
                string += "\n            case .\(endpoint.method): break\n"
            }
            string += "\n            default: break\n            }\n"
        }
        string += "\n        default: break\n        }\n"
        string += "\n        return nil"
        string += "\n    }"
        string += "\n}"
        
        return string
    }
}

public extension HTTPStatus {
    /// Creates a HTTPStatus.
    /// - Parameter code: The numeric code of the status (e.g. 404)
    init(code: Int) {
        self.init(code: code, phrase: "phrase", strict: false)
    }
}

public extension HTTPResponse {
    var statusCode: Int {
        return status.code
    }
    
    convenience init(statusCode: Int,
                     version: HTTPVersion = .default,
                     headers: HTTPHeaders = .empty,
                     body: Data = Data())
    {
        self.init(HTTPStatus(code: statusCode), version: version, headers: headers, body: body)
    }
}

public extension HTTPRequest {
    var queryItems: [URLQueryItem]? {
        return uri.queryItems
    }
    
    var query: String? {
        return uri.query
    }
    
    var path: String {
        return uri.path
    }
    
    var fullDescription: String {
        var logRequest = "Request description (\(String(describing: self)):\n"
        let urlString = path
        logRequest += String(repeating: "- ", count: 14 + urlString.count/2)
        logRequest += "\n|"
            + String(repeating: " ", count: 13)
            + "\(urlString)"
            + String(repeating: " ", count: 12)
            + "|"
        logRequest += "\n" + String(repeating: "- ", count: 14 + urlString.count/2)
        logRequest += "\n|     Request: \(method.name) - \(path)"
        
        if !headers.isEmpty {
            let headerString = Dictionary(uniqueKeysWithValues:
                headers.map { ($0.key.description, $0.value) }).prettyPrinted
            logRequest += "\n|     Headers(\(headers.count)):\n\(headerString)"
        }
        
        if let queryItems = queryItems, !queryItems.isEmpty {
            logRequest += "\n|     Queries(\(queryItems.count)):\n\(queryItems)"
        }
        
        if let payloadObject = body.jsonObject {
            logRequest += "\n|     Body    :\n\(payloadObject.prettyPrinted)"
        } else if let payloadArray = body.jsonArray {
            logRequest += "\n|     Body    :\n\(payloadArray.prettyPrinted)"
        } else if let payloadArray = body.stringArray {
            logRequest += "\n|     Body    :\n\(payloadArray.prettyPrinted)"
        } else if let payloadString = body.string {
            logRequest += "\n|     Body    :\n\(payloadString)"
        }
        
        logRequest += "\n" + String(repeating: "- ", count: 14 + urlString.count/2) + "\n"
        
        return logRequest
    }
}

public extension Data {
    var jsonObject: [String: Any]? {
        guard let json = try? JSONSerialization.jsonObject(with: self, options: .fragmentsAllowed) as? [String: Any],
              !json.isEmpty else { return nil }
        return json
    }
    
    var jsonArray: [[String: Any]]? {
        guard let array = try? JSONSerialization.jsonObject(with: self, options: .fragmentsAllowed) as? [[String: Any]],
              !array.isEmpty else { return nil }
        return array
    }
    
    var stringArray: [String]? {
        guard let array = try? JSONSerialization.jsonObject(with: self, options: .fragmentsAllowed) as? [String],
              !array.isEmpty else { return nil }
        return array
    }
    
    var string: String? {
        guard !isEmpty else { return nil }
        return String(data: self, encoding: .utf8)
    }
}

public extension String {
    func removingRegexMatches(pattern: String, replaceWith: String = "") -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let range = NSMakeRange(0, count)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceWith)
        } catch {
            return self
        }
    }
}

public extension Array {
    var data: Data? {
        try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
    }
    
    var prettyPrinted: String {
        guard let data = data else { return "" }
        return String(data: data, encoding: .utf8) ?? ""
    }
}

public extension Dictionary where Key == String {
    var data: Data? {
        try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
    }
    
    var prettyPrinted: String {
        guard let data = data else { return "" }
        return String(data: data, encoding: .utf8) ?? ""
    }
}
