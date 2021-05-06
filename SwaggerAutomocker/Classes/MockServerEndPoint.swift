//
//  MockServerEndPoint.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/5/20.
//  Copyright © 2020 Nguyen Truong Luu. All rights reserved.
//

import Foundation
import Telegraph

public final class MockServerEndPoint {
    
    /// HTTPMethod:  GET/POST/PUT/DELETE...
    public let method: HTTPMethod

    /// Original path include path params for example: /api/v1/company/{id}
    public let path: String
    
    /// Endpoint parameters (path params, query params)
    public let parameters: [SwaggerParam]
    
    /// Regular expression form of the path property
    public let route: String
    
    /// Content type (Media Type)
    public let contentType: String?
    
    /// All possible responses of the endpoint
    public let responses: [SwaggerResponse]
    
    /// Default response - first response object in the response array which has the success status code (200-299)
    public var defaultResponse: SwaggerResponse {
        return responses.filter { $0.statusCode >= 200 && $0.statusCode <= 299 }
            .sorted(by: { $0.statusCode < $1.statusCode }).first ?? SwaggerResponse()
    }
    
    var hasPathParameters: Bool {
        return path != route
    }
    
    var description: String {
        return description(httpMethod: method.description,
                           path: path,
                           statusCode: defaultResponse.statusCode,
                           response: defaultResponse.responseString?.utf8Data)
    }

    init(method: String,
         path: String,
         parameters: [SwaggerParam],
         contentType: String?,
         responses: [SwaggerResponse])
    {
        self.method = HTTPMethod(stringLiteral: method)
        self.path = path
        self.parameters = parameters
        self.contentType = contentType
        self.responses = responses
        
        var route = path
        let pathParams = parameters.filter { $0.position == "path" }
        for pathParam in pathParams {
            switch pathParam.type {
            case "integer":
                route = route.removingRegexMatches(pattern: "\\{\(pathParam.name ?? ".*")\\}", replaceWith: "[-+]?[0-9]+")
                
            case "number":
                route = route.removingRegexMatches(pattern: "\\{\(pathParam.name ?? ".*")\\}", replaceWith: "[-+]?[0-9]+(?:[.,][0-9]+)*")
                
            default:
                route = route.removingRegexMatches(pattern: "\\{\(pathParam.name ?? ".*")\\}", replaceWith: "[^/]*")
            }
        }
        
        self.route = route
    }
    
    private func description(httpMethod: String, path: String, statusCode: Int, response: Data?) -> String {
        let maxResponseLength = 2000
        var logResponse = String(repeating: "- ", count: 14 + path.count/2)
        logResponse += "\n|"
            + String(repeating: " ", count: 13)
            + path
            + String(repeating: " ", count: 12)
            + "|"
        logResponse += "\n" + String(repeating: "- ", count: 14 + path.count/2)
        logResponse += "\n|     Method: \(String(describing: httpMethod))"
        logResponse += "\n|     Default status code: \(statusCode)"
        
        if let responseObject = response?.jsonObject,
           var responseJSON = responseObject.prettyPrinted
        {
            responseJSON = "      " + responseJSON.replacingOccurrences(of: "\n", with: "\n      ")
            if responseJSON.count > maxResponseLength {
                responseJSON = String(responseJSON.prefix(maxResponseLength))
                responseJSON += " (...) \n     The response is too long and has been truncated to the first \(maxResponseLength) chars)"
            }
            logResponse += "\n|     Response example: \(type(of: responseObject)) :\n\(responseJSON)"
        } else if let responseArray = response?.jsonArray,
            var responseJSON = responseArray.prettyPrinted
        {
            if responseJSON.count > maxResponseLength {
                responseJSON = String(responseJSON.prefix(maxResponseLength))
                responseJSON += " (...) \n     The response is too long and has been truncated to the first \(maxResponseLength) chars)"
            }
            responseJSON = "      " + responseJSON.replacingOccurrences(of: "\n", with: "\n      ")
            logResponse += "\n|     Response example: \(type(of: responseArray)) (\(responseArray.count) objects):\n\(responseJSON)"
        } else if let responseArray = response?.stringArray,
            var responseJSON = responseArray.prettyPrinted
        {
            if responseJSON.count > maxResponseLength {
                responseJSON = String(responseJSON.prefix(maxResponseLength))
                responseJSON += " (...) \n     The response is too long and has been truncated to the first \(maxResponseLength) chars)"
            }
            responseJSON = "      " + responseJSON.replacingOccurrences(of: "\n", with: "\n      ")
            logResponse += "\n|     Response example: \(type(of: responseArray)) (\(responseArray.count) objects):\n\(responseJSON)"
        } else if var responseString = response?.string {
            if responseString.count > maxResponseLength {
                responseString = String(responseString.prefix(maxResponseLength))
                responseString += " (...) \n     The response is too long and has been truncated to the first \(maxResponseLength) chars)"
            }
            responseString = "      " + responseString.replacingOccurrences(of: "\n", with: "\n      ")
            logResponse += "\n|     Response example: \(type(of: responseString)) :\n\(responseString)"
        }
        
        logResponse += "\n" + String(repeating: "- ", count: 14 + path.count/2) + "\n"
        
        return logResponse
    }
}

public extension Data {
    var jsonObject: [String: Any]? {
        guard let json = try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any],
              !json.isEmpty else { return nil }
        return json
    }
    
    var jsonArray: [[String: Any]]? {
        guard let array = try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [[String: Any]],
              !array.isEmpty else { return nil }
        return array
    }
    
    var stringArray: [String]? {
        guard let array = try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String],
              !array.isEmpty else { return nil }
        return array
    }
    
    var string: String? {
        guard !isEmpty else { return nil }
        return String(data: self, encoding: .utf8)
    }
}

extension String {
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

extension Array {
    var prettyPrinted: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension Dictionary {
    var prettyPrinted: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
