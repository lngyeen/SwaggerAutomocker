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

public final class SwaggerJson: Mappable {
    var openapi: String?
    var swagger: String?
    var basePath: String?
    var paths: [String: [String: SwaggerEndPoint]]?
    var definitions: Definitions?
    var dataGenerator = DataGenerator()

    convenience init?(JSON: [String: Any], dataGenerator: DataGenerator) {
        self.init(JSON: JSON)
        self.dataGenerator = dataGenerator
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

    lazy var endPoints: [MockServerEndPoint] = {
        if let paths = paths {
            var endPoints: [MockServerEndPoint] = []
            for (path, jsonPath) in paths {
                for (method, swaggerEndPoint) in jsonPath {
                    for response in swaggerEndPoint.responses { response.swagger = self }
                    let endpoint = MockServerEndPoint(method: method.uppercased(),
                                                      path: (basePath ?? "") + path,
                                                      parameters: swaggerEndPoint.parameters,
                                                      contentType: swaggerEndPoint.contentType,
                                                      responses: swaggerEndPoint.responses.sorted(by: { $0.statusCode < $1.statusCode }))
                    endPoints.append(endpoint)
                }
            }
            return endPoints
        }
        return []
    }()
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
