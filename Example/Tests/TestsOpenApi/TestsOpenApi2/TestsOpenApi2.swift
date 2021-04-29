import SwaggerAutomocker
import XCTest

final class TestsOpenApi2: Tests {
    override class var jsonFileName: String {
        return "openapi2"
    }
    
    // MARK: Clinic tests

    func testGetAllClinics() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/back-office/clinics"
        let request = get(path: path)
        guard let expectedJson = expectedResponseFromJson(request: request) as? ResponseType else {
            return XCTFail("Could not find expected json file")
        }
        let expectedResponse = expectedJson.map { $0.formatted }

        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get all clinics") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }

        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
    
    func testGetAllClinicsConfig() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/config/clinics"
        let request = get(path: path)
        let expectedResponse = [
            [
                "minLongitude": 1.23,
                "maxLatitude": 1.23,
                "admissionsEmail": "string value",
                "id": 123,
                "fluanceCompanyId": 123,
                "centerLatitude": 1.23,
                "code": "string value",
                "centerLongitude": 1.23,
                "imagePath": "string value",
                "invoicingEmail": "string value",
                "minLatitude": 1.23,
                "radius": 123,
                "infra": "SMN",
                "name": "string value",
                "maxLongitude": 1.23
            ],
            [
                "invoicingEmail": "string value",
                "centerLongitude": 1.23,
                "centerLatitude": 1.23,
                "code": "string value",
                "radius": 123,
                "maxLatitude": 1.23,
                "admissionsEmail": "string value",
                "minLatitude": 1.23,
                "minLongitude": 1.23,
                "imagePath": "string value",
                "infra": "SMN",
                "name": "string value",
                "id": 123,
                "fluanceCompanyId": 123,
                "maxLongitude": 1.23
            ],
            [
                "centerLongitude": 1.23,
                "minLatitude": 1.23,
                "invoicingEmail": "string value",
                "maxLongitude": 1.23,
                "minLongitude": 1.23,
                "id": 123,
                "centerLatitude": 1.23,
                "code": "string value",
                "infra": "SMN",
                "fluanceCompanyId": 123,
                "imagePath": "string value",
                "name": "string value",
                "admissionsEmail": "string value",
                "radius": 123,
                "maxLatitude": 1.23
            ]
        ].map { $0.formatted }
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get all clinics config") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
    
    func testGetAllClinicKpis() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/config/clinics/123/kpis"
        let request = get(path: path)
        let expectedResponse = [
            [
                "highThreshold": 1.23,
                "kpiType": "ADMISSIONS",
                "lowThreshold": 1.23
            ],
            [
                "highThreshold": 1.23,
                "kpiType": "ADMISSIONS",
                "lowThreshold": 1.23
            ],
            [
                "highThreshold": 1.23,
                "lowThreshold": 1.23,
                "kpiType": "ADMISSIONS"
            ]
        ].map { $0.formatted }
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get all clinic kpis") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
    
    func testUpdateClinicEmail() {
        typealias ResponseType = [String: Any]
        
        // Given
        let path = "/v1/back-office/clinics/123/emails"
        let request = patch(path: path)
        let expectedResponse = [
            "minLatitude": 1.23,
            "radius": 123,
            "name": "string value",
            "invoicingEmail": "string value",
            "fluanceCompanyId": 123,
            "code": "string value",
            "centerLatitude": 1.23,
            "id": 123,
            "admissionsEmail": "string value",
            "infra": "SMN",
            "visible": true,
            "centerLongitude": 1.23,
            "maxLongitude": 1.23,
            "dwhClinicCode": "string value",
            "minLongitude": 1.23,
            "maxLatitude": 1.23
        ].formatted
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Update clinic emails") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [:] == expectedResponse)
    }
    
    // MARK: Doctor tests
    
    func testGetAllDoctors() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/back-office/doctors"
        let request = get(path: path)
        let expectedResponse = [
            [
                "lastActivityAt": "string value",
                "autoInvoiceValidation": true,
                "username": "string value",
                "supportContactName": "string value",
                "supportContactPhoneNumber": "string value"
            ],
            [
                "supportContactName": "string value",
                "username": "string value",
                "autoInvoiceValidation": true,
                "lastActivityAt": "string value",
                "supportContactPhoneNumber": "string value"
            ],
            [
                "supportContactPhoneNumber": "string value",
                "lastActivityAt": "string value",
                "supportContactName": "string value",
                "autoInvoiceValidation": true,
                "username": "string value"
            ]
        ].map { $0.formatted }
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get all doctors") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
    
    func testUpdateDoctorContact() {
        typealias ResponseType = [String: Any]
        
        // Given
        let path = "/v1/back-office/doctors/luunguyen/contact"
        let request = patch(path: path)
        let expectedResponse = [
            "autoInvoiceValidation": true,
            "username": "string value",
            "supportContactPhoneNumber": "string value",
            "supportContactName": "string value",
            "lastActivityAt": "string value"
        ].formatted
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Update doctor contact") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [:] == expectedResponse)
    }
    
    func testUpdateDoctorInvoices() {
        typealias ResponseType = [String: Any]
        
        // Given
        let path = "/v1/back-office/doctors/luunguyen/invoices"
        let request = patch(path: path)
        let expectedResponse = [
            "autoInvoiceValidation": true,
            "username": "string value",
            "supportContactPhoneNumber": "string value",
            "supportContactName": "string value",
            "lastActivityAt": "string value"
        ].formatted
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Update doctor invoices") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [:] == expectedResponse)
    }
    
    // MARK: Employee tests
    
    func testGetAllEmployeePictures() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/back-office/employees/pictures"
        let request = get(path: path)
        guard let expectedJson = expectedResponseFromJson(request: request) as? ResponseType else {
            return XCTFail("Could not find expected json file")
        }
        let expectedResponse = expectedJson.map { $0.formatted }
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get all employees pictures") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
    
    func testVoteEmployeePictureAward() {
        typealias ResponseType = [String: Any]
        
        // Given
        let path = "/v1/back-office/employees/pictures/123/award"
        let request = post(path: path)
        let expectedResponse = [
            "clinicId": 123,
            "comment": "string value",
            "picture": [
                "id": 123456789,
                "hash": "string value",
                "uploadedBy": [
                    "firstName": "string value",
                    "email": "string value",
                    "lastName": "string value",
                    "username": "string value"
                ],
                "uriPath": "string value"
            ],
            "id": 123456789,
            "submittedAt": "string value",
            "awards": [
                [
                    "award": "PICTURE_OF_THE_WEEK",
                    "awardedAt": "string value"
                ],
                [
                    "award": "PICTURE_OF_THE_WEEK",
                    "awardedAt": "string value"
                ],
                [
                    "award": "PICTURE_OF_THE_WEEK",
                    "awardedAt": "string value"
                ]
            ]
        ].formatted
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Vote employee picture") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [:] == expectedResponse)
    }
    
    func testGetAllEmployeeLeaderboard() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/back-office/employees/rewards/leaderboard"
        let request = get(path: path)
        guard let expectedJson = expectedResponseFromJson(request: request) as? ResponseType else {
            return XCTFail("Could not find expected json file")
        }
        let expectedResponse = expectedJson.map { $0.formatted }

        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get all employees leaderboard") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
    
    func testGetAllEmployeesVacationRequests() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/back-office/employees/vacation-requests"
        let request = get(path: path)
        guard let expectedJson = expectedResponseFromJson(request: request) as? ResponseType else {
            return XCTFail("Could not find expected json file")
        }
        let expectedResponse = expectedJson.map { $0.formatted }
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get all employees vacation requests") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
    
    // MARK: Menu tests
    
    func testGetAllClinicMenus() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/clinics/123/menus"
        let request = get(path: path)
        guard let expectedJson = expectedResponseFromJson(request: request) as? ResponseType else {
            return XCTFail("Could not find expected json file")
        }
        let expectedResponse = expectedJson.map { $0.formatted }
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get all clinic's menus") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
    
    func testGetAllClinicMenusInDate() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/clinics/123/menus/1-1-2021"
        let request = get(path: path)
        guard let expectedJson = expectedResponseFromJson(request: request) as? ResponseType else {
            return XCTFail("Could not find expected json file")
        }
        let expectedResponse = expectedJson.map { $0.formatted }
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get all clinic's menus in date") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
    
    func testVoteClinicMenu() {
        typealias ResponseType = [String: Any]
        
        // Given
        let path = "/v1/clinics/123/menus/1-1-2021/456/ratings"
        let request = post(path: path)
        let expectedResponse = [
            "id": 123456789,
            "comment": "string value",
            "commenter": [
                "lastName": "string value",
                "username": "string value",
                "firstName": "string value",
                "clinicId": 123,
                "email": "string value"
            ],
            "menu": 123,
            "rating": 123,
            "clinic": [
                "code": "string value",
                "id": 123,
                "name": "string value",
                "fluanceCompanyId": 123,
                "infra": "SMN"
            ],
            "date": "2017-07-21"
        ].formatted
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Vote clinic menu") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [:] == expectedResponse)
    }
    
    func testGetMenuRatings() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/clinics/123/menus/1-1-2021/456/ratings"
        let request = get(path: path)
        let expectedResponse = [
            [
                "menu": 123,
                "clinic": [
                    "code": "string value",
                    "id": 123,
                    "infra": "SMN",
                    "name": "string value",
                    "fluanceCompanyId": 123
                ],
                "comment": "string value",
                "commenter": [
                    "firstName": "string value",
                    "email": "string value",
                    "username": "string value",
                    "clinicId": 123,
                    "lastName": "string value"
                ],
                "id": 123456789,
                "date": "2017-07-21",
                "rating": 123
            ],
            [
                "clinic": [
                    "code": "string value",
                    "id": 123,
                    "infra": "SMN",
                    "name": "string value",
                    "fluanceCompanyId": 123
                ],
                "comment": "string value",
                "menu": 123,
                "date": "2017-07-21",
                "rating": 123,
                "commenter": [
                    "firstName": "string value",
                    "email": "string value",
                    "username": "string value",
                    "clinicId": 123,
                    "lastName": "string value"
                ],
                "id": 123456789
            ],
            [
                "menu": 123,
                "id": 123456789,
                "clinic": [
                    "code": "string value",
                    "id": 123,
                    "infra": "SMN",
                    "name": "string value",
                    "fluanceCompanyId": 123
                ],
                "date": "2017-07-21",
                "rating": 123,
                "commenter": [
                    "firstName": "string value",
                    "email": "string value",
                    "username": "string value",
                    "clinicId": 123,
                    "lastName": "string value"
                ],
                "comment": "string value"
            ]
        ].map { $0.formatted }
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get all menu ratings") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
    
    // MARK: Doctor tests
    
    func testGetFavoriteDoctors() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/directory/doctors/favorites"
        let request = get(path: path)
        let expectedResponse = [
            [
                "lastName": "string value",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "string value",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ]
                    ],
                    "longitude": 1.23,
                    "supportContactName": "string value",
                    "employeeDepartment": "string value",
                    "latitude": 1.23,
                    "employeeCompany": "string value",
                    "supportContactPhoneNumber": "string value",
                    "lastActivityAt": "string value",
                    "employeeClinicId": 123
                ],
                "isFavorite": true,
                "username": "string value",
                "distance": 123,
                "email": "string value",
                "firstName": "string value"
            ],
            [
                "lastName": "string value",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "string value",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ]
                    ],
                    "longitude": 1.23,
                    "supportContactName": "string value",
                    "employeeDepartment": "string value",
                    "latitude": 1.23,
                    "employeeCompany": "string value",
                    "supportContactPhoneNumber": "string value",
                    "lastActivityAt": "string value",
                    "employeeClinicId": 123
                ],
                "isFavorite": true,
                "username": "string value",
                "distance": 123,
                "email": "string value",
                "firstName": "string value"
            ],
            [
                "lastName": "string value",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "string value",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ]
                    ],
                    "longitude": 1.23,
                    "supportContactName": "string value",
                    "employeeDepartment": "string value",
                    "latitude": 1.23,
                    "employeeCompany": "string value",
                    "supportContactPhoneNumber": "string value",
                    "lastActivityAt": "string value",
                    "employeeClinicId": 123
                ],
                "isFavorite": true,
                "username": "string value",
                "distance": 123,
                "email": "string value",
                "firstName": "string value"
            ]
        ].map { $0.formatted }
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get all favorite doctors") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
    
    func testGetClinicDoctors() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/directory/doctors/here"
        let request = get(path: path)
        let expectedResponse = [
            [
                "lastName": "string value",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "string value",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ]
                    ],
                    "longitude": 1.23,
                    "supportContactName": "string value",
                    "employeeDepartment": "string value",
                    "latitude": 1.23,
                    "employeeCompany": "string value",
                    "supportContactPhoneNumber": "string value",
                    "lastActivityAt": "string value",
                    "employeeClinicId": 123
                ],
                "isFavorite": true,
                "username": "string value",
                "distance": 123,
                "email": "string value",
                "firstName": "string value"
            ],
            [
                "lastName": "string value",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "string value",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ]
                    ],
                    "longitude": 1.23,
                    "supportContactName": "string value",
                    "employeeDepartment": "string value",
                    "latitude": 1.23,
                    "employeeCompany": "string value",
                    "supportContactPhoneNumber": "string value",
                    "lastActivityAt": "string value",
                    "employeeClinicId": 123
                ],
                "isFavorite": true,
                "username": "string value",
                "distance": 123,
                "email": "string value",
                "firstName": "string value"
            ],
            [
                "lastName": "string value",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "string value",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ]
                    ],
                    "longitude": 1.23,
                    "supportContactName": "string value",
                    "employeeDepartment": "string value",
                    "latitude": 1.23,
                    "employeeCompany": "string value",
                    "supportContactPhoneNumber": "string value",
                    "lastActivityAt": "string value",
                    "employeeClinicId": 123
                ],
                "isFavorite": true,
                "username": "string value",
                "distance": 123,
                "email": "string value",
                "firstName": "string value"
            ]
        ].map { $0.formatted }
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get all clinic doctors") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
    
    func testSearchDoctors() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/directory/doctors/search"
        let request = get(path: path)
        let expectedResponse = [
            [
                "lastName": "string value",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "string value",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ]
                    ],
                    "longitude": 1.23,
                    "supportContactName": "string value",
                    "employeeDepartment": "string value",
                    "latitude": 1.23,
                    "employeeCompany": "string value",
                    "supportContactPhoneNumber": "string value",
                    "lastActivityAt": "string value",
                    "employeeClinicId": 123
                ],
                "isFavorite": true,
                "username": "string value",
                "distance": 123,
                "email": "string value",
                "firstName": "string value"
            ],
            [
                "lastName": "string value",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "string value",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ]
                    ],
                    "longitude": 1.23,
                    "supportContactName": "string value",
                    "employeeDepartment": "string value",
                    "latitude": 1.23,
                    "employeeCompany": "string value",
                    "supportContactPhoneNumber": "string value",
                    "lastActivityAt": "string value",
                    "employeeClinicId": 123
                ],
                "isFavorite": true,
                "username": "string value",
                "distance": 123,
                "email": "string value",
                "firstName": "string value"
            ],
            [
                "lastName": "string value",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "string value",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ]
                    ],
                    "longitude": 1.23,
                    "supportContactName": "string value",
                    "employeeDepartment": "string value",
                    "latitude": 1.23,
                    "employeeCompany": "string value",
                    "supportContactPhoneNumber": "string value",
                    "lastActivityAt": "string value",
                    "employeeClinicId": 123
                ],
                "isFavorite": true,
                "username": "string value",
                "distance": 123,
                "email": "string value",
                "firstName": "string value"
            ]
        ].map { $0.formatted }
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Search doctors") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
    
    // MARK: Employee tests
    
    func testGetAllEmployees() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/directory/employees"
        let request = get(path: path)
        let expectedResponse = [
            [
                "firstName": "string value",
                "username": "string value",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "string value",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ]
                    ],
                    "longitude": 1.23,
                    "employeeCompany": "string value",
                    "employeeDepartment": "string value",
                    "latitude": 1.23,
                    "supportContactName": "string value",
                    "supportContactPhoneNumber": "string value",
                    "lastActivityAt": "string value",
                    "employeeClinicId": 123
                ],
                "email": "string value",
                "lastName": "string value"
            ],
            [
                "firstName": "string value",
                "username": "string value",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "string value",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ]
                    ],
                    "longitude": 1.23,
                    "employeeCompany": "string value",
                    "employeeDepartment": "string value",
                    "latitude": 1.23,
                    "supportContactName": "string value",
                    "supportContactPhoneNumber": "string value",
                    "lastActivityAt": "string value",
                    "employeeClinicId": 123
                ],
                "email": "string value",
                "lastName": "string value"
            ],
            [
                "firstName": "string value",
                "username": "string value",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "string value",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ]
                    ],
                    "longitude": 1.23,
                    "employeeCompany": "string value",
                    "employeeDepartment": "string value",
                    "latitude": 1.23,
                    "supportContactName": "string value",
                    "supportContactPhoneNumber": "string value",
                    "lastActivityAt": "string value",
                    "employeeClinicId": 123
                ],
                "email": "string value",
                "lastName": "string value"
            ]
        ].map { $0.formatted }
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get all employees") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
    
    func testGetAllClinicEmployees() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/directory/employees/here"
        let request = get(path: path)
        let expectedResponse = [
            [
                "firstName": "string value",
                "username": "string value",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "string value",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ]
                    ],
                    "longitude": 1.23,
                    "employeeCompany": "string value",
                    "employeeDepartment": "string value",
                    "latitude": 1.23,
                    "supportContactName": "string value",
                    "supportContactPhoneNumber": "string value",
                    "lastActivityAt": "string value",
                    "employeeClinicId": 123
                ],
                "email": "string value",
                "lastName": "string value"
            ],
            [
                "firstName": "string value",
                "username": "string value",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "string value",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ]
                    ],
                    "longitude": 1.23,
                    "employeeCompany": "string value",
                    "employeeDepartment": "string value",
                    "latitude": 1.23,
                    "supportContactName": "string value",
                    "supportContactPhoneNumber": "string value",
                    "lastActivityAt": "string value",
                    "employeeClinicId": 123
                ],
                "email": "string value",
                "lastName": "string value"
            ],
            [
                "firstName": "string value",
                "username": "string value",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "string value",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ]
                    ],
                    "longitude": 1.23,
                    "employeeCompany": "string value",
                    "employeeDepartment": "string value",
                    "latitude": 1.23,
                    "supportContactName": "string value",
                    "supportContactPhoneNumber": "string value",
                    "lastActivityAt": "string value",
                    "employeeClinicId": 123
                ],
                "email": "string value",
                "lastName": "string value"
            ]
        ].map { $0.formatted }
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get all clinic employees") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
    
    func testSearchEmployees() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/directory/employees/search"
        let request = get(path: path)
        let expectedResponse = [
            [
                "firstName": "string value",
                "username": "string value",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "string value",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ]
                    ],
                    "longitude": 1.23,
                    "employeeCompany": "string value",
                    "employeeDepartment": "string value",
                    "latitude": 1.23,
                    "supportContactName": "string value",
                    "supportContactPhoneNumber": "string value",
                    "lastActivityAt": "string value",
                    "employeeClinicId": 123
                ],
                "email": "string value",
                "lastName": "string value"
            ],
            [
                "firstName": "string value",
                "username": "string value",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "string value",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ]
                    ],
                    "longitude": 1.23,
                    "employeeCompany": "string value",
                    "employeeDepartment": "string value",
                    "latitude": 1.23,
                    "supportContactName": "string value",
                    "supportContactPhoneNumber": "string value",
                    "lastActivityAt": "string value",
                    "employeeClinicId": 123
                ],
                "email": "string value",
                "lastName": "string value"
            ],
            [
                "firstName": "string value",
                "username": "string value",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "string value",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "string value"
                        ]
                    ],
                    "longitude": 1.23,
                    "employeeCompany": "string value",
                    "employeeDepartment": "string value",
                    "latitude": 1.23,
                    "supportContactName": "string value",
                    "supportContactPhoneNumber": "string value",
                    "lastActivityAt": "string value",
                    "employeeClinicId": 123
                ],
                "email": "string value",
                "lastName": "string value"
            ]
        ].map { $0.formatted }
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Search employees") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
    
    func testGetEmployeeTeam() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/directory/employees/team"
        let request = get(path: path)
        guard let expectedJson = expectedResponseFromJson(request: request) as? ResponseType else {
            return XCTFail("Could not find expected json file")
        }
        let expectedResponse = expectedJson.map { $0.formatted }
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get all employee team") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
    
    // MARK: Patient tests
    
    func testGetClinicPatients() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/directory/patients/here"
        let request = get(path: path)
        let expectedResponse = [
            [
                "lastVisit": [
                    "id": 123456789,
                    "patientRoom": "string value"
                ],
                "gender": "M",
                "test": true,
                "birthDate": "2017-07-21",
                "lastName": "string value",
                "fullName": "string value",
                "id": 123,
                "firstName": "string value"
            ],
            [
                "test": true,
                "birthDate": "2017-07-21",
                "firstName": "string value",
                "fullName": "string value",
                "lastName": "string value",
                "lastVisit": [
                    "id": 123456789,
                    "patientRoom": "string value"
                ],
                "id": 123,
                "gender": "M"
            ],
            [
                "gender": "M",
                "test": true,
                "lastVisit": [
                    "id": 123456789,
                    "patientRoom": "string value"
                ],
                "fullName": "string value",
                "firstName": "string value",
                "lastName": "string value",
                "id": 123,
                "birthDate": "2017-07-21"
            ]
        ].map { $0.formatted }
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get all favorite doctors") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
    
    func testSearchPatients() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/directory/patients/search"
        let request = get(path: path)
        let expectedResponse = [
            [
                "lastVisit": [
                    "id": 123456789,
                    "patientRoom": "string value"
                ],
                "gender": "M",
                "test": true,
                "birthDate": "2017-07-21",
                "lastName": "string value",
                "fullName": "string value",
                "id": 123,
                "firstName": "string value"
            ],
            [
                "test": true,
                "birthDate": "2017-07-21",
                "firstName": "string value",
                "fullName": "string value",
                "lastName": "string value",
                "lastVisit": [
                    "id": 123456789,
                    "patientRoom": "string value"
                ],
                "id": 123,
                "gender": "M"
            ],
            [
                "gender": "M",
                "test": true,
                "lastVisit": [
                    "id": 123456789,
                    "patientRoom": "string value"
                ],
                "fullName": "string value",
                "firstName": "string value",
                "lastName": "string value",
                "id": 123,
                "birthDate": "2017-07-21"
            ]
        ].map { $0.formatted }
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get all favorite doctors") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
    
    // MARK: Vacation tests
    
    func testSubmmitDoctorVacation() {
        typealias ResponseType = [String: Any]
        
        // Given
        let path = "/v1/doctors/agenda/vacations"
        let request = post(path: path)
        let expectedResponse = [
            "comment": "string value",
            "toDate": "2017-07-21",
            "vacationId": "string value",
            "fromDate": "2017-07-21"
        ].formatted
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Submit doctoc vacations") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [:] == expectedResponse)
    }
    
    func testUpdateDoctorVacation() {
        typealias ResponseType = [String: Any]
        
        // Given
        let path = "/v1/doctors/agenda/vacations"
        let request = patch(path: path)
        let expectedResponse = [
            "comment": "string value",
            "toDate": "2017-07-21",
            "vacationId": "string value",
            "fromDate": "2017-07-21"
        ].formatted
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Update doctoc vacations") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [:] == expectedResponse)
    }
    
    func testGetDoctorVacations() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/doctors/agenda/vacations"
        let request = get(path: path)
        let expectedResponse = [
            [
                "comment": "string value",
                "toDate": "2017-07-21",
                "vacationId": "string value",
                "fromDate": "2017-07-21"
            ],
            [
                "comment": "string value",
                "toDate": "2017-07-21",
                "vacationId": "string value",
                "fromDate": "2017-07-21"
            ],
            [
                "comment": "string value",
                "toDate": "2017-07-21",
                "vacationId": "string value",
                "fromDate": "2017-07-21"
            ]
        ].map { $0.formatted }
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get doctoc vacations") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
    
    func testDeleteDoctorVacation() {
        typealias ResponseType = [String: Any]
        
        // Given
        let path = "/v1/doctors/agenda/vacations"
        let request = delete(path: path)
        
        // When
        var responseCode: Int?
        call(request: request, description: "Get submit doctoc vacations") { (_: ResponseType?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertEqual(responseCode, 204)
    }
    
    // MARK: Invoice tests
    
    func testGetInvoiceSummary() {
        typealias ResponseType = [String: Any]
        
        // Given
        let path = "/v1/doctors/fees/invoices/summary"
        let request = get(path: path)
        let expectedResponse = [
            "toDate": "2017-07-21",
            "regions": [
                [
                    "patientRatio": 2.34,
                    "revenue": 2.34,
                    "revenueRatio": 2.34,
                    "regionId": "string value",
                    "patientCount": 123456789,
                    "regionName": "string value"
                ],
                [
                    "patientRatio": 2.34,
                    "revenue": 2.34,
                    "revenueRatio": 2.34,
                    "regionId": "string value",
                    "patientCount": 123456789,
                    "regionName": "string value"
                ],
                [
                    "patientRatio": 2.34,
                    "revenue": 2.34,
                    "revenueRatio": 2.34,
                    "regionId": "string value",
                    "patientCount": 123456789,
                    "regionName": "string value"
                ]
            ],
            "fromDate": "2017-07-21"
        ].formatted
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get invoice summary") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [:] == expectedResponse)
    }
    
    // MARK: Inventory tests
    
    func testGetTwitterPosts() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/social/twitter"
        let request = get(path: path)
        guard let expectedJson = expectedResponseFromJson(request: request) as? ResponseType else {
            return XCTFail("Could not find expected json file")
        }
        let expectedResponse = expectedJson.map { $0.formatted }
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get all Twitter posts") { (response: [[String: Any]]?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
    }
}
