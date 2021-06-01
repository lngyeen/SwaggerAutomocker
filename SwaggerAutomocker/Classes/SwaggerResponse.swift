//
//  SwaggerResponse.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/4/20.
//  Copyright © 2020 Nguyen Truong Luu. All rights reserved.
//

import Foundation
import ObjectMapper

enum SwaggerResponseAttribute {
    static var headers: String { "headers" }
    static var schema: String { "schema" }
    static var example: String { "example" }
    static var examples: String { "examples" }
}

public class SwaggerResponse: Mappable {
    public private(set) var statusCode: Int = 204
    public var headersJson: [String: String] {
        return headers?.mapValues { $0.value } ?? [:]
    }

    public var responseString: String? {
        guard let swagger = swagger else { return nil }
        if swagger.dataGenerator.generateDummyDataLazily {
            return responseFromDefinitions(swagger.definitions, using: swagger.dataGenerator)
        } else {
            if case .none = _responseString {
                _responseString = responseFromDefinitions(swagger.definitions, using: swagger.dataGenerator)
            }
            return _responseString
        }
    }
    
    var headers: [String: SwaggerHeader]?
    var schema: SwaggerSchema?
    var example: Any?
    var examples: [String: Any]?
    weak var swagger: SwaggerJson?
    
    private var _responseString: String?
    
    init() {}
    convenience init?(JSON: [String: Any], statusCode: Int) {
        self.init(JSON: JSON)
        self.statusCode = statusCode
    }

    public required init?(map: Map) {}
    public func mapping(map: Map) {
        headers <- (map[SwaggerResponseAttribute.headers], HeadersTransformer())
        schema <- map[SwaggerResponseAttribute.schema]
        example <- map[SwaggerResponseAttribute.example]
        examples <- map[SwaggerResponseAttribute.examples]
    }

    func responseFromDefinitions(_ definitions: Definitions?, using dataGenerator: DataGenerator) -> String? {
        guard let schema = schema else { return nil }
        
        if let responseStringFromExamples = responseStringFromExamples(type: schema.type, arrayEmelementCount: dataGenerator.rootArrayElementCount) {
            return responseStringFromExamples
        }
        
        if let definitions = definitions {
            let responseData = schema.valueFromDefinitions(definitions, dataGenerator: dataGenerator)
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
        }
        
        return nil
    }
    
    private func responseStringFromExamples(type: String?, arrayEmelementCount: Int) -> String? {
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
                array = responseArrayFromExample(example, elementCount: arrayEmelementCount)
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
    
    private func responseArrayFromExample(_ example: Any, elementCount: Int) -> [Any] {
        if let string = example as? String {
            return Array(repeating: string, count: elementCount)
        }
        
        if let integer = example as? Int {
            return Array(repeating: integer, count: elementCount)
        }
        
        if let number = example as? Double {
            return Array(repeating: number, count: elementCount)
        }
        
        if let boolean = example as? Bool {
            return Array(repeating: boolean, count: elementCount)
        }
        
        if let object = example as? [String: Any] {
            return Array(repeating: object, count: elementCount)
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
