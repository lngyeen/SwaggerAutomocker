//
//  MockServerEndpoint.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/5/20.
//  Copyright © 2020 Nguyen Truong Luu. All rights reserved.
//

import Foundation
import Telegraph

public final class MockServerEndpoint {
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
    
    /// Default response - first response object in the responses array which has the success status code (200-299)
    public var defaultResponse: SwaggerResponse {
        return responses.filter { $0.statusCode >= 200 && $0.statusCode <= 299 }
            .sorted(by: { $0.statusCode < $1.statusCode }).first ?? SwaggerResponse()
    }
    
    var hasPathParameters: Bool {
        return path != route
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
            if let paramName = pathParam.name {
                switch pathParam.type {
                case "integer":
                    route = route.removingRegexMatches(pattern: "\\{\(paramName)\\}", replaceWith: "[-+]?[0-9]+")
                    
                case "number":
                    route = route.removingRegexMatches(pattern: "\\{\(paramName)\\}", replaceWith: "[-+]?[0-9]+(?:[.,][0-9]+)*")
                    
                default:
                    route = route.removingRegexMatches(pattern: "\\{\(paramName)\\}", replaceWith: "[^/]*")
                }
            }
        }
        route = route.removingRegexMatches(pattern: "\\{\(".*")\\}", replaceWith: "[^/]*")
        
        self.route = route
    }
    
    func possibleHttpResponses(version: HTTPVersion) -> [HTTPResponse] {
        return responses.map { [weak self] response -> HTTPResponse in
            let headers = self?.headersFor(response: response) ?? [:]
            return HTTPResponse(statusCode: response.statusCode,
                                version: version,
                                headers: headers,
                                body: response.responseString?.utf8Data ?? Data())
        }
    }
    
    func headersFor(response: SwaggerResponse) -> [HTTPHeaderName: String] {
        var headers: [HTTPHeaderName: String] = [:]
        if let contentType = contentType {
            headers[HTTPHeaderName(stringLiteral: "Content-Type")] = contentType
        }
        for (key, value) in response.headersJson {
            headers[HTTPHeaderName(stringLiteral: key)] = value
        }
        return headers
    }
}

public extension MockServerEndpoint {
    var description: String {
        return description(method: method,
                           path: path,
                           statusCode: defaultResponse.statusCode,
                           response: defaultResponse.responseString?.utf8Data)
    }

    private func description(method: HTTPMethod, path: String, statusCode: Int, response: Data?) -> String {
        let maxResponseLength = 2000
        var logResponse = String(repeating: "- ", count: 14 + path.count/2)
        logResponse += "\n|"
            + String(repeating: " ", count: 13)
            + path
            + String(repeating: " ", count: 12)
            + "|"
        logResponse += "\n" + String(repeating: "- ", count: 14 + path.count/2)
        logResponse += "\n|     Method: \(String(describing: method.description))"
        logResponse += "\n|     Default status code: \(statusCode)"
        
        if let responseObject = response?.jsonObject {
            var responseJSON = responseObject.prettyPrinted
            responseJSON = "      " + responseJSON.replacingOccurrences(of: "\n", with: "\n      ")
            if responseJSON.count > maxResponseLength {
                responseJSON = String(responseJSON.prefix(maxResponseLength))
                responseJSON += " (...) \n     The response is too long and has been truncated to the first \(maxResponseLength) chars)"
            }
            logResponse += "\n|     Response example: \(type(of: responseObject)) :\n\(responseJSON)"
        } else if let responseArray = response?.jsonArray {
            var responseJSON = responseArray.prettyPrinted
            if responseJSON.count > maxResponseLength {
                responseJSON = String(responseJSON.prefix(maxResponseLength))
                responseJSON += " (...) \n     The response is too long and has been truncated to the first \(maxResponseLength) chars)"
            }
            responseJSON = "      " + responseJSON.replacingOccurrences(of: "\n", with: "\n      ")
            logResponse += "\n|     Response example: \(type(of: responseArray)) (\(responseArray.count) objects):\n\(responseJSON)"
        } else if let responseArray = response?.stringArray {
            var responseJSON = responseArray.prettyPrinted
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
