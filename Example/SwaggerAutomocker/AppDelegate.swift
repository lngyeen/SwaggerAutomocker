//
//  AppDelegate.swift
//  SwaggerAutomocker
//
//  Created by lngyeen on 05/06/2020.
//  Copyright (c) 2020 lngyeen. All rights reserved.
//

import SwaggerAutomocker
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var mockServer: MockServer?
    var window: UIWindow?

    var dataGenerator: DataGenerator {
        let dataGenerator = DataGenerator()
        dataGenerator.useFakeryDataGenerator = true
        dataGenerator.distinctElementsInArray = true
        dataGenerator.generateDummyDataLazily = true
        dataGenerator.rootArrayElementCount = 3
        dataGenerator.childArrayElementCount = 2
        
        dataGenerator.defaultDataConfigurator.dateTimeDefaultValue = "2021-01-01T17:32:28Z"
        
        dataGenerator.fakeryDataConfigurator.maxInt = 1000
        dataGenerator.fakeryDataConfigurator.maxFloat = 100
        dataGenerator.fakeryDataConfigurator.maxDouble = 100
        return dataGenerator
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let jsonFileName = "openapi1"
        if let json = readJSONFromFile(fileName: jsonFileName) as? [String: Any] {
            mockServer = MockServer(port: 8080,
                                    swaggerJson:json,
                                    dataGenerator: dataGenerator)
            mockServer?.responseDataSource = self
            mockServer?.start()
        }
        
//        let swaggerUrl = "https://mobileapp-fe-dev.swissmedical.net/aevis-app-backend-api/v3/api-docs"
//        mockServer = MockServer(port: 8080,
//                                swaggerUrl: swaggerUrl,
//                                dataGenerator: dataGenerator)
//        mockServer?.responseDataSource = self
//        mockServer?.start()
        
        return true
    }

    private func readJSONFromFile(fileName: String) -> Any? {
        if let fileUrl = Bundle(for: Self.self).url(forResource: fileName, withExtension: "json"),
           let data = try? Data(contentsOf: fileUrl, options: .mappedIfSafe){
            return try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        }
        return nil
    }
}

extension Dictionary {
    var prettyPrinted: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

// MARK: - MockServerResponseDataSource

extension AppDelegate: MockServerResponseDataSource {
    func mockServer(_ mockServer: MockServer, responseFor request: HTTPRequest, possibleResponses: [HTTPResponse]) -> HTTPResponse? {
        print(request.fullDescription)
        
        switch request.uri.path {
        /// OPENAPI_1
        case "/api/v1/company":
            switch request.method {
            case .POST:
                // return possibleResponses.first(where: {$0.statusCode > 299})
                return HTTPResponse(statusCode: 409, headers: ["X-Server-Message": "Conflict"], body: "Company with the same id was created before.".utf8Data)
            default: break
            }

        case "/api/v1/company/123":
            switch request.method {
            case .GET:
                // return possibleResponses.first(where: {$0.statusCode > 299})
                return HTTPResponse(statusCode: 422, body: "Company with id 123 does not exist.".utf8Data)
            default: break
            }

        case "/api/v1/registration/user":
            switch request.method {
            case .POST:
                // return possibleResponses.first(where: {$0.statusCode > 400})
                return HTTPResponse(statusCode: 409, headers: ["X-Server-Message": "Conflict"], body: "Email was used to sign up for another account.".utf8Data)
            default: break
            }

        /// OPENAPI_2
        case "/v1/directory/employees":
            switch request.method {
            case .GET:
                return possibleResponses.first(where: { $0.statusCode >= 200 })
            default: break
            }

        default:
            break
        }

        return nil
    }
}
