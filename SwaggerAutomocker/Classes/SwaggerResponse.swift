//
//  SwaggerResponse.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/4/20.
//  Copyright © 2020 Nguyen Truong Luu. All rights reserved.
//

import Foundation
import ObjectMapper

enum SwaggerResponseAttribute: String {
    case headers
    case schema
}

class SwaggerResponse: Mappable {
    var headers: [String: SwaggerHeader]?
    var schema: SwaggerSchema?
    var headersJson: [String: String] {
        return headers?.mapValues { $0.value } ?? [:]
    }

    init() {}
    required init?(map: Map) {}
    func mapping(map: Map) {
        headers <- (map[SwaggerResponseAttribute.headers.rawValue], HeadersTransformer())
        schema <- map[SwaggerResponseAttribute.schema.rawValue]
    }

    func responseStringFromDefinitions(_ definitions: Definitions) -> String? {
        if let responseData = schema?.valueFromDefinitions(definitions) {
            switch responseData {
            case .string(let content):
                return content
                
            case .integer(let content):
                return String(content)
                
            case .number(let content):
                return String(content)
                
            case .boolean(let content):
                return String(content)
                
            case .object(let content):
                if !content.isEmpty, let jsonData = try? JSONSerialization.data(
                    withJSONObject: content,
                    options: [.prettyPrinted, .fragmentsAllowed])
                {
                    return String(data: jsonData, encoding: .ascii)
                }
                
            case .array(let content):
                if let jsonData = try? JSONSerialization.data(
                    withJSONObject: content,
                    options: [.prettyPrinted, .fragmentsAllowed])
                {
                    return String(data: jsonData, encoding: .ascii)
                }
                
            case .none:
                return nil
            }
            
            return nil
        } else {
            return nil
        }
    }
}

private class HeadersTransformer: TransformType {
    func transformFromJSON(_ value: Any?) -> [String: SwaggerHeader]? {
        if let headers = value as? [String: Any] {
            var returnValue: [String: SwaggerHeader] = [:]
            
            for (key, anyObject) in headers {
                if let jsonObject = anyObject as? [String: Any] {
                    returnValue[key] = SwaggerHeader(JSON: jsonObject)
                }
            }
            return returnValue
        }
        return nil
    }

    func transformToJSON(_ value: [String: SwaggerHeader]?) -> [String: Any]? {
        if let value = value {
            return value.mapValues { $0.toJSON() }
        }
        return nil
    }
}
