//
//  SwaggerSchema.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/4/20.
//  Copyright © 2020 Nguyen Truong Luu. All rights reserved.
//

import Foundation
import ObjectMapper

enum SwaggerSchemaAttribute: String {
    case type
    case format
    case ref = "$ref"
    case items
    case properties
    case additionalProperties
    case example
    case enumValues = "enum"
    
    /// Number only
    case minimum
    case maximum
    case exclusiveMinimum
    case exclusiveMaximum
}

class SwaggerSchema: Mappable {
    var type: String?
    var format: String?
    var ref: String?
    var items: SwaggerSchema?
    var properties: [String: Any]?
    var additionalProperties: [String: Any]?
    var example: Any?
    var examples: Any?
    
    var minimum: Int?
    var maximum: Int?
    var exclusiveMinimum: Bool?
    var exclusiveMaximum: Bool?
    
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
        
        /// Number only
        minimum <- map[SwaggerSchemaAttribute.minimum.rawValue]
        maximum <- map[SwaggerSchemaAttribute.maximum.rawValue]
        exclusiveMinimum <- map[SwaggerSchemaAttribute.exclusiveMinimum.rawValue]
        exclusiveMaximum <- map[SwaggerSchemaAttribute.exclusiveMaximum.rawValue]
    }
    
    func valueFromDefinitions(_ definitions: Definitions, dataGenerator: DataGenerator) -> SwaggerSchemaResponse {
        root = nil
        return valueFromJson(toJSON(), definitions: definitions, currentNode: root, dataGenerator: dataGenerator)
    }
    
    private func valueFromJson(_ json: [String: Any], for propertyName: String? = nil, definitions: Definitions, currentNode: Node?, dataGenerator: DataGenerator) -> SwaggerSchemaResponse {
        if let type = json[SwaggerSchemaAttribute.type.rawValue] as? String {
            let value = generateValueFor(type: type, from: json, dataGenerator: dataGenerator)
            
            switch type {
            case SwaggerSchemaDataType.string.rawValue:
                return .string(content: (value as? String) ?? "")
                
            case SwaggerSchemaDataType.integer.rawValue:
                return .integer(content: (value as? Int) ?? 0)
                
            case SwaggerSchemaDataType.number.rawValue:
                return .number(content: (value as? Double) ?? 0)
                
            case SwaggerSchemaDataType.boolean.rawValue:
                return .boolean(content: (value as? Bool) ?? true)
                
            case SwaggerSchemaDataType.array.rawValue:
                var array: [Any] = []
                if let arrayExample = value as? [Any] {
                    /// Example in array-level
                    array = arrayExample
                    
                } else if let items = json[SwaggerSchemaAttribute.items.rawValue] as? [String: Any] {
                    /// Example in individual array item
                    if let example = items[SwaggerSchemaAttribute.example.rawValue] {
                        array = [example, example, example]
                    } else {
                        switch valueFromJson(items, for: propertyName, definitions: definitions, currentNode: currentNode, dataGenerator: dataGenerator) {
                        case .string(let content):
                            array.append(contentsOf: (value as? Array) ?? Array(repeating: content, count: dataGenerator.defaultArrayElementCount))
                            
                        case .integer(let content):
                            array.append(contentsOf: (value as? Array) ?? Array(repeating: content, count: dataGenerator.defaultArrayElementCount))
                            
                        case .number(let content):
                            array.append(contentsOf: (value as? Array) ?? Array(repeating: content, count: dataGenerator.defaultArrayElementCount))
                            
                        case .boolean(let content):
                            array.append(contentsOf: (value as? Array) ?? Array(repeating: content, count: dataGenerator.defaultArrayElementCount))
                            
                        case .array(let content):
                            array.append(contentsOf: (value as? Array) ?? Array(repeating: content, count: dataGenerator.defaultArrayElementCount))
                            
                        case .object(let content):
                            array.append(contentsOf: (value as? Array) ?? Array(repeating: content, count: dataGenerator.defaultArrayElementCount))
                            
                        case .none: break
                        }

//                        for _ in 0..<MockServer.dataGenerator.defaultArrayElementCount {
//                            switch valueFromJson(items, for: propertyName, definitions: definitions, currentNode: currentNode) {
//                            case .string(let content):
//                                array.append(content)
//
//                            case .integer(let content):
//                                array.append(content)
//
//                            case .number(let content):
//                                array.append(content)
//
//                            case .boolean(let content):
//                                array.append(content)
//
//                            case .array(let content):
//                                array.append(content)
//
//                            case .object(let content):
//                                array.append(content)
//
//                            case .none: break
//                            }
//                        }
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
                            switch valueFromJson(jsonObject, for: propertyName, definitions: definitions, currentNode: currentNode, dataGenerator: dataGenerator) {
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
                       let additionalProperties = json[SwaggerSchemaAttribute.additionalProperties.rawValue] as? [String: Any]
                    {
                        for i in 1 ... dataGenerator.defaultArrayElementCount {
                            switch valueFromJson(additionalProperties, for: propertyName, definitions: definitions, currentNode: currentNode, dataGenerator: dataGenerator) {
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
            
            let childNode = Node(className: referenceName, propertyName: propertyName ?? "", parent: currentNode)
            if case .none = root { root = childNode }
            return valueFromReference(referenceName, definitions: definitions, currentNode: childNode, dataGenerator: dataGenerator)
        } else {
            return .string(content: "")
        }
    }
    
    private func valueFromReference(_ referenceName: String, definitions: Definitions, currentNode: Node, dataGenerator: DataGenerator) -> SwaggerSchemaResponse {
        if let jsonObject = definitions[referenceName] {
            return valueFromJson(jsonObject, definitions: definitions, currentNode: currentNode, dataGenerator: dataGenerator)
        } else {
            return .string(content: "")
        }
    }
    
    private func generateValueFor(type: String, from json: [String: Any], dataGenerator: DataGenerator) -> Any? {
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
                value = dataGenerator.generateValueFor(format: format, schema: json)
            } else {
                switch type {
                case SwaggerSchemaDataType.string.rawValue:
                    value = dataGenerator.othersDefaultValue
                    
                case SwaggerSchemaDataType.integer.rawValue:
                    value = dataGenerator.int64DefaultValue
                    
                case SwaggerSchemaDataType.number.rawValue:
                    value = dataGenerator.doubleDefaultValue
                    
                case SwaggerSchemaDataType.boolean.rawValue:
                    value = dataGenerator.booleanDefaultValue
                    
                default: break
                }
            }
        }
        
        return value
    }
}

private class Node: NSObject {
    
    private(set) var className: String
    private(set) var propertyName: String
    private(set) var children: Set<Node> = []
    private(set) weak var parent: Node?
    
    var json: [String: Any] {
        if children.isEmpty {
            return ["\(propertyName) - \(className)": ""]
        } else {
            return ["\(propertyName) - \(className)": children.map { $0.json }]
        }
    }
    
    init(className: String, propertyName: String, parent: Node?) {
        self.className = className
        self.propertyName = propertyName
        super.init()
        self.parent = parent
        self.parent?.children.insert(self)
    }
    
    func ancestors(name: String) -> [Node] {
        var ancestors: [Node] = self.className == name ? [self] : []
        var current = parent
        while current != nil {
            if let current = current, current.className == name {
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
