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

public protocol MockServerResponseDataSource: class {
    /// The function allows us to customize the response for any request. If this method return nil, the default response will be use.
    /// - Parameters:
    ///   - mockServer: MockServer
    ///   - request: HTTPRequest
    ///   - possibleResponses: Responses are predefined for the request in the swagger json file.
    func mockServer(_ mockServer: MockServer, responseFor request: HTTPRequest, possibleResponses: [HTTPResponse]) -> HTTPResponse?
}

public final class MockServer {
    /// The port which the mock server is running on.
    public let port: Int
    
    /// DataGenerator object which will be used to generate dummy data for HTTPResponse
    public let dataGenerator: DataGenerator
    
    /// Indicates if the server is running.
    public var isRunning: Bool {
        return server?.isRunning ?? false
    }
    
    /// All endpoints the mock server can handle
    public var endPoints: [MockServerEndPoint] {
        return swagger?.endPoints ?? []
    }
    
    /// Datasource which will provide the custom HTTPResponse
    public weak var responseDataSource: MockServerResponseDataSource?
    
    /// Json content of swagger definitions
    public private(set) var swaggerJson: [String: Any]?
    
    /// Json url of swagger definitions
    public private(set) var swaggerUrl: String?
    
    private var server: Server?
    private var swagger: SwaggerJson?
    private var willEnterForegroundObserver: NSObjectProtocol?
    private var didEnterBackgroundObserver: NSObjectProtocol?
    
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
    
    /// Init new Mockserver at port: port with swagger url: swaggerUrl
    /// - Parameters:
    ///   - port: Port that server will run on, default is 8080
    ///   - swaggerUrl: String
    ///   - dataGenerator: DataGenerator
    public init(port: Int = 8080,
                swaggerUrl: String,
                dataGenerator: DataGenerator = DataGenerator())
    {
        self.port = port
        self.swaggerUrl = swaggerUrl
        self.dataGenerator = dataGenerator
    }
    
    deinit {
        removeUIApplicationStateObservers()
    }
    
    /// Start mock server
    public func start(completion: ((Bool) -> Void)? = nil) {
        if let swaggerJson = swaggerJson {
            let started = startWith(swaggerJson: swaggerJson)
            completion?(started)
        } else if let swaggerUrl = swaggerUrl, let url = URL(string: swaggerUrl) {
            downloadSwaggerJson(url: url) { [weak self] swaggerJson in
                guard let strongSelf = self else {
                    completion?(false)
                    return
                }
                
                strongSelf.swaggerJson = swaggerJson
                if let swaggerJson = swaggerJson {
                    let started = strongSelf.startWith(swaggerJson: swaggerJson)
                    completion?(started)
                } else {
                    completion?(false)
                }
            }
        } else {
            completion?(false)
        }
    }
    
    /// Stop mock server
    public func stop() {
        server?.stop()
        removeUIApplicationStateObservers()
    }
    
    private func startWith(swaggerJson: [String: Any]) -> Bool {
        server = Server()
        swagger = SwaggerJson(JSON: swaggerJson, dataGenerator: dataGenerator)
        
        if let server = server {
            /*
             Suppose we have 2 endpoints: "GET: /user/{username}" and "GET: /user/login".
             
             The problem is that the Telegraph confuses these two endpoints,
             so it is preferable to pick the first endpoint in the queue for processing.
             
             Then if we add endpoint "GET: /user/{username}" first, and call endpoint "GET: /user/login",
             Telegraph will execute endpoint "GET: /user/{username}".
             
             To solve this problem we have to add enpoints that has no path prams first and then add endpoints that has path prams later to the Telegraph.
             */
            
            print("[SERVER]", "Server is preparing the endpoints")
            let allEndpoints = endPoints.sorted(by: { $0.path < $1.path })
            
            for endpoint in allEndpoints {
                print(endpoint.description)
            }
            
            let endpointsHasPathParam = allEndpoints.filter { $0.hasPathParameters }
            let endpointsHasNoPathParam = allEndpoints.filter { !$0.hasPathParameters }
            
            for endpoint in endpointsHasNoPathParam {
                server.route(endpoint.method, endpoint.route) { [weak self] request -> HTTPResponse? in
                    guard let strongSelf = self else { return nil }
                    
                    request.pathParams = MockServer.pathParamsFrom(requestPath: request.uri.path, endpointPath: endpoint.path)
                    
                    let possibleResponses = endpoint.responses.map { swaggerResponse -> HTTPResponse in
                        let headers = MockServer.headersFor(endpoint: endpoint, swaggerResponse: swaggerResponse)
                        return HTTPResponse(HTTPStatus(code: swaggerResponse.statusCode, phrase: ""),
                                            version: request.version,
                                            headers: headers,
                                            body: swaggerResponse.responseString?.utf8Data ?? Data())
                    }
                    
                    if let httpResponse = self?.responseDataSource?.mockServer(strongSelf, responseFor: request,
                                                                               possibleResponses: possibleResponses)
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
                    
                    let possibleResponses = endpoint.responses.map { swaggerResponse -> HTTPResponse in
                        let headers = MockServer.headersFor(endpoint: endpoint, swaggerResponse: swaggerResponse)
                        return HTTPResponse(HTTPStatus(code: swaggerResponse.statusCode, phrase: ""),
                                            version: request.version,
                                            headers: headers,
                                            body: swaggerResponse.responseString?.utf8Data ?? Data())
                    }
                    
                    if let httpResponse = self?.responseDataSource?.mockServer(strongSelf, responseFor: request,
                                                                               possibleResponses: possibleResponses)
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
                setupUIApplicationStateObservers()
                print("[SERVER]", "Server is running at port", server.port)
                return true
            } catch {
                print("[SERVER]", "Server can not start:", error.localizedDescription)
            }
        } else {
            print("[SERVER]", "Server can not start: no json swagger was found")
        }
        
        return false
    }
    
    private func setupUIApplicationStateObservers() {
        removeUIApplicationStateObservers()
        
        willEnterForegroundObserver = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [weak self] _ in
            self?.start()
        }
        didEnterBackgroundObserver = NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { [weak self] _ in
            self?.server?.stop()
        }
    }
    
    private func removeUIApplicationStateObservers() {
        if let willEnterForegroundObserver = willEnterForegroundObserver {
            NotificationCenter.default.removeObserver(willEnterForegroundObserver)
        }
        if let didEnterBackgroundObserver = didEnterBackgroundObserver {
            NotificationCenter.default.removeObserver(didEnterBackgroundObserver)
        }
    }
    
    private func downloadSwaggerJson(url: URL, completion: @escaping ([String: Any]?) -> Void) {
        let httpTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            let swaggerJson: [String: Any]? = data?.jsonObject
            completion(swaggerJson)
        }
        httpTask.resume()
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

// MARK: - ServerDelegate

extension MockServer: ServerDelegate {
    // Raised when the server gets disconnected.
    public func serverDidStop(_ server: Server, error: Error?) {
        if let error = error {
            print("[SERVER]", "Server stopped:", error.localizedDescription)
        } else {
            print("[SERVER]", "Server stopped")
        }
    }
}

public extension HTTPStatus {
    /// Creates a HTTPStatus.
    /// - Parameter code: The numeric code of the status (e.g. 404)
    init(code: Int) {
        self.init(code: code, phrase: "phrase", strict: false)
    }
}

// MARK: - HTTPResponse.statusCode

public extension HTTPResponse {
    var statusCode: Int {
        return status.code
    }
    
    convenience init(statusCode: Int,
                     version: HTTPVersion = .default,
                     headers: HTTPHeaders = .empty,
                     body: Data = Data()) {
        self.init(HTTPStatus(code: statusCode), version: version, headers: headers, body: body)
    }
}

// MARK: - HTTPRequest.pathParams

public extension HTTPRequest {
    var queryItems: [URLQueryItem]? {
        return uri.queryItems
    }
    
    var query: String? {
        return uri.query
    }
    
    var path: String {
        return uri.path
    }
    
    @objc var pathParams: [String: String]? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.pathParams) as? [String: String]
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.pathParams, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var fullDescription: String {
        var logRequest = "Request description (\(String(describing: self)):\n"
        let urlString = path
        logRequest += String(repeating: "- ", count: 14 + urlString.count/2)
        logRequest += "\n|"
            + String(repeating: " ", count: 13)
            + "\(urlString)"
            + String(repeating: " ", count: 12)
            + "|"
        logRequest += "\n" + String(repeating: "- ", count: 14 + urlString.count/2)
        logRequest += "\n|     Request: \(method.name) - \(path)"
        
        if !headers.isEmpty {
            let headerString = Dictionary(uniqueKeysWithValues:
                headers.map { ($0.key.description, $0.value) }).prettyPrinted
            logRequest += "\n|     Headers(\(headers.count)):\n\(headerString)"
        }
        
        if let queryItems = queryItems, !queryItems.isEmpty {
            logRequest += "\n|     Queries(\(queryItems.count)):\n\(queryItems)"
        }
        
        if let pathParams = pathParams, !pathParams.isEmpty {
            logRequest += "\n|     Path Params(\(pathParams.count)):\n\(pathParams.prettyPrinted)"
        }
        
        if let payloadObject = body.jsonObject {
            logRequest += "\n|     Body    :\n\(payloadObject.prettyPrinted)"
        } else if let payloadArray = body.jsonArray {
            logRequest += "\n|     Body    :\n\(payloadArray.prettyPrinted)"
        } else if let payloadArray = body.stringArray {
            logRequest += "\n|     Body    :\n\(payloadArray.prettyPrinted)"
        } else if let payloadString = body.string {
            logRequest += "\n|     Body    :\n\(payloadString)"
        }
        
        logRequest += "\n" + String(repeating: "- ", count: 14 + urlString.count/2) + "\n"
        
        return logRequest
    }
    
    private enum AssociatedKeys {
        static var pathParams = "NSObject.HTTPRequestPathParams"
    }
}
