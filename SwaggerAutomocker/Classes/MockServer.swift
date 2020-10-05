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
    public let server: Server = Server()
    private(set) var swagger: SwaggerJson?
    
    public init(port: Int, swaggerJson: [String: Any]) {
        self.port = port
        self.swaggerJson = swaggerJson
    }
    
    public func start() {
        swagger = SwaggerJson.init(JSON: swaggerJson)
        if let swagger = swagger {
            
            /*
            Suppose we have 2 endpoints: "GET: /user/{username}" and "GET: /user/login".
            
            The problem is that the Telegraph confuses these two endpoints,
            so it is preferable to select the first match response closure in the queue for processing.
            
            Then if we add endpoint "GET: /user/{username}" first, and call endpoint "GET: /user/login",
            Telegraph will execute closure of endpoint "GET: /user/{username}", resulting in incorrect return data.
            
            To solve this problem we have to add enpoints that has no path prams first and then add endpoints that has path prams later to the Telegraph.
            */
            
            let endpointsHasPathParam = swagger.endPoints.filter({$0.hasPathParameters})
            let endpointsHasNoPathParam = swagger.endPoints.filter({!$0.hasPathParameters})
            for endpoint in endpointsHasNoPathParam {
                server.route(endpoint.method, endpoint.path) { (request) -> HTTPResponse? in
                    var headers: [HTTPHeaderName: String] = [:]
                    if let contentType = endpoint.contentType {
                        headers[HTTPHeaderName(stringLiteral: "Content-Type")] = contentType
                    }
                    for (key, val) in endpoint.headers {
                        headers[HTTPHeaderName(stringLiteral: key)] = val
                    }
                    return HTTPResponse(HTTPStatus(code: endpoint.statusCode, phrase: ""), headers: headers, body: endpoint.responseData?.utf8Data ?? Data())
                }
            }

            for endpoint in endpointsHasPathParam {
                server.route(endpoint.method, regex: "^" + endpoint.route + "$") { (request) -> HTTPResponse? in
                    var headers: [HTTPHeaderName: String] = [:]
                    if let contentType = endpoint.contentType {
                        headers[HTTPHeaderName(stringLiteral: "Content-Type")] = contentType
                    }
                    for (key, val) in endpoint.headers {
                        headers[HTTPHeaderName(stringLiteral: key)] = val
                    }
                    return HTTPResponse(HTTPStatus(code: endpoint.statusCode, phrase: ""), headers: headers, body: endpoint.responseData?.utf8Data ?? Data())
                }
            }

            server.delegate = self
            server.concurrency = 100
            do {
                try server.start(port: port)
            } catch let error {
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

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}

extension Array {
    subscript (safe index: Int?) -> Element? {
        guard let index = index else { return nil }
        return Int(index) < count ? self[Int(index)] : nil
    }
}

// MARK: - ServerDelegate implementation
extension MockServer: ServerDelegate {
    // Raised when the server gets disconnected.
    public func serverDidStop(_ server: Server, error: Error?) {
        print("[SERVER]", "Server stopped:", error?.localizedDescription ?? "no details")
    }
}


