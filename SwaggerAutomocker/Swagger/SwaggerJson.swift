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

class SwaggerJson: Mappable {
    var basePath: String?
    var paths: [String: [String: SwaggerEndPoint]]?
    var definitions: Definitions?
    var endPoints: [EndPoint] {
        if let paths = paths {
            var endPoints: [EndPoint] = []
            for (path, jsonPath) in paths {
                for (method, jsonEndPoint) in jsonPath {
                    let endpoint = EndPoint(method: method.uppercased(),
                                            path: String(format: "%@%@", basePath ?? "", path),
                                            contentType: jsonEndPoint.contentType,
                                            statusCode: jsonEndPoint.responseCode,
                                            headers: jsonEndPoint.headers,
                                            params: jsonEndPoint.parameters,
                                            responseData: (definitions != nil ? jsonEndPoint.responseDataFromDefications(definitions!) : nil))
                    endPoints.append(endpoint)
                }
            }
            return endPoints
        }
        return []
    }
    
    public required init?(map: Map) {}
    public func mapping(map: Map) {
        basePath <- map["basePath"]
        paths <- (map["paths"], PathsTransformer())
        definitions <- map["definitions"]
    }
}

private class PathsTransformer: TransformType {
    func transformFromJSON(_ value: Any?) -> [String: [String: SwaggerEndPoint]]? {
        if let definations = value as? [String: [String: Any]] {
            var returnValue: [String: [String: SwaggerEndPoint]] = [:]
            for (key, value) in definations {
                var stringJsonEndPoint: [String: SwaggerEndPoint] = [:]
                if let mapStringJsonObject = value as? [String: [String: Any]] {
                    for (string, jsonObject) in mapStringJsonObject {
                        stringJsonEndPoint[string] = SwaggerEndPoint.init(JSON: jsonObject)
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
            return value.mapValues { v in
                return v.mapValues { value in
                    return value.toJSON()
                }
            }
        }
        return nil
    }
}
