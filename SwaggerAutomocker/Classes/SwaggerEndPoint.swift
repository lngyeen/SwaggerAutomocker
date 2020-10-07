//
//  SwaggerEndPoint.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/4/20.
//  Copyright © 2020 Nguyen Truong Luu. All rights reserved.
//

import Foundation
import ObjectMapper

class SwaggerEndPoint: Mappable {
    var produces: [String] = []
    var parameters: [SwaggerParam] = []
    var responses: [String: SwaggerResponse]?
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
        produces <- map["produces"]
        parameters <- map["parameters"]
        responses <- (map["responses"], ResponsesTransformer())
    }

    func responseDataFromDefications(_ definitions: Definitions) -> String? {
        if responses != nil {
            let defaultRes = defaultResponse()
            return defaultRes.response.responseDataFromDefinations(definitions)
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
                let firstData = responses[firstKey] {
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
            for (key, anyObject) in responses {
                if let jsonObject = anyObject as? [String: Any] {
                    var nestedJsonObject = (jsonObject["content"] as? [String: Any])?["application/json"] as? [String: Any]
                    if case .none = nestedJsonObject {
                        nestedJsonObject = (jsonObject["content"] as? [String: Any])?["*/*"] as? [String: Any]
                    }
                    if let nestedJsonObject = nestedJsonObject {
                        returnValue[key] = SwaggerResponse(JSON: nestedJsonObject)
                    } else {
                        returnValue[key] = SwaggerResponse(JSON: jsonObject)
                    }
                }
            }
            return returnValue
        }
        return nil
    }

    func transformToJSON(_ value: [String: SwaggerResponse]?) -> [String: Any]? {
        if let value = value {
            return value.mapValues { value in
                value.toJSON()
            }
        }
        return nil
    }
}
