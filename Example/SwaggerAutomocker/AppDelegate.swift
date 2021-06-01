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
                                    concurrency: 50,
                                    swaggerJson: json,
                                    dataGenerator: dataGenerator,
                                    genDataSourceExtensionInConsole: true)
            mockServer?.responseDataSource = self
            mockServer?.start()
        }
        
//        let swaggerUrl = "https://mobileapp-fe-dev.swissmedical.net/aevis-app-backend-api/v3/api-docs"
//        mockServer = MockServer(port: 8080,
//                                concurrency: 50,
//                                swaggerUrl: swaggerUrl,
//                                dataGenerator: dataGenerator,
//                                genDataSourceExtensionInConsole: true)
//        mockServer?.responseDataSource = self
//        mockServer?.start()
        
        return true
    }

    private func readJSONFromFile(fileName: String) -> Any? {
        if let fileUrl = Bundle(for: Self.self).url(forResource: fileName, withExtension: "json"),
           let data = try? Data(contentsOf: fileUrl, options: .mappedIfSafe)
        {
            return try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        }
        return nil
    }
}

// MARK: - MockServerResponseDataSource

extension AppDelegate: MockServerResponseDataSource {
    func mockServer(_ mockServer: MockServer, responseFor request: HTTPRequest, to endpoint: MockServerEndpoint, possibleResponses: [HTTPResponse]) -> HTTPResponse? {
        print(request.fullDescription)

        let pathParams = (try? MockServer.pathParamsFrom(requestPath: request.path, endpointPath: endpoint.path)) ?? [:]
        
        switch endpoint.path {
        case "/api/v1/registration/user":
            switch endpoint.method {
            case .POST:
                switch request.body.jsonObject?["email"] as? String {
                case .some("email@domain.com"):
                    // return possibleResponses.first(where: {$0.statusCode > 400})
                    return HTTPResponse(statusCode: 409, headers: ["X-Server-Message": "Conflict"], body: "Email was used to sign up for another account.".utf8Data)
                default:
                    break
                }
                
            default: break
            }
            
        case "/api/v1/user/settings/{userId}":
            switch endpoint.method {
            case .PUT: break
                
            default: break
            }
            
        case "/api/v1/user/{id}":
            switch endpoint.method {
            case .GET: break
                
            case .PUT: break
                
            case .DELETE: break
                
            default: break
            }
            
        case "/user/oauthinfo":
            switch endpoint.method {
            case .OPTIONS: break
                
            case .DELETE: break
                
            case .GET: break
                
            case .HEAD: break
                
            case .POST: break
                
            case .PUT: break
                
            case .PATCH: break
                
            default: break
            }
            
        case "/api/v1/hospital/{id}":
            switch endpoint.method {
            case .PUT: break
                
            case .GET: break
                
            case .DELETE: break
                
            default: break
            }
            
        case "/api/v1/topic/{id}":
            switch endpoint.method {
            case .DELETE: break
                
            case .PUT: break
                
            case .GET: break
                
            default: break
            }
            
        case "/api/v1/registration/resend-code/{id}":
            switch endpoint.method {
            case .POST: break
                
            default: break
            }
            
        case "/api/v1/registration/verification/{id}":
            switch endpoint.method {
            case .POST: break
                
            default: break
            }
            
        case "/api/v1/company":
            switch endpoint.method {
            case .GET: break
                
            case .POST:
                // return possibleResponses.first(where: {$0.statusCode > 299})
                return HTTPResponse(statusCode: 409, headers: ["X-Server-Message": "Conflict"], body: "Company with the same id was created before.".utf8Data)

            default: break
            }
            
        case "/api/v1/user/current":
            switch endpoint.method {
            case .GET: break
                
            default: break
            }
            
        case "/api/v1/registration/as-admin":
            switch endpoint.method {
            case .POST: break
                
            default: break
            }
            
        case "/api/v1/user/{id}/reset-password":
            switch endpoint.method {
            case .PUT: break
                
            default: break
            }
            
        case "/api/v1/user":
            switch endpoint.method {
            case .DELETE: break
                
            case .PUT: break
                
            case .GET: break
                
            default: break
            }
            
        case "/api/v1/hospital":switch endpoint.method {
            case .GET: break
                
            case .POST: break
                
            default: break
            }
            
        case "/api/v1/user/reset-password":
            switch endpoint.method {
            case .PUT: break
                
            default: break
            }
            
        case "/api/v1/company/{id}":
            switch endpoint.method {
            case .DELETE: break
                
            case .GET:
                switch pathParams["id"] {
                case .some("123"):
                    // return possibleResponses.first(where: {$0.statusCode > 299})
                    return HTTPResponse(statusCode: 422, body: [
                        "contact" : [
                            "status" : "IN_VERIFICATION",
                            "termAndConditions" : true,
                            "phone" : "(994) 565-8269",
                            "userRole" : "EVENT_MANAGER",
                            "registration" : [
                                "invitationLink" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                "invitationCode" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                "id" : 76
                            ],
                            "lastName" : "Hilll",
                            "nickName" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                            "comment" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                            "id" : 28,
                            "focusmeEntityId" : 559,
                            "topics" : [
                                [
                                    "name" : "Christina Gerhold",
                                    "status" : "ACTIVE",
                                    "id" : 268
                                ],
                                [
                                    "name" : "Caterina Ziemann",
                                    "status" : "ACTIVE",
                                    "id" : 881
                                ]
                            ],
                            "profile" : [
                                "postCode" : "82703",
                                "maritalStatus" : "GRANDMOTHER",
                                "ageGroup" : "TWENTY_TO_TWENTY_NINE",
                                "id" : 395,
                                "additionalHospitals" : [
                                    [
                                        "id" : 908,
                                        "name" : "Kaley Barrows"
                                    ],
                                    [
                                        "id" : 786,
                                        "name" : "Roscoe Wyman"
                                    ]
                                ],
                                "diseaseStatuses" : [
                                    "HER2_MINUS",
                                    "HER2_PLUS"
                                ]
                            ],
                            "email" : "monicajones@stokes.biz",
                            "firstName" : "Kenna",
                            "description" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                            "glnNumber" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        "id" : 123,
                        "contactDetails" : "vel sed blanditiis quam eos totam qui iure non numquam",
                        "name" : "Mr. Deja King",
                        "status" : "NON_ACTIVE"
                    ].data ?? Data())

                default: break
                }
                
            case .PUT: break
                
            default: break
            }
            
        case "/api/v1/registration/approve/{id}":
            switch endpoint.method {
            case .POST: break
                
            default: break
            }
            
        case "/api/v1/topic":
            switch endpoint.method {
            case .GET: break
                
            case .POST: break
                
            default: break
            }
            
        default: break
        }
        
        return nil
    }
}
