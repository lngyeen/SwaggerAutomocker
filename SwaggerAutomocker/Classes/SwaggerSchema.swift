//
//  SwaggerSchema.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/4/20.
//  Copyright © 2020 Nguyen Truong Luu. All rights reserved.
//

import Foundation
import ObjectMapper

public enum SwaggerDataType: String {
    case string
    case integer
    case number
    case boolean
    case array
    case object
    /// Default is object
    
    var formats: [SwaggerSchemaFormatType]? {
        switch self {
        case .string: return [.date, .dateTime, .email,
                              .uuid, .uri, .hostname,
                              .ipv4, .ipv6, .others]
        case .integer: return [.int32, .int64]
        case .number: return [.float, .double]
        case .boolean, .array, .object: return nil
        }
    }
}

public protocol DefaultValuable {
    associatedtype DefaultValueType
    var defaultValue: DefaultValueType { get set }
}

/// Format is an open value, so you can use any formats, even not those defined by the OpenAPI Specification
public enum SwaggerSchemaFormatType: String, CaseIterable {
    /// Numbers
    case float
    case double
    case int32
    case int64
    
    /// String
    case date // full-date notation as defined by RFC 3339, section 5.6, for example, 2017-07-21
    case dateTime // the date-time notation as defined by RFC 3339, section 5.6, for example, 2017-07-21T17:32:28Z
    case password // a hint to UIs to mask the input
    case byte // base64-encoded characters, for example, U3dhZ2dlciByb2Nrcw==
    case binary // binary data, used to describe files
    
    /// Others...
    case email
    case uuid
    case uri
    case hostname
    case ipv4
    case ipv6
    case others
}

enum SwaggerSchemaResponse {
    case string(content: String)
    case integer(content: Int)
    case number(content: Double)
    case boolean(content: Bool)
    case object(content: [String: Any])
    case array(content: [Any])
    case none
}

enum SwaggerSchemaAttribute: String {
    case type
    case format
    case ref = "$ref"
    case items
    case properties
    case additionalProperties
    case example
    case enumValues = "enum"
}

class SwaggerSchema: Mappable {
    var type: String?
    var format: String?
    var ref: String?
    var items: SwaggerSchema?
    var properties: [String: Any]?
    var additionalProperties: [String: Any]?
    var example: Any?

    var minLength: Int? // Appears only if type is string
    var maxLength: Int? // Appears only if type is string
    
    var minimum: Double? // Appears only if type is integer or number
    var maximum: Double? // Appears only if type is integer or number
    
    private var root: Node?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        type <- map[SwaggerSchemaAttribute.type.rawValue]
        format <- map[SwaggerSchemaAttribute.format.rawValue]
        ref <- map[SwaggerSchemaAttribute.ref.rawValue]
        items <- map[SwaggerSchemaAttribute.items.rawValue]
        properties <- map[SwaggerSchemaAttribute.properties.rawValue]
        additionalProperties <- map[SwaggerSchemaAttribute.additionalProperties.rawValue]
        example <- map[SwaggerSchemaAttribute.example.rawValue]
    }
    
    func valueFromDefinitions(_ definitions: Definitions) -> SwaggerSchemaResponse {
        defer {
            if
                MockServer.configuration.enableDebugPrint,
                let json = root?.json,
                let jsonString = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            {
                print(jsonString)
            }
        }
        return valueFromJson(toJSON(), definitions: definitions, currentNode: root)
    }
    
    private func valueFromJson(_ json: [String: Any], for propertyName: String? = nil, definitions: Definitions, currentNode: Node?) -> SwaggerSchemaResponse {
        if let type = json[SwaggerSchemaAttribute.type.rawValue] as? String {
            let value = generateValueFor(type: type, from: json)
            
            switch type {
            case SwaggerDataType.string.rawValue:
                return .string(content: (value as? String) ?? "")
                
            case SwaggerDataType.integer.rawValue:
                return .integer(content: (value as? Int) ?? 0)
                
            case SwaggerDataType.number.rawValue:
                return .number(content: (value as? Double) ?? 0)
                
            case SwaggerDataType.boolean.rawValue:
                return .boolean(content: (value as? Bool) ?? true)
                
            case SwaggerDataType.array.rawValue:
                var array: [Any] = []
                if let arrayExample = value as? [Any] {
                    /// Example in array-level
                    array = arrayExample
                    
                } else if let items = json[SwaggerSchemaAttribute.items.rawValue] as? [String: Any] {
                    /// Example in individual array item
                    if let example = items[SwaggerSchemaAttribute.example.rawValue] {
                        array = [example, example, example]
                    } else {
                        switch valueFromJson(items, definitions: definitions, currentNode: currentNode) {
                        case .string(let content):
                            array.append(contentsOf: (value as? Array) ?? Array(repeating: content, count: MockServer.configuration.defaultArrayElementCount))
                            
                        case .integer(let content):
                            array.append(contentsOf: (value as? Array) ?? Array(repeating: content, count: MockServer.configuration.defaultArrayElementCount))
                            
                        case .number(let content):
                            array.append(contentsOf: (value as? Array) ?? Array(repeating: content, count: MockServer.configuration.defaultArrayElementCount))
                            
                        case .boolean(let content):
                            array.append(contentsOf: (value as? Array) ?? Array(repeating: content, count: MockServer.configuration.defaultArrayElementCount))
                            
                        case .array(let content):
                            array.append(contentsOf: (value as? Array) ?? Array(repeating: content, count: MockServer.configuration.defaultArrayElementCount))
                            
                        case .object(let content):
                            array.append(contentsOf: (value as? Array) ?? Array(repeating: content, count: MockServer.configuration.defaultArrayElementCount))
                            
                        case .none: break
                        }
                    }
                }
                return .array(content: array)
                
            default: // Default is object
                var object: [String: Any] = [:]
                
                /// Example in object-level
                if let example = value as? [String: Any] {
                    object = example
                } else {
                    let properties: [String: Any] = json[SwaggerSchemaAttribute.properties.rawValue] as? [String: Any] ?? [:]
                    for (propertyName, propertyDefinition) in properties {
                        if let jsonObject = propertyDefinition as? [String: Any] {
                            switch valueFromJson(jsonObject, for: propertyName, definitions: definitions, currentNode: currentNode) {
                            case .string(let content):
                                object[propertyName] = content
                                
                            case .integer(let content):
                                object[propertyName] = content
                                
                            case .number(let content):
                                object[propertyName] = content
                                
                            case .boolean(let content):
                                object[propertyName] = content
                                
                            case .object(let content):
                                object[propertyName] = content
                                
                            case .array(let content):
                                object[propertyName] = content
                                
                            case .none: break
                            }
                        } else {
                            object[propertyName] = propertyDefinition
                        }
                    }
                    
                    /// additionalProperties
                    if let propertyName = propertyName,
                       let additionalProperties = json[SwaggerSchemaAttribute.additionalProperties.rawValue] as? [String: Any] {
                        for i in 0..<MockServer.configuration.defaultArrayElementCount {
                            switch valueFromJson(additionalProperties, definitions: definitions, currentNode: currentNode) {
                            case .string(let content):
                                object["\(propertyName)\(i)"] = content
                                
                            case .integer(let content):
                                object["\(propertyName)\(i)"] = content
                                
                            case .number(let content):
                                object["\(propertyName)\(i)"] = content
                                
                            case .boolean(let content):
                                object["\(propertyName)\(i)"] = content
                                
                            case .array(let content):
                                object["\(propertyName)\(i)"] = content
                                
                            case .object(let content):
                                object["\(propertyName)\(i)"] = content
                                
                            case .none: break
                            }
                        }
                    }
                }
                
                return .object(content: object)
            }
        } else if let reference = json[SwaggerSchemaAttribute.ref.rawValue] as? String,
            let referenceName = reference.components(separatedBy: "/").last
        {
            /// Stop creating child objects if there are more than one ancestors of the same type
            guard (currentNode?.ancestors(name: referenceName).count ?? 0) < 2 else { return .none }
            
            let childNode = Node(name: referenceName, parent: currentNode)
            if case .none = root { root = childNode }
            return valueFromReference(referenceName, definitions: definitions, currentNode: childNode)
        } else {
            return .string(content: "")
        }
    }
    
    private func valueFromReference(_ referenceName: String, definitions: Definitions, currentNode: Node) -> SwaggerSchemaResponse {
        if let jsonObject = definitions[referenceName] {
            return valueFromJson(jsonObject, definitions: definitions, currentNode: currentNode)
        } else {
            return .string(content: "")
        }
    }
    
    private func generateValueFor(type: String, from json: [String: Any]) -> Any? {
        /// Get example value
        var value = json[SwaggerSchemaAttribute.example.rawValue]
        
        /// Get value from enums array
        if case .none = value,
           let enumValue = (json[SwaggerSchemaAttribute.enumValues.rawValue] as? [Any])?[safe: 0]
        {
            value = enumValue
        }
        
        /// If has no example value, try to generate default values
        if case .none = value {
            if let format = json[SwaggerSchemaAttribute.format.rawValue] as? String {
                let defaultValue = MockServer.configuration.defaultValuesConfiguration.defaultValueFor(type: format)
                value = defaultValue
            } else {
                switch type {
                case SwaggerDataType.string.rawValue:
                    value = MockServer.configuration.defaultValuesConfiguration.othersDefaultValue
                    
                case SwaggerDataType.integer.rawValue:
                    value = MockServer.configuration.defaultValuesConfiguration.int64DefaultValue
                    
                case SwaggerDataType.number.rawValue:
                    value = MockServer.configuration.defaultValuesConfiguration.doubleDefaultValue
                    
                case SwaggerDataType.boolean.rawValue:
                    value = MockServer.configuration.defaultValuesConfiguration.booleanDefaultValue
                    
                default: break
                }
            }
        }
        
        return value
    }
}

private class Node: NSObject {
    private(set) var name: String
    private(set) var children: Set<Node> = []
    private(set) weak var parent: Node?
    
    var json: [String: Any] {
        if children.isEmpty {
            return [name: ""]
        } else {
            return [name: children.map { $0.json }]
        }
    }
    
    init(name: String, parent: Node?) {
        self.name = name
        super.init()
        self.parent = parent
        self.parent?.children.insert(self)
    }
    
    func ancestors(name: String) -> [Node] {
        var ancestors: [Node] = self.name == name ? [self] : []
        var current = parent
        while current != nil {
            if let current = current, current.name == name {
                ancestors.append(current)
            }
            current = current?.parent
        }
        return ancestors
    }
}

private extension Array {
    subscript(safe index: Int?) -> Element? {
        guard let index = index else { return nil }
        return Int(index) < count ? self[Int(index)] : nil
    }
}
