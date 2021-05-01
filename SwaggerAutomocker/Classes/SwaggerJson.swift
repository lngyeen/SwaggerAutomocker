//
//  SwaggerJson.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/4/20.
//  Copyright © 2020 Nguyen Truong Luu. All rights reserved.
//

import Foundation
import ObjectMapper

typealias Definitions = [String: [String: Any]]

enum SwaggerJsonAttribute: String {
    case openapi
    case swagger
    case basePath
    case paths
    case definitions // swagger 2.0
    case schemas = "components.schemas" // open api 3.0
}

public class SwaggerJson: Mappable {
    var openapi: String?
    var swagger: String?
    var basePath: String?
    var paths: [String: [String: SwaggerEndPoint]]?
    var definitions: Definitions?
    
    var endPoints: [EndPoint] {
        if let paths = paths {
            var endPoints: [EndPoint] = []
            for (path, jsonPath) in paths {
                for (method, swaggerEndPoint) in jsonPath {
                    let endpoint = EndPoint(method: method.uppercased(),
                                            path: (basePath ?? "") + path,
                                            swaggerEndPoint: swaggerEndPoint,
                                            definitions: definitions)
                    endPoints.append(endpoint)
                }
            }
            return endPoints
        }
        return []
    }

    public required init?(map: Map) {}
    public func mapping(map: Map) {
        swagger <- map[SwaggerJsonAttribute.swagger.rawValue]
        openapi <- map[SwaggerJsonAttribute.openapi.rawValue]
        basePath <- map[SwaggerJsonAttribute.basePath.rawValue]
        paths <- (map[SwaggerJsonAttribute.paths.rawValue], PathsTransformer())
        if case .some = swagger {
            definitions <- map[SwaggerJsonAttribute.definitions.rawValue]
        } else if case .some = openapi {
            definitions <- map[SwaggerJsonAttribute.schemas.rawValue]
        }
    }
}

private class PathsTransformer: TransformType {
    func transformFromJSON(_ value: Any?) -> [String: [String: SwaggerEndPoint]]? {
        if let definitions = value as? [String: [String: Any]] {
            var returnValue: [String: [String: SwaggerEndPoint]] = [:]
            
            for (key, value) in definitions {
                var stringJsonEndPoint: [String: SwaggerEndPoint] = [:]
                
                if let mapStringJsonObject = value as? [String: [String: Any]] {
                    for (string, jsonObject) in mapStringJsonObject {
                        stringJsonEndPoint[string] = SwaggerEndPoint(JSON: jsonObject)
                    }
                    
                    returnValue[key] = stringJsonEndPoint
                }
            }
            return returnValue
        }
        return nil
    }

    func transformToJSON(_ value: [String: [String: SwaggerEndPoint]]?) -> [String: Any]? {
        if let value = value {
            return value.mapValues { $0.mapValues { $0.toJSON() } }
        }
        return nil
    }
}
