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

public typealias HTTPRequest = Telegraph.HTTPRequest
public typealias HTTPResponse = Telegraph.HTTPResponse
public typealias HTTPStatus = Telegraph.HTTPStatus
public typealias HTTPVersion = Telegraph.HTTPVersion

public protocol MockServerResponseDatasource: class {
    /// The function allows us to customize the response for any request. If this method return nil, the default response will be use.
    /// - Parameters:
    ///   - mockServer: MockServer
    ///   - request: HTTPRequest
    ///   - possibleResponses: Responses are predefined for the request in the swagger json file.
    func mockServer(_ mockServer: MockServer, httpResponseFor request: HTTPRequest, possibleResponses: [HTTPResponse]) -> HTTPResponse?
}

public final class MockServer {
    /// The port which the mock server is running on.
    public let port: Int
    
    /// Json content of swagger definitions
    public let swaggerJson: [String: Any]
    
    /// DataGenerator object which will be used to generate dummy data for HTTPResponse
    public let dataGenerator: DataGenerator
    
    /// Datasource which will provide the custom HTTPResponse
    public weak var responseDatasource: MockServerResponseDatasource?
    
    /// All endpoints the mock server can handle
    public var endPoints: [MockServerEndPoint] {
        return swagger?.endPoints ?? []
    }

    private lazy var server = Server()
    private var swagger: SwaggerJson?
    
    /// Init new Mockserver at port: port with swagger json: swaggerJson
    /// - Parameters:
    ///   - port: Port that server will run on, default is 8080
    ///   - swaggerJson: [String: Any]
    ///   - dataGenerator: DataGenerator
    public init(port: Int = 8080,
                swaggerJson: [String: Any],
                dataGenerator: DataGenerator = DataGenerator())
    {
        self.port = port
        self.swaggerJson = swaggerJson
        self.dataGenerator = dataGenerator
    }
    
    /// Start mock server
    public func start() {
        swagger = SwaggerJson(JSON: swaggerJson, dataGenerator: dataGenerator)
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
            let allEndpoints = swagger.endPoints.sorted(by: { $0.path < $1.path })
            
            for endpoint in allEndpoints {
                print(endpoint.description)
            }
            
            let endpointsHasPathParam = allEndpoints.filter { $0.hasPathParameters }
            let endpointsHasNoPathParam = allEndpoints.filter { !$0.hasPathParameters }
            
            for endpoint in endpointsHasNoPathParam {
                server.route(endpoint.method, endpoint.route) { [weak self] request -> HTTPResponse? in
                    guard let strongSelf = self else { return nil }
                    
                    request.pathParams = MockServer.pathParamsFrom(requestPath: request.uri.path, endpointPath: endpoint.path)
                    if let httpResponse = self?.responseDatasource?.mockServer(strongSelf, httpResponseFor: request,
                                                                               possibleResponses: endpoint.responses.map { swaggerResponse -> HTTPResponse in
                                                                                   let headers = MockServer.headersFor(endpoint: endpoint, swaggerResponse: swaggerResponse)
                                                                                   return HTTPResponse(HTTPStatus(code: swaggerResponse.statusCode, phrase: ""),
                                                                                                       version: request.version,
                                                                                                       headers: headers,
                                                                                                       body: swaggerResponse.responseString?.utf8Data ?? Data())
                                                                               })
                    {
                        return httpResponse
                    } else {
                        let defaultResponse = endpoint.defaultResponse
                        let headers = MockServer.headersFor(endpoint: endpoint, swaggerResponse: defaultResponse)
                        return HTTPResponse(HTTPStatus(code: defaultResponse.statusCode, phrase: ""),
                                            version: request.version,
                                            headers: headers,
                                            body: defaultResponse.responseString?.utf8Data ?? Data())
                    }
                }
            }

            for endpoint in endpointsHasPathParam {
                server.route(endpoint.method, regex: "^" + endpoint.route + "$") { [weak self] request -> HTTPResponse? in
                    guard let strongSelf = self else { return nil }
                    
                    request.pathParams = MockServer.pathParamsFrom(requestPath: request.uri.path, endpointPath: endpoint.path)
                    if let httpResponse = self?.responseDatasource?.mockServer(strongSelf, httpResponseFor: request,
                                                                               possibleResponses: endpoint.responses.map { swaggerResponse -> HTTPResponse in
                                                                                   let headers = MockServer.headersFor(endpoint: endpoint, swaggerResponse: swaggerResponse)
                                                                                   return HTTPResponse(HTTPStatus(code: swaggerResponse.statusCode, phrase: ""),
                                                                                                       version: request.version,
                                                                                                       headers: headers,
                                                                                                       body: swaggerResponse.responseString?.utf8Data ?? Data())
                                                                               })
                    {
                        return httpResponse
                    } else {
                        let defaultResponse = endpoint.defaultResponse
                        let headers = MockServer.headersFor(endpoint: endpoint, swaggerResponse: defaultResponse)
                        return HTTPResponse(HTTPStatus(code: defaultResponse.statusCode, phrase: ""),
                                            version: request.version,
                                            headers: headers,
                                            body: defaultResponse.responseString?.utf8Data ?? Data())
                    }
                }
            }

            server.delegate = self
            server.concurrency = 100
            
            do {
                try server.start(port: port)
            } catch {
                print(error.localizedDescription)
            }
            print("[SERVER]", "Server is running at port \(server.port)")
        } else {
            print("[SERVER]", "Mock server can not start because no json swagger was found")
        }
    }
    
    /// Stop mock server
    public func stop() {
        server.stop()
    }
    
    private static func headersFor(endpoint: MockServerEndPoint, swaggerResponse: SwaggerResponse) -> [HTTPHeaderName: String] {
        var headers: [HTTPHeaderName: String] = [:]
        if let contentType = endpoint.contentType {
            headers[HTTPHeaderName(stringLiteral: "Content-Type")] = contentType
        }
        for (key, val) in swaggerResponse.headersJson {
            headers[HTTPHeaderName(stringLiteral: key)] = val
        }
        return headers
    }
    
    private static func pathParamsFrom(requestPath: String, endpointPath: String) -> [String: String] {
        let requestPathComponents = requestPath.components(separatedBy: "/")
        let endpointPathComponents = endpointPath.components(separatedBy: "/")
        let endpointPathComponentsCount = endpointPathComponents.count
        var pathParams: [String: String] = [:]
        for (idx, requestPathComponent) in requestPathComponents.enumerated() {
            if idx < endpointPathComponentsCount, endpointPathComponents[idx] != requestPathComponent {
                let paramName = endpointPathComponents[idx].replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "")
                pathParams[paramName] = requestPathComponent
            }
        }
        return pathParams
    }
}

// MARK: - ServerDelegate implementation

extension MockServer: ServerDelegate {
    // Raised when the server gets disconnected.
    public func serverDidStop(_ server: Server, error: Error?) {
        print("[SERVER]", "Server stopped:", error?.localizedDescription ?? "")
    }
}

public extension HTTPResponse {
    var statusCode: Int {
        return status.code
    }
}

public extension HTTPRequest {
    private enum AssociatedKeys {
        static var pathParams = "NSObject.HTTPRequestPathParams"
    }
    
    @objc var pathParams: [String: String]? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.pathParams) as? [String: String]
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.pathParams, newValue!, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
