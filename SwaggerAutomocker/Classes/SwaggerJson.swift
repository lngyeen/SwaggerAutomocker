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

enum SwaggerJsonAttribute {
    static var openapi: String { "openapi" }
    static var swagger: String { "swagger" }
    static var basePath: String { "basePath" }
    static var paths: String { "paths" }
    static var definitions: String { "definitions" } // swagger 2.0
    static var schemas: String { "components.schemas" } // open api 3.0
}

public final class SwaggerJson: Mappable {
    var openapi: String?
    var swagger: String?
    var basePath: String?
    var paths: [String: [String: SwaggerEndpoint]]?
    var definitions: Definitions?
    var dataGenerator = DataGenerator()

    convenience init?(JSON: [String: Any], dataGenerator: DataGenerator) {
        guard !JSON.isEmpty else { return nil }
        self.init(JSON: JSON)
        self.dataGenerator = dataGenerator
    }

    public required init?(map: Map) {}
    public func mapping(map: Map) {
        swagger <- map[SwaggerJsonAttribute.swagger]
        openapi <- map[SwaggerJsonAttribute.openapi]
        basePath <- map[SwaggerJsonAttribute.basePath]
        paths <- (map[SwaggerJsonAttribute.paths], PathsTransformer())
        if case .some = swagger {
            definitions <- map[SwaggerJsonAttribute.definitions]
        } else if case .some = openapi {
            definitions <- map[SwaggerJsonAttribute.schemas]
        }
    }

    lazy var endpoints: [MockServerEndpoint] = {
        if let paths = paths {
            var endpoints: [MockServerEndpoint] = []
            for (path, jsonPath) in paths {
                for (method, swaggerEndpoint) in jsonPath {
                    for response in swaggerEndpoint.responses { response.swagger = self }
                    let endpoint = MockServerEndpoint(method: method.uppercased(),
                                                      path: (basePath ?? "") + path,
                                                      parameters: swaggerEndpoint.parameters,
                                                      contentType: swaggerEndpoint.contentType,
                                                      responses: swaggerEndpoint.responses.sorted(by: { $0.statusCode < $1.statusCode }))
                    endpoints.append(endpoint)
                }
            }
            return endpoints
        }
        return []
    }()
}

private class PathsTransformer: TransformType {
    func transformFromJSON(_ value: Any?) -> [String: [String: SwaggerEndpoint]]? {
        if let definitions = value as? [String: [String: Any]] {
            var returnValue: [String: [String: SwaggerEndpoint]] = [:]

            for (key, value) in definitions {
                var stringJsonEndpoint: [String: SwaggerEndpoint] = [:]

                if let mapStringJsonObject = value as? [String: [String: Any]] {
                    for (string, jsonObject) in mapStringJsonObject {
                        stringJsonEndpoint[string] = SwaggerEndpoint(JSON: jsonObject)
                    }

                    returnValue[key] = stringJsonEndpoint
                }
            }
            return returnValue
        }
        return nil
    }

    func transformToJSON(_ value: [String: [String: SwaggerEndpoint]]?) -> [String: Any]? {
        if let value = value {
            return value.mapValues { $0.mapValues { $0.toJSON() } }
        }
        return nil
    }
}
