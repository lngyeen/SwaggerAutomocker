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
    var responses: [SwaggerResponse] = []
    var contentType: String {
        return produces.first ?? ""
    }

    required init?(map: Map) {}
    func mapping(map: Map) {
        produces <- map[SwaggerEndPointAttribute.produces.rawValue]
        parameters <- map[SwaggerEndPointAttribute.parameters.rawValue]
        responses <- (map[SwaggerEndPointAttribute.responses.rawValue], ResponsesTransformer())
    }
}

private class ResponsesTransformer: TransformType {
    func transformFromJSON(_ value: Any?) -> [SwaggerResponse]? {
        if let responses = value as? [String: Any] {
            var returnValue: [SwaggerResponse] = []
            for (statusCode, responseData) in responses {
                if let jsonObject = responseData as? [String: Any], let statusCode = Int(statusCode) {
                    let content: [String: Any] = jsonObject["content"] as? [String: Any] ?? [:]
                    /// Get "application/json" first, if not exists, try to get other types
                    if let nestedJsonObject = (content["application/json"] as? [String: Any]) ??
                        content.values.first(where: { $0 is [String: Any] }) as? [String: Any],
                        let response = SwaggerResponse(JSON: nestedJsonObject, statusCode: statusCode)
                    {
                        returnValue.append(response)
                    } else if let response = SwaggerResponse(JSON: jsonObject, statusCode: statusCode) {
                        returnValue.append(response)
                    }
                }
            }
            return returnValue
        }
        return nil
    }

    func transformToJSON(_ value: [SwaggerResponse]?) -> Any? {
        if let value = value {
            var json: [String: Any] = [:]
            for response in value {
                json["\(response.statusCode)"] = response.toJSON()
            }
            return json
        }
        return nil
    }
}
