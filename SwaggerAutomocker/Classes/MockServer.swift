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

public protocol MockServerResponseDataSource: class {
    /// The function allows us to customize the response for any request. If this method return nil, the default response will be use.
    /// - Parameters:
    ///   - mockServer: MockServer
    ///   - endpoint: MockServerEndpoint
    ///   - request: HTTPRequest
    ///   - possibleResponses: Responses are predefined for the request in the swagger json file.
    func mockServer(_ mockServer: MockServer, responseFor request: HTTPRequest, to endpoint: MockServerEndpoint, possibleResponses: [HTTPResponse]) -> HTTPResponse?
}

public final class MockServer {
    /// The port which the mock server is running on.
    public let port: Int
    
    /// The number of concurrent requests that can be handled.
    public let concurrency: Int
    
    /// DataGenerator object which will be used to generate dummy data for HTTPResponse
    public let dataGenerator: DataGenerator
    
    /// Indicates if the server is running.
    public var isRunning: Bool {
        return server?.isRunning ?? false
    }
    
    /// All endpoints the mock server can handle
    public var endpoints: [MockServerEndpoint] {
        return swagger?.endpoints ?? []
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
    private let genDataSourceExtensionInConsole: Bool
    
    /// Init new Mockserver at port with swaggerJson, dataGenerator and genDataSourceExtensionInConsole
    /// - Parameters:
    ///   - port: Port that server will run on, default is 8080
    ///   - concurrency: The number of concurrent requests that can be handled. default is 100
    ///   - swaggerJson: [String: Any]
    ///   - dataGenerator: DataGenerator
    ///   - genDataSourceExtensionInConsole: if set to true, the MockServerResponseDataSource extension will be printed automatically in the console log. You can copy it into your source code to save time implementing all the endpoints.
    public init(port: Int = 8080,
                concurrency: Int = 100,
                swaggerJson: [String: Any],
                dataGenerator: DataGenerator = DataGenerator(),
                genDataSourceExtensionInConsole: Bool = true)
    {
        self.port = port
        self.concurrency = concurrency
        self.swaggerJson = swaggerJson
        self.dataGenerator = dataGenerator
        self.genDataSourceExtensionInConsole = genDataSourceExtensionInConsole
    }
    
    /// Init new Mockserver at port with swaggerJson, dataGenerator and genDataSourceExtensionInConsole
    /// - Parameters:
    ///   - port: Port that server will run on, default is 8080
    ///   - concurrency: The number of concurrent requests that can be handled. default is 100
    ///   - swaggerUrl: String
    ///   - dataGenerator: DataGenerator
    ///   - genDataSourceExtensionInConsole: if set to true, the MockServerResponseDataSource extension will be printed automatically in the console log. You can copy it into your source code to save time implementing all the endpoints.
    public init(port: Int = 8080,
                concurrency: Int = 100,
                swaggerUrl: String,
                dataGenerator: DataGenerator = DataGenerator(),
                genDataSourceExtensionInConsole: Bool = true)
    {
        self.port = port
        self.concurrency = concurrency
        self.swaggerUrl = swaggerUrl
        self.dataGenerator = dataGenerator
        self.genDataSourceExtensionInConsole = genDataSourceExtensionInConsole
    }
    
    deinit {
        removeUIApplicationStateObservers()
    }
    
    /// Start mock server
    public func start(completion: ((Bool) -> Void)? = nil) {
        if let swaggerJson = swaggerJson {
            let started = startWithSwaggerJson(swaggerJson)
            completion?(started)
        } else if let swaggerUrl = swaggerUrl, let url = URL(string: swaggerUrl) {
            downloadSwaggerJson(url: url) { [weak self] swaggerJson in
                guard let strongSelf = self else {
                    completion?(false)
                    return
                }
                
                strongSelf.swaggerJson = swaggerJson
                if let swaggerJson = swaggerJson {
                    let started = strongSelf.startWithSwaggerJson(swaggerJson)
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
    
    private func startWithSwaggerJson(_ swaggerJson: [String: Any]) -> Bool {
        let newServer = Server()
        server = newServer
        swagger = SwaggerJson(JSON: swaggerJson, dataGenerator: dataGenerator)
        
        if let swagger = swagger {
            /*
             Suppose we have 2 endpoints: "GET: /user/{username}" and "GET: /user/login".
             
             The problem is that the Telegraph confuses these two endpoints,
             so it is preferable to pick the first endpoint in the queue for processing.
             
             Then if we add endpoint "GET: /user/{username}" first, and call endpoint "GET: /user/login",
             Telegraph will execute endpoint "GET: /user/{username}".
             
             To solve this problem we have to add enpoints that has no path prams first and then add endpoints that has path prams later to the Telegraph.
             */
            
            print("[SERVER]", "Server is preparing the endpoints")
            let allEndpoints = swagger.endpoints.sorted(by: { $0.path < $1.path })
            
            for endpoint in allEndpoints {
                print(endpoint.description)
            }
            
            if genDataSourceExtensionInConsole {
                print(MockServer.genDataSourceExtensionFor(endpoints: allEndpoints))
            }
            
            let endpointsHasPathParam = allEndpoints.filter { $0.hasPathParameters }
            let endpointsHasNoPathParam = allEndpoints.filter { !$0.hasPathParameters }
            
            for endpoint in endpointsHasNoPathParam {
                newServer.route(endpoint.method, endpoint.route) { [weak self] request -> HTTPResponse? in
                    guard let strongSelf = self else { return nil }
                    
                    let possibleResponses = endpoint.possibleHttpResponses(version: request.version)
                    
                    if let httpResponse = self?.responseDataSource?.mockServer(strongSelf,
                                                                               responseFor: request,
                                                                               to: endpoint,
                                                                               possibleResponses: possibleResponses)
                    {
                        return httpResponse
                    } else {
                        let defaultResponse = endpoint.defaultResponse
                        let headers = endpoint.headersFor(response: defaultResponse)
                        
                        return HTTPResponse(HTTPStatus(code: defaultResponse.statusCode),
                                            version: request.version,
                                            headers: headers,
                                            body: defaultResponse.responseString?.utf8Data ?? Data())
                    }
                }
            }
            
            for endpoint in endpointsHasPathParam {
                newServer.route(endpoint.method, regex: "^" + endpoint.route + "$") { [weak self] request -> HTTPResponse? in
                    guard let strongSelf = self else { return nil }
                    
                    let possibleResponses = endpoint.possibleHttpResponses(version: request.version)
                    
                    if let httpResponse = self?.responseDataSource?.mockServer(strongSelf,
                                                                               responseFor: request,
                                                                               to: endpoint,
                                                                               possibleResponses: possibleResponses)
                    {
                        return httpResponse
                    } else {
                        let defaultResponse = endpoint.defaultResponse
                        let headers = endpoint.headersFor(response: defaultResponse)
                        
                        return HTTPResponse(HTTPStatus(code: defaultResponse.statusCode),
                                            version: request.version,
                                            headers: headers,
                                            body: defaultResponse.responseString?.utf8Data ?? Data())
                    }
                }
            }
            
            newServer.delegate = self
            newServer.concurrency = concurrency
            
            do {
                try newServer.start(port: port)
                setupUIApplicationStateObservers()
                print("[SERVER]", "Server is running at port", newServer.port)
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
