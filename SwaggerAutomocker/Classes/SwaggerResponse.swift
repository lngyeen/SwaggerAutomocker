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
    case example
    case examples
}

class SwaggerResponse: Mappable {
    var headers: [String: SwaggerHeader]?
    var schema: SwaggerSchema?
    var example: Any?
    var examples: [String: Any]?
    var headersJson: [String: String] {
        return headers?.mapValues { $0.value } ?? [:]
    }

    init() {}
    required init?(map: Map) {}
    func mapping(map: Map) {
        headers <- (map[SwaggerResponseAttribute.headers.rawValue], HeadersTransformer())
        schema <- map[SwaggerResponseAttribute.schema.rawValue]
        example <- map[SwaggerResponseAttribute.example.rawValue]
        examples <- map[SwaggerResponseAttribute.examples.rawValue]
    }

    func responseFromDefinitions(_ definitions: Definitions) -> String? {
        guard let schema = schema else { return nil }
        if let responseStringFromExamples = responseStringFromExamples(type: schema.type) {
            return responseStringFromExamples
        }
        
        let responseData = schema.valueFromDefinitions(definitions)
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
    }
    
    private func responseStringFromExamples(type: String?) -> String? {
        switch type {
        case SwaggerSchemaDataType.string.rawValue:
            if let string = example as? String {
                return string
            }
            
        case SwaggerSchemaDataType.integer.rawValue:
            if let integer = example as? Int {
                return String(integer)
            }
            
        case SwaggerSchemaDataType.number.rawValue:
            if let number = example as? Double {
                return String(number)
            }
            
        case SwaggerSchemaDataType.boolean.rawValue:
            if let boolean = example as? Bool {
                return String(boolean)
            }
            
        case SwaggerSchemaDataType.array.rawValue:
            var array: [Any] = []
            if let examples = examples,
               !examples.values.isEmpty
            {
                array = Array(examples.values)
            } else if let example = example {
                array = responseArrayFromExample(example)
            }
            
            if !array.isEmpty,
               let jsonData = try? JSONSerialization.data(
                   withJSONObject: array,
                   options: [.prettyPrinted, .fragmentsAllowed]),
               let response = String(data: jsonData, encoding: .ascii)
            {
                return response
            }
            
        default: // Default is object
            if let object = example as? [String: Any],
               !object.isEmpty,
               let jsonData = try? JSONSerialization.data(
                   withJSONObject: object,
                   options: [.prettyPrinted, .fragmentsAllowed])
            {
                return String(data: jsonData, encoding: .ascii)
            }
        }
        
        return nil
    }
    
    private func responseArrayFromExample(_ example: Any) -> [Any] {
        if let string = example as? String {
            return Array(repeating: string, count: MockServer.configuration.defaultArrayElementCount)
        }
        
        if let integer = example as? Int {
            return Array(repeating: integer, count: MockServer.configuration.defaultArrayElementCount)
        }
        
        if let number = example as? Double {
            return Array(repeating: number, count: MockServer.configuration.defaultArrayElementCount)
        }
        
        if let boolean = example as? Bool {
            return Array(repeating: boolean, count: MockServer.configuration.defaultArrayElementCount)
        }
        
        if let object = example as? [String: Any] {
            return Array(repeating: object, count: MockServer.configuration.defaultArrayElementCount)
        }
        
        return []
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
