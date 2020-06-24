//
//  SwaggerSchema.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/4/20.
//  Copyright © 2020 Nguyen Truong Luu. All rights reserved.
//

import Foundation
import ObjectMapper

enum SwaggerSchemaResponse {
    case string(content: String)
    case object(content: [String: Any])
    case array(content: [Any])
}

class SwaggerSchema: Mappable {
    var type: String?
    var ref: String?
    var items: [String: Any]?
    var properties: [String: Any]?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        type <- map["type"]
        ref <- map["$ref"]
        items <- map["items"]
        properties <- map["properties"]
    }
    
    func valueFromDefinations(_ definitions: Definitions) -> SwaggerSchemaResponse {
        return valueFromJson(self.toJSON(), definitions: definitions)
    }
    
    private func valueFromReference(_ referenceName: String, definitions: Definitions) -> SwaggerSchemaResponse {
        if let jsonObject = definitions[referenceName] {
            return valueFromJson(jsonObject, definitions: definitions)
        } else {
            return .string(content: "")
        }
    }
    
    private func valueFromJson(_ json: [String: Any], definitions: Definitions) -> SwaggerSchemaResponse {
        if let type = json["type"] as? String {
            switch type {
            case "string":
                return .string(content: json["example"] as? String ?? "string")
            case "integer":
                return .string(content: json["example"] as? String ?? "123")
            case "number":
                return .string(content: json["example"] as? String ?? "12.34")
            case "boolean":
                return .string(content: json["example"] as? String ?? "true")
            case "array":
                var array: [Any] = []
                if let items = json["items"] as? [String: Any] {
                    switch valueFromJson(items, definitions: definitions) {
                    case .string(let content):
                        array.append(contentsOf: (json["example"] as? Array) ?? [content, content, content])
                    case .array(let content):
                        array.append(contentsOf: (json["example"] as? Array) ?? [content, content, content])
                    case .object(let content):
                        array.append(contentsOf: (json["example"] as? Array) ?? [content, content, content])
                    }
                }
                return .array(content: array)
            default:    // Default is object
                var result: [String: Any] = [:]
                let properties: [String: Any] = json["properties"] as? [String : Any] ?? [:]
                for (key, val) in properties {
                    if let jsonObject = val as? [String: Any] {
                        switch valueFromJson(jsonObject, definitions: definitions) {
                        case .string(let content):
                            result[key] = content
                        case .object(let content):
                            result[key] = content
                        case .array(let content):
                            result[key] = content
                        }
                    } else {
                        result[key] = val
                    }
                }
                return .object(content: result)
            }
        } else if let reference = json["$ref"] as? String {
            let referenceName = reference.components(separatedBy: "/").last ?? ""
            return valueFromReference(referenceName, definitions: definitions)
        } else {
            return .string(content: "")
        }
    }
}
