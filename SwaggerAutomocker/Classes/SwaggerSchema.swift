//
//  SwaggerSchema.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/4/20.
//  Copyright © 2020 Nguyen Truong Luu. All rights reserved.
//

import Foundation
import ObjectMapper

enum SwaggerSchemaAttribute {
    static var type: String { "type" }
    static var format: String { "format" }
    static var ref: String { "$ref" }
    static var items: String { "items" }
    static var properties: String { "properties" }
    static var additionalProperties: String { "additionalProperties" }
    static var example: String { "example" }
    static var `enum`: String { "enum" }
    
    /// Number only
    static var minimum: String { "minimum" }
    static var maximum: String { "maximum" }
    static var exclusiveMinimum: String { "exclusiveMinimum" }
    static var exclusiveMaximum: String { "exclusiveMaximum" }
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
    private var topLevelIsArray = false
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        type <- map[SwaggerSchemaAttribute.type]
        format <- map[SwaggerSchemaAttribute.format]
        ref <- map[SwaggerSchemaAttribute.ref]
        items <- map[SwaggerSchemaAttribute.items]
        properties <- map[SwaggerSchemaAttribute.properties]
        additionalProperties <- map[SwaggerSchemaAttribute.additionalProperties]
        example <- map[SwaggerSchemaAttribute.example]
        
        /// Number only
        minimum <- map[SwaggerSchemaAttribute.minimum]
        maximum <- map[SwaggerSchemaAttribute.maximum]
        exclusiveMinimum <- map[SwaggerSchemaAttribute.exclusiveMinimum]
        exclusiveMaximum <- map[SwaggerSchemaAttribute.exclusiveMaximum]
    }
    
    func valueFromDefinitions(_ definitions: Definitions, dataGenerator: DataGenerator) -> SwaggerSchemaResponse {
        root = nil
        topLevelIsArray = false
        return valueFromJson(toJSON(), definitions: definitions, currentNode: root, dataGenerator: dataGenerator)
    }
    
    private func valueFromJson(_ json: [String: Any], for propertyName: String? = nil, definitions: Definitions, currentNode: Node?, dataGenerator: DataGenerator) -> SwaggerSchemaResponse {
        if let type = json[SwaggerSchemaAttribute.type] as? String {
            let value = generateValueFor(type: type, from: json, dataGenerator: dataGenerator)
            
            switch type {
            case SwaggerSchemaDataType.string.rawValue:
                return .string(content: (value as? String) ?? "")
                
            case SwaggerSchemaDataType.integer.rawValue:
                var int: Int = (value as? Int) ?? 0
                if let int32 = value as? Int32 {
                    int = Int(int32)
                } else if let int64 = value as? Int64 {
                    int = Int(truncatingIfNeeded: int64)
                }
                return .integer(content: int)
                
            case SwaggerSchemaDataType.number.rawValue:
                var double: Double = (value as? Double) ?? 0
                if let float = value as? Float {
                    double = Double("\(float)") ?? 0
                }
                return .number(content: double)
                
            case SwaggerSchemaDataType.boolean.rawValue:
                return .boolean(content: (value as? Bool) ?? true)
                
            case SwaggerSchemaDataType.array.rawValue:
                var array: [Any] = []
                if let arrayExample = value as? [Any] {
                    /// Example in array-level
                    array = arrayExample
                    
                } else if let items = json[SwaggerSchemaAttribute.items] as? [String: Any] {
                    /// Example in individual array item
                    let elementCount = (currentNode?.isRoot ?? true && !topLevelIsArray) ? dataGenerator.rootArrayElementCount : dataGenerator.childArrayElementCount
                    topLevelIsArray = true
                    
                    if let example = items[SwaggerSchemaAttribute.example] {
                        array = Array(repeating: example, count: elementCount)
                    } else {
                        if dataGenerator.distinctElementsInArray {
                            for _ in 0 ..< elementCount {
                                switch valueFromJson(items, for: propertyName, definitions: definitions, currentNode: currentNode, dataGenerator: dataGenerator) {
                                case .string(let content):
                                    array.append(content)
                                    
                                case .integer(let content):
                                    array.append(content)
                                    
                                case .number(let content):
                                    array.append(content)
                                    
                                case .boolean(let content):
                                    array.append(content)
                                    
                                case .array(let content):
                                    array.append(content)
                                    
                                case .object(let content):
                                    array.append(content)
                                    
                                case .none: break
                                }
                            }
                        } else {
                            switch valueFromJson(items, for: propertyName, definitions: definitions, currentNode: currentNode, dataGenerator: dataGenerator) {
                            case .string(let content):
                                array.append(contentsOf: (value as? Array) ?? Array(repeating: content, count: elementCount))
                                
                            case .integer(let content):
                                array.append(contentsOf: (value as? Array) ?? Array(repeating: content, count: elementCount))
                                
                            case .number(let content):
                                array.append(contentsOf: (value as? Array) ?? Array(repeating: content, count: elementCount))
                                
                            case .boolean(let content):
                                array.append(contentsOf: (value as? Array) ?? Array(repeating: content, count: elementCount))
                                
                            case .array(let content):
                                array.append(contentsOf: (value as? Array) ?? Array(repeating: content, count: elementCount))
                                
                            case .object(let content):
                                array.append(contentsOf: (value as? Array) ?? Array(repeating: content, count: elementCount))
                                
                            case .none: break
                            }
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
                    let properties: [String: Any] = json[SwaggerSchemaAttribute.properties] as? [String: Any] ?? [:]
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
                       let additionalProperties = json[SwaggerSchemaAttribute.additionalProperties] as? [String: Any]
                    {
                        let elementCount = (currentNode?.isRoot ?? true && !topLevelIsArray) ? dataGenerator.rootArrayElementCount : dataGenerator.childArrayElementCount
                        for i in 1 ... elementCount {
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
        } else if let reference = json[SwaggerSchemaAttribute.ref] as? String,
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
        var value = json[SwaggerSchemaAttribute.example]
        
        /// Get value from enums array
        if case .none = value,
           let enumValues = json[SwaggerSchemaAttribute.enum] as? [Any]
        {
            value = dataGenerator.distinctElementsInArray ? enumValues.randomElement() : enumValues[safe: 0]
        }
        
        /// If has no example value, try to generate default values
        if case .none = value {
            if let format = json[SwaggerSchemaAttribute.format] as? String {
                value = dataGenerator.generateValueFor(format: format, schema: json)
            } else {
                switch type {
                case SwaggerSchemaDataType.string.rawValue:
                    value = dataGenerator.defaultDataConfigurator.othersDefaultValue
                    
                case SwaggerSchemaDataType.integer.rawValue:
                    value = dataGenerator.defaultDataConfigurator.int64DefaultValue
                    
                case SwaggerSchemaDataType.number.rawValue:
                    value = dataGenerator.defaultDataConfigurator.doubleDefaultValue
                    
                case SwaggerSchemaDataType.boolean.rawValue:
                    value = dataGenerator.defaultDataConfigurator.booleanDefaultValue
                    
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
    var isRoot: Bool {
        return parent == nil
    }

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
        var ancestors: [Node] = className == name ? [self] : []
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
