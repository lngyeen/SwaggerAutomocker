//
//  MockServer.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/5/20.
//  Copyright © 2020 Nguyen Truong Luu. All rights reserved.
//

import Foundation
import ObjectMapper
import Telegraph

public class MockServer {
    public let port: Int
    public let swaggerJson: [String: Any]
    public let dataGenerator: DataGenerator
    public let server = Server()
    private var swagger: SwaggerJson?
    
    public init(port: Int = 8080,
                swaggerJson: [String: Any],
                dataGenerator: DataGenerator = DataGenerator())
    {
        self.port = port
        self.swaggerJson = swaggerJson
        self.dataGenerator = dataGenerator
    }
    
    public func start() {
        swagger = SwaggerJson(JSON: swaggerJson)
        if let swagger = swagger {
            /*
             Suppose we have 2 endpoints: "GET: /user/{username}" and "GET: /user/login".
            
             The problem is that the Telegraph confuses these two endpoints,
             so it is preferable to select the first match response closure in the queue for processing.
            
             Then if we add endpoint "GET: /user/{username}" first, and call endpoint "GET: /user/login",
             Telegraph will execute closure of endpoint "GET: /user/{username}", resulting in incorrect return data.
            
             To solve this problem we have to add enpoints that has no path prams first and then add endpoints that has path prams later to the Telegraph.
             */
            
            print("[SERVER]", "Server is preparing the endpoints")
            let allEndpoints = swagger.endPoints(dataGenerator: dataGenerator).sorted(by: { $0.path < $1.path })
            
            for endpoint in allEndpoints {
                print(endpoint.description)
            }
            
            let endpointsHasPathParam = allEndpoints.filter { $0.hasPathParameters }
            let endpointsHasNoPathParam = allEndpoints.filter { !$0.hasPathParameters }
            
            for endpoint in endpointsHasNoPathParam {
                server.route(endpoint.method, endpoint.route) { (_) -> HTTPResponse? in
                    
                    var headers: [HTTPHeaderName: String] = [:]
                    
                    if let contentType = endpoint.contentType {
                        headers[HTTPHeaderName(stringLiteral: "Content-Type")] = contentType
                    }
                    
                    for (key, val) in endpoint.headers {
                        headers[HTTPHeaderName(stringLiteral: key)] = val
                    }
                    
                    return HTTPResponse(HTTPStatus(code: endpoint.statusCode, phrase: ""), headers: headers, body: endpoint.responseString?.utf8Data ?? Data())
                }
            }

            for endpoint in endpointsHasPathParam {
                server.route(endpoint.method, regex: "^" + endpoint.route + "$") { (_) -> HTTPResponse? in
                    
                    var headers: [HTTPHeaderName: String] = [:]
                    
                    if let contentType = endpoint.contentType {
                        headers[HTTPHeaderName(stringLiteral: "Content-Type")] = contentType
                    }
                    
                    for (key, val) in endpoint.headers {
                        headers[HTTPHeaderName(stringLiteral: key)] = val
                    }
                    
                    return HTTPResponse(HTTPStatus(code: endpoint.statusCode, phrase: ""), headers: headers, body: endpoint.responseString?.utf8Data ?? Data())
                }
            }

            server.delegate = self
            server.concurrency = 100
            
            do {
                try server.start(port: port)
            } catch {
                print(error.localizedDescription)
            }
            print("[SERVER]", "Server is running")
        } else {
            print("[SERVER]", "Mock server can not start because no json swagger was found")
        }
    }
    
    public func stop() {
        server.stop()
    }
}

// MARK: - ServerDelegate implementation

extension MockServer: ServerDelegate {
    // Raised when the server gets disconnected.
    public func serverDidStop(_ server: Server, error: Error?) {
        print("[SERVER]", "Server stopped:", error?.localizedDescription ?? "")
    }
}
