//
//  MockServer.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/5/20.
//  Copyright © 2020 Nguyen Truong Luu. All rights reserved.
//

import Foundation
import ObjectMapper
import Telegraph

public class MockServerConfiguration {
    public var defaultValuesConfiguration: MockServerDefaultValueConfiguration = MockServerDefaultValueConfiguration()
    public var defaultArrayElementCount: Int = 3
    public var enableDebugPrint: Bool = true
    public init() {}
}

public class MockServerDefaultValueConfiguration {
    public var booleanDefaultValue = true
    public var floatDefaultValue = 1.23
    public var doubleDefaultValue = 2.34
    public var int32DefaultValue = 123
    public var int64DefaultValue = 123456789
    public var dateDefaultValue = "2017-07-21"
    public var dateTimeDefaultValue = "2017-07-21T17:32:28Z"
    public var passwordDefaultValue = "********"
    public var byteDefaultValue = "U3dhZ2dlciByb2Nrcw=="
    public var binaryDefaultValue = "TWFuIGlzIGRpc3Rpb"
    public var emailDefaultValue = "firstname@domain.com"
    public var uuidDefaultValue = "123e4567-e89b-12d3-a456-426614174000"
    public var uriDefaultValue = "https://www.example.com/foo.html"
    public var hostnameDefaultValue = "www.example.com"
    public var ipv4DefaultValue = "192.0.2.235"
    public var ipv6DefaultValue = "2001:0db8:85a3:0000:0000:8a2e:0370:7334"
    public var othersDefaultValue = "string value"
    
    public init() {}
    
    public func defaultValueFor(type: String) -> Any {
        guard let format = SwaggerSchemaFormatType(rawValue: type) else { return othersDefaultValue }
        switch format {
        case .float: return floatDefaultValue
        case .double: return doubleDefaultValue
        case .int32: return int32DefaultValue
        case .int64: return int64DefaultValue
        case .date: return dateDefaultValue
        case .dateTime: return dateTimeDefaultValue
        case .password: return passwordDefaultValue
        case .byte: return byteDefaultValue
        case .binary: return binaryDefaultValue
        case .email: return emailDefaultValue
        case .uuid: return uuidDefaultValue
        case .uri: return uriDefaultValue
        case .hostname: return hostnameDefaultValue
        case .ipv4: return ipv4DefaultValue
        case .ipv6: return ipv6DefaultValue
        case .others: return othersDefaultValue
        }
    }
}

public class MockServer {
    public let port: Int
    public let swaggerJson: [String: Any]
    public let server = Server()
    private var swagger: SwaggerJson?
    private(set) static var configuration = MockServerConfiguration()
    
    public init(port: Int = 8080,
                swaggerJson: [String: Any],
                config: MockServerConfiguration = MockServerConfiguration())
    {
        self.port = port
        self.swaggerJson = swaggerJson
        MockServer.configuration = config
    }
    
    public func start() {
        swagger = SwaggerJson(JSON: swaggerJson)
        if let swagger = swagger {
            /*
             Suppose we have 2 endpoints: "GET: /user/{username}" and "GET: /user/login".
            
             The problem is that the Telegraph confuses these two endpoints,
             so it is preferable to select the first match response closure in the queue for processing.
            
             Then if we add endpoint "GET: /user/{username}" first, and call endpoint "GET: /user/login",
             Telegraph will execute closure of endpoint "GET: /user/{username}", resulting in incorrect return data.
            
             To solve this problem we have to add enpoints that has no path prams first and then add endpoints that has path prams later to the Telegraph.
             */
            
            print("[SERVER]", "Server is preparing the endpoints")
            let allEndpoints = swagger.endPoints.sorted(by: { $0.path < $1.path })
            
            for endpoint in allEndpoints {
                print(MockServer.responseDescription(httpMethod: endpoint.method.description,
                                                     path: endpoint.path,
                                                     statusCode: endpoint.statusCode,
                                                     response: endpoint.responseString?.utf8Data))
            }
            
            let endpointsHasPathParam = allEndpoints.filter { $0.hasPathParameters }
            let endpointsHasNoPathParam = allEndpoints.filter { !$0.hasPathParameters }
            
            for endpoint in endpointsHasNoPathParam {
                server.route(endpoint.method, endpoint.route) { (_) -> HTTPResponse? in
                    
                    var headers: [HTTPHeaderName: String] = [:]
                    
                    if let contentType = endpoint.contentType {
                        headers[HTTPHeaderName(stringLiteral: "Content-Type")] = contentType
                    }
                    
                    for (key, val) in endpoint.headers {
                        headers[HTTPHeaderName(stringLiteral: key)] = val
                    }
                    
                    return HTTPResponse(HTTPStatus(code: endpoint.statusCode, phrase: ""), headers: headers, body: endpoint.responseString?.utf8Data ?? Data())
                }
            }

            for endpoint in endpointsHasPathParam {
                server.route(endpoint.method, regex: "^" + endpoint.route + "$") { (_) -> HTTPResponse? in
                    
                    var headers: [HTTPHeaderName: String] = [:]
                    
                    if let contentType = endpoint.contentType {
                        headers[HTTPHeaderName(stringLiteral: "Content-Type")] = contentType
                    }
                    
                    for (key, val) in endpoint.headers {
                        headers[HTTPHeaderName(stringLiteral: key)] = val
                    }
                    
                    return HTTPResponse(HTTPStatus(code: endpoint.statusCode, phrase: ""), headers: headers, body: endpoint.responseString?.utf8Data ?? Data())
                }
            }

            server.delegate = self
            server.concurrency = 100
            
            do {
                try server.start(port: port)
            } catch {
                print(error.localizedDescription)
            }
            print("[SERVER]", "Server is running")
        } else {
            print("[SERVER]", "Mock server can not start because no json swagger was found")
        }
    }
    
    public func stop() {
        server.stop()
    }
    
    private static func responseDescription(httpMethod: String, path: String, statusCode: Int, response: Data?) -> String {
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

private extension Data {
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

private extension Array {
    var prettyPrinted: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

private extension Dictionary {
    var prettyPrinted: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

// MARK: - ServerDelegate implementation

extension MockServer: ServerDelegate {
    // Raised when the server gets disconnected.
    public func serverDidStop(_ server: Server, error: Error?) {
        print("[SERVER]", "Server stopped:", error?.localizedDescription ?? "")
    }
}
