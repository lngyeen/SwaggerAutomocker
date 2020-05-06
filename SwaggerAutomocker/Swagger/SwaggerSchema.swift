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
            if type == "object" {
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
            } else if type == "string" {
                return json["example"] as? String ?? "string"
            } else if type == "integer" {
                return json["example"] as? String ?? "123"
            } else if type == "number" {
                return json["example"] as? String ?? "12.34"
            } else if type == "boolean" {
                return json["example"] as? String ?? "true"
            } else if type == "array" {
                var array: [Any] = []
                if let items = json["items"] as? [String: Any] {
                    let val = valueFromJson(items, definitions: definitions)
                    array.append(val)
                    array.append(val)
                    array.append(val)
                }
                return array
            } else {
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
