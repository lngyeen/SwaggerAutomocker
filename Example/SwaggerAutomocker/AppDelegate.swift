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
        dataGenerator.childrenArrayElementCount = 3
        dataGenerator.dateTimeDefaultValue = "2021-01-01T17:32:28Z"
        return dataGenerator
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let jsonFileName = "openapi1"
        let json = readJSONFromFile(fileName: jsonFileName)
        if let json = json as? [String: Any] {
            mockServer = MockServer(port: 8080,
                                    swaggerJson: json,
                                    dataGenerator: dataGenerator)
            mockServer?.responseDatasource = self
            mockServer?.start()
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        mockServer?.stop()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        mockServer?.start()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    private func readJSONFromFile(fileName: String) -> Any? {
        var json: Any?

        if let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                do {
                    json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                } catch {
                    print("Error!! Unable to parse \(fileName).json")
                }
            } catch {
                print("Error!! Unable to load \(fileName).json")
            }
        }
        return json
    }
}

// MARK: - MockServerResponseDatasource

extension AppDelegate: MockServerResponseDatasource {
    func mockServer(_ mockServer: MockServer, httpResponseFor request: HTTPRequest, possibleResponses: [HTTPResponse]) -> HTTPResponse? {
        print("--- \(request.method.name) - \(request.uri.path) ---")
        print("Query Params: \(String(describing: request.uri.queryItems))")
        print("Path Params: \(String(describing: request.pathParams?.prettyPrinted))")
        if let json = request.body.jsonObject?.prettyPrinted {
            print("Request Body: \n\(json)")
        } else if let string = request.body.string {
            print("Request Body: \n\(string)")
        }
        print("--------------------------")
        return nil
    }
}

extension Dictionary {
    var prettyPrinted: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
