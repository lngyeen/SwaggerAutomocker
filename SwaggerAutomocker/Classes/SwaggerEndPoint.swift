//
//  SwaggerEndPoint.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/4/20.
//  Copyright © 2020 Nguyen Truong Luu. All rights reserved.
//

import Foundation
import ObjectMapper

enum SwaggerEndPointAttribute: String {
    case produces
    case parameters
    case requestBody
    case responses
}

class SwaggerEndPoint: Mappable {
    var produces: [String] = []
    var parameters: [SwaggerParam] = []
    var responses: [String: SwaggerResponse]?
    var requestBody: SwaggerResponse?
    var contentType: String {
        return produces.first ?? ""
    }

    var responseCode: Int {
        if responses != nil {
            let defaultRes = defaultResponse()
            return Int(defaultRes.statusCode) ?? 204
        }
        return 204
    }

    var headers: [String: String] {
        if responses != nil {
            let defaultRes = defaultResponse()
            return defaultRes.response.headersJson
        }
        return [:]
    }

    required init?(map: Map) {}
    func mapping(map: Map) {
        produces <- map[SwaggerEndPointAttribute.produces.rawValue]
        parameters <- map[SwaggerEndPointAttribute.parameters.rawValue]
        responses <- (map[SwaggerEndPointAttribute.responses.rawValue], ResponsesTransformer())
        requestBody <- (map[SwaggerEndPointAttribute.requestBody.rawValue], RequestBodyTransformer())
    }

    func responseStringFromDefinitions(_ definitions: Definitions) -> String? {
        if responses != nil {
            let defaultRes = defaultResponse()
            return defaultRes.response.responseFromDefinitions(definitions)
        }
        return nil
    }

    private func defaultResponse() -> (statusCode: String, response: SwaggerResponse) {
        if let responses = responses {
            let okResponses = responses.filter { (reponse) -> Bool in
                if reponse.key != "default", let keyInt = Int(reponse.key), keyInt >= 200, keyInt <= 299 {
                    return true
                } else {
                    return false
                }
            }
            let sortedOkResponseKeys = Array(okResponses.keys).sorted(by: <)
            if let firstKey = sortedOkResponseKeys.first,
               let firstData = responses[firstKey]
            {
                return (firstKey, firstData)
            }
        }
        return (statusCode: "204", response: SwaggerResponse())
    }
}

private class ResponsesTransformer: TransformType {
    func transformFromJSON(_ value: Any?) -> [String: SwaggerResponse]? {
        if let responses = value as? [String: Any] {
            var returnValue: [String: SwaggerResponse] = [:]

            for (statusCode, responseData) in responses {
                if let jsonObject = responseData as? [String: Any] {
                    let content: [String: Any] = jsonObject["content"] as? [String: Any] ?? [:]
                    /// Get "application/json" first, if not exists, try to get other types
                    if let nestedJsonObject = (content["application/json"] as? [String: Any]) ??
                        content.values.first(where: { $0 is [String: Any] }) as? [String: Any] {
                        returnValue[statusCode] = SwaggerResponse(JSON: nestedJsonObject)
                    } else {
                        returnValue[statusCode] = SwaggerResponse(JSON: jsonObject)
                    }
                }
            }
            return returnValue
        }
        return nil
    }

    func transformToJSON(_ value: [String: SwaggerResponse]?) -> [String: Any]? {
        if let value = value {
            return value.mapValues { $0.toJSON() }
        }
        return nil
    }
}

private class RequestBodyTransformer: TransformType {
    func transformFromJSON(_ value: Any?) -> SwaggerResponse? {
        if let requestBody = value as? [String: Any] {
            var returnValue: SwaggerResponse?
            let content: [String: Any] = requestBody["content"] as? [String: Any] ?? [:]
            /// Get "application/json" first, if not exists, try to get other types
            if let nestedJsonObject = (content["application/json"] as? [String: Any]) ??
                content.values.first(where: { $0 is [String: Any] }) as? [String: Any] {
                returnValue = SwaggerResponse(JSON: nestedJsonObject)
            } else {
                returnValue = SwaggerResponse(JSON: requestBody)
            }
            
            return returnValue
        }
        return nil
    }
    
    func transformToJSON(_ value: SwaggerResponse?) -> [String: Any]? {
        return value?.toJSON()
    }
}
