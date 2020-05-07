//
//  SwaggerSchema.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/4/20.
//  Copyright © 2020 Nguyen Truong Luu. All rights reserved.
//

import Foundation
import ObjectMapper

class SwaggerSchema: Mappable {
    var type: String?
    var ref: String?
    var items: [String: Any]?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        type <- map["type"]
        ref <- map["$ref"]
        items <- map["items"]
    }
    
    func valueFromDefinations(_ definitions: Definitions) -> Any {
        return valueFromJson(self.toJSON(), definitions: definitions)
    }
    
    private func valueFromRef(_ ref: String, definitions: Definitions) -> Any {
        if let jsonObject = definitions[ref] {
            return valueFromJson(jsonObject, definitions: definitions)
        } else {
            return ""
        }
    }
    
    private func valueFromJson(_ json: [String: Any], definitions: Definitions) -> Any {
        if let type = json["type"] as? String {
            switch type {
            case "object":
                var result: [String: Any] = [:]
                let properties: [String: Any] = json["properties"] as? [String : Any] ?? [:]
                for (key, val) in properties {
                    if let jsonObject = val as? [String: Any] {
                        result[key] = valueFromJson(jsonObject, definitions: definitions)
                    } else {
                        result[key] = val
                    }
                }
                return result
            case "string":
                return json["example"] as? String ?? "string"
            case "integer":
                return json["example"] as? String ?? "123"
            case "number":
                return json["example"] as? String ?? "12.34"
            case "boolean":
                return json["example"] as? String ?? "true"
            case "array":
                var array: [Any] = []
                if let items = json["items"] as? [String: Any] {
                    let val = valueFromJson(items, definitions: definitions)
                    array.append(val)
                    array.append(val)
                    array.append(val)
                }
                return array
            default:
                return ""
            }
        } else if let reference = json["$ref"] as? String {
            let jsonReferenceName = reference.replacingOccurrences(of: "#/definitions/", with: "")
            return valueFromRef(jsonReferenceName, definitions: definitions)
        } else {
            return ""
        }
    }
}
