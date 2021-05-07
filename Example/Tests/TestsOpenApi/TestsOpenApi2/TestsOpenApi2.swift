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
                "name": "Ida Adams",
                "maxLatitude": 1.23,
                "minLatitude": 1.23,
                "centerLatitude": 1.23,
                "centerLongitude": 1.23,
                "radius": 123,
                "admissionsEmail": "firstname@domain.com",
                "code": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "fluanceCompanyId": 123,
                "imagePath": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "infra": "SMN",
                "invoicingEmail": "firstname@domain.com",
                "id": 123,
                "minLongitude": 1.23,
                "maxLongitude": 1.23
            ],
            [
                "id": 123,
                "infra": "SMN",
                "radius": 123,
                "centerLongitude": 1.23,
                "name": "Ida Adams",
                "maxLongitude": 1.23,
                "fluanceCompanyId": 123,
                "minLatitude": 1.23,
                "admissionsEmail": "firstname@domain.com",
                "code": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "invoicingEmail": "firstname@domain.com",
                "centerLatitude": 1.23,
                "maxLatitude": 1.23,
                "minLongitude": 1.23,
                "imagePath": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            ],
            [
                "code": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "invoicingEmail": "firstname@domain.com",
                "maxLongitude": 1.23,
                "fluanceCompanyId": 123,
                "centerLatitude": 1.23,
                "imagePath": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "radius": 123,
                "infra": "SMN",
                "name": "Ida Adams",
                "admissionsEmail": "firstname@domain.com",
                "centerLongitude": 1.23,
                "minLongitude": 1.23,
                "minLatitude": 1.23,
                "id": 123,
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
            "invoicingEmail": "firstname@domain.com",
            "admissionsEmail": "firstname@domain.com",
            "minLatitude": 1.23,
            "maxLatitude": 1.23,
            "visible": true,
            "minLongitude": 1.23,
            "maxLongitude": 1.23,
            "centerLatitude": 1.23,
            "dwhClinicCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "centerLongitude": 1.23,
            "name": "Ida Adams",
            "id": 123,
            "radius": 123,
            "fluanceCompanyId": 123,
            "code": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "infra": "SMN"
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
                "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "autoInvoiceValidation": true,
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            ],
            [
                "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "autoInvoiceValidation": true,
                "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            ],
            [
                "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "autoInvoiceValidation": true,
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
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
            "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
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
            "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
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
            "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "awards": [
                [
                    "award": "PICTURE_OF_THE_WEEK",
                    "awardedAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                ],
                [
                    "award": "PICTURE_OF_THE_WEEK",
                    "awardedAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                ],
                [
                    "award": "PICTURE_OF_THE_WEEK",
                    "awardedAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                ]
            ],
            "clinicId": 123,
            "picture": [
                "id": 123456789,
                "hash": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "uploadedBy": [
                    "email": "firstname@domain.com",
                    "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "lastName": "Adams",
                    "firstName": "Ida"
                ],
                "uriPath": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            ],
            "id": 123456789,
            "submittedAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
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
            "clinic": [
                "code": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "id": 123,
                "name": "Ida Adams",
                "infra": "SMN",
                "fluanceCompanyId": 123
            ],
            "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "menu": 123,
            "rating": 123,
            "date": "2017-07-21",
            "id": 123456789,
            "commenter": [
                "firstName": "Ida",
                "lastName": "Adams",
                "email": "firstname@domain.com",
                "clinicId": 123,
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            ]
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
                "rating": 123,
                "commenter": [
                    "lastName": "Adams",
                    "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "firstName": "Ida",
                    "clinicId": 123,
                    "email": "firstname@domain.com"
                ],
                "date": "2017-07-21",
                "menu": 123,
                "clinic": [
                    "code": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "id": 123,
                    "name": "Ida Adams",
                    "infra": "SMN",
                    "fluanceCompanyId": 123
                ],
                "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "id": 123456789
            ],
            [
                "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "rating": 123,
                "commenter": [
                    "lastName": "Adams",
                    "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "firstName": "Ida",
                    "clinicId": 123,
                    "email": "firstname@domain.com"
                ],
                "id": 123456789,
                "clinic": [
                    "code": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "id": 123,
                    "name": "Ida Adams",
                    "infra": "SMN",
                    "fluanceCompanyId": 123
                ],
                "date": "2017-07-21",
                "menu": 123
            ],
            [
                "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "commenter": [
                    "lastName": "Adams",
                    "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "firstName": "Ida",
                    "clinicId": 123,
                    "email": "firstname@domain.com"
                ],
                "menu": 123,
                "rating": 123,
                "date": "2017-07-21",
                "id": 123456789,
                "clinic": [
                    "code": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "id": 123,
                    "name": "Ida Adams",
                    "infra": "SMN",
                    "fluanceCompanyId": 123
                ]
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
                "email": "firstname@domain.com",
                "firstName": "Ida",
                "distance": 123,
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ]
                    ],
                    "longitude": -156.65548382095133,
                    "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeDepartment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "latitude": -58.17256227443719,
                    "employeeCompany": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeClinicId": 123
                ],
                "lastName": "Adams",
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "isFavorite": true
            ],
            [
                "email": "firstname@domain.com",
                "distance": 123,
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ]
                    ],
                    "longitude": -156.65548382095133,
                    "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeDepartment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "latitude": -58.17256227443719,
                    "employeeCompany": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeClinicId": 123
                ],
                "isFavorite": true,
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "firstName": "Ida",
                "lastName": "Adams"
            ],
            [
                "isFavorite": true,
                "firstName": "Ida",
                "lastName": "Adams",
                "distance": 123,
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ]
                    ],
                    "longitude": -156.65548382095133,
                    "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeDepartment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "latitude": -58.17256227443719,
                    "employeeCompany": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeClinicId": 123
                ],
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "email": "firstname@domain.com"
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
                "email": "firstname@domain.com",
                "firstName": "Ida",
                "distance": 123,
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ]
                    ],
                    "longitude": -156.65548382095133,
                    "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeDepartment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "latitude": -58.17256227443719,
                    "employeeCompany": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeClinicId": 123
                ],
                "lastName": "Adams",
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "isFavorite": true
            ],
            [
                "email": "firstname@domain.com",
                "distance": 123,
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ]
                    ],
                    "longitude": -156.65548382095133,
                    "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeDepartment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "latitude": -58.17256227443719,
                    "employeeCompany": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeClinicId": 123
                ],
                "isFavorite": true,
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "firstName": "Ida",
                "lastName": "Adams"
            ],
            [
                "isFavorite": true,
                "firstName": "Ida",
                "lastName": "Adams",
                "distance": 123,
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ]
                    ],
                    "longitude": -156.65548382095133,
                    "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeDepartment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "latitude": -58.17256227443719,
                    "employeeCompany": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeClinicId": 123
                ],
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "email": "firstname@domain.com"
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
                "email": "firstname@domain.com",
                "firstName": "Ida",
                "distance": 123,
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ]
                    ],
                    "longitude": -156.65548382095133,
                    "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeDepartment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "latitude": -58.17256227443719,
                    "employeeCompany": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeClinicId": 123
                ],
                "lastName": "Adams",
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "isFavorite": true
            ],
            [
                "email": "firstname@domain.com",
                "distance": 123,
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ]
                    ],
                    "longitude": -156.65548382095133,
                    "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeDepartment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "latitude": -58.17256227443719,
                    "employeeCompany": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeClinicId": 123
                ],
                "isFavorite": true,
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "firstName": "Ida",
                "lastName": "Adams"
            ],
            [
                "isFavorite": true,
                "firstName": "Ida",
                "lastName": "Adams",
                "distance": 123,
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ]
                    ],
                    "longitude": -156.65548382095133,
                    "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeDepartment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "latitude": -58.17256227443719,
                    "employeeCompany": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeClinicId": 123
                ],
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "email": "firstname@domain.com"
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
                "email": "firstname@domain.com",
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ]
                    ],
                    "longitude": -156.65548382095133,
                    "employeeCompany": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeDepartment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "latitude": -58.17256227443719,
                    "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeClinicId": 123
                ],
                "firstName": "Ida",
                "lastName": "Adams"
            ],
            [
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "lastName": "Adams",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ]
                    ],
                    "longitude": -156.65548382095133,
                    "employeeCompany": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeDepartment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "latitude": -58.17256227443719,
                    "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeClinicId": 123
                ],
                "firstName": "Ida",
                "email": "firstname@domain.com"
            ],
            [
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "email": "firstname@domain.com",
                "firstName": "Ida",
                "lastName": "Adams",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ]
                    ],
                    "longitude": -156.65548382095133,
                    "employeeCompany": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeDepartment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "latitude": -58.17256227443719,
                    "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeClinicId": 123
                ]
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
                "email": "firstname@domain.com",
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ]
                    ],
                    "longitude": -156.65548382095133,
                    "employeeCompany": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeDepartment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "latitude": -58.17256227443719,
                    "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeClinicId": 123
                ],
                "firstName": "Ida",
                "lastName": "Adams"
            ],
            [
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "lastName": "Adams",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ]
                    ],
                    "longitude": -156.65548382095133,
                    "employeeCompany": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeDepartment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "latitude": -58.17256227443719,
                    "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeClinicId": 123
                ],
                "firstName": "Ida",
                "email": "firstname@domain.com"
            ],
            [
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "email": "firstname@domain.com",
                "firstName": "Ida",
                "lastName": "Adams",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ]
                    ],
                    "longitude": -156.65548382095133,
                    "employeeCompany": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeDepartment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "latitude": -58.17256227443719,
                    "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeClinicId": 123
                ]
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
                "email": "firstname@domain.com",
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ]
                    ],
                    "longitude": -156.65548382095133,
                    "employeeCompany": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeDepartment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "latitude": -58.17256227443719,
                    "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeClinicId": 123
                ],
                "firstName": "Ida",
                "lastName": "Adams"
            ],
            [
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "lastName": "Adams",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ]
                    ],
                    "longitude": -156.65548382095133,
                    "employeeCompany": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeDepartment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "latitude": -58.17256227443719,
                    "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeClinicId": 123
                ],
                "firstName": "Ida",
                "email": "firstname@domain.com"
            ],
            [
                "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "email": "firstname@domain.com",
                "firstName": "Ida",
                "lastName": "Adams",
                "metadata": [
                    "gender": "M",
                    "lastLocalizationAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "externalPhoneNumbers": [
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ],
                        [
                            "visible": true,
                            "phoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        ]
                    ],
                    "longitude": -156.65548382095133,
                    "employeeCompany": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeDepartment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "supportContactName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "latitude": -58.17256227443719,
                    "supportContactPhoneNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "lastActivityAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "employeeClinicId": 123
                ]
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
                    "patientRoom": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                ],
                "gender": "M",
                "test": true,
                "birthDate": "2017-07-21",
                "lastName": "Adams",
                "fullName": "Ida Adams",
                "id": 123,
                "firstName": "Ida"
            ],
            [
                "test": true,
                "birthDate": "2017-07-21",
                "firstName": "Ida",
                "fullName": "Ida Adams",
                "lastName": "Adams",
                "lastVisit": [
                    "id": 123456789,
                    "patientRoom": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                ],
                "id": 123,
                "gender": "M"
            ],
            [
                "gender": "M",
                "test": true,
                "lastVisit": [
                    "id": 123456789,
                    "patientRoom": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                ],
                "fullName": "Ida Adams",
                "firstName": "Ida",
                "lastName": "Adams",
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
                    "patientRoom": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                ],
                "gender": "M",
                "test": true,
                "birthDate": "2017-07-21",
                "lastName": "Adams",
                "fullName": "Ida Adams",
                "id": 123,
                "firstName": "Ida"
            ],
            [
                "test": true,
                "birthDate": "2017-07-21",
                "firstName": "Ida",
                "fullName": "Ida Adams",
                "lastName": "Adams",
                "lastVisit": [
                    "id": 123456789,
                    "patientRoom": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                ],
                "id": 123,
                "gender": "M"
            ],
            [
                "gender": "M",
                "test": true,
                "lastVisit": [
                    "id": 123456789,
                    "patientRoom": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                ],
                "fullName": "Ida Adams",
                "firstName": "Ida",
                "lastName": "Adams",
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
            "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "toDate": "2017-07-21",
            "vacationId": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
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
            "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "toDate": "2017-07-21",
            "vacationId": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
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
                "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "toDate": "2017-07-21",
                "vacationId": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "fromDate": "2017-07-21"
            ],
            [
                "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "toDate": "2017-07-21",
                "vacationId": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "fromDate": "2017-07-21"
            ],
            [
                "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "toDate": "2017-07-21",
                "vacationId": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
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
                    "regionId": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "patientCount": 123456789,
                    "regionName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                ],
                [
                    "patientRatio": 2.34,
                    "revenue": 2.34,
                    "revenueRatio": 2.34,
                    "regionId": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "patientCount": 123456789,
                    "regionName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                ],
                [
                    "patientRatio": 2.34,
                    "revenue": 2.34,
                    "revenueRatio": 2.34,
                    "regionId": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "patientCount": 123456789,
                    "regionName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
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
    
    func testGetValidInvoices() {
        typealias ResponseType = [[String: Any]]
        
        // Given
        let path = "/v1/doctors/fees/invoices/valid"
        let request = get(path: path)
        let expectedResponse = [
            [
                "accountingDate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "id": 123,
                "visa": "APPROVED",
                "clinicId": 123,
                "treatments": [
                    [
                        "grossAmount": 2.3399999999999999,
                        "feeType": "M",
                        "quantity": 123,
                        "id": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "netAmount": 2.3399999999999999,
                        "grpRateCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "points": 2.3399999999999999,
                        "clinicId": 123,
                        "visitId": 123,
                        "invoiceId": 123,
                        "designationRate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "treatmentDate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "visa": "APPROVED",
                        "refundRate": 2.3399999999999999,
                        "patientId": 123,
                        "contestedAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    [
                        "grossAmount": 2.3399999999999999,
                        "feeType": "M",
                        "quantity": 123,
                        "id": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "netAmount": 2.3399999999999999,
                        "grpRateCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "points": 2.3399999999999999,
                        "clinicId": 123,
                        "visitId": 123,
                        "invoiceId": 123,
                        "designationRate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "treatmentDate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "visa": "APPROVED",
                        "refundRate": 2.3399999999999999,
                        "patientId": 123,
                        "contestedAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    [
                        "grossAmount": 2.3399999999999999,
                        "feeType": "M",
                        "quantity": 123,
                        "id": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "netAmount": 2.3399999999999999,
                        "grpRateCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "points": 2.3399999999999999,
                        "clinicId": 123,
                        "visitId": 123,
                        "invoiceId": 123,
                        "designationRate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "treatmentDate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "visa": "APPROVED",
                        "refundRate": 2.3399999999999999,
                        "patientId": 123,
                        "contestedAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ]
                ],
                "visitId": 123,
                "patient": [
                    "firstName": "Ida",
                    "id": 123,
                    "gender": "M",
                    "lastName": "Adams",
                    "birthDate": "2017-07-21"
                ],
                "paymentStatus": "PAID",
                "contestedAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            ],
            [
                "clinicId": 123,
                "treatments": [
                    [
                        "grossAmount": 2.3399999999999999,
                        "feeType": "M",
                        "quantity": 123,
                        "id": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "netAmount": 2.3399999999999999,
                        "grpRateCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "points": 2.3399999999999999,
                        "clinicId": 123,
                        "visitId": 123,
                        "invoiceId": 123,
                        "designationRate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "treatmentDate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "visa": "APPROVED",
                        "refundRate": 2.3399999999999999,
                        "patientId": 123,
                        "contestedAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    [
                        "grossAmount": 2.3399999999999999,
                        "feeType": "M",
                        "quantity": 123,
                        "id": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "netAmount": 2.3399999999999999,
                        "grpRateCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "points": 2.3399999999999999,
                        "clinicId": 123,
                        "visitId": 123,
                        "invoiceId": 123,
                        "designationRate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "treatmentDate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "visa": "APPROVED",
                        "refundRate": 2.3399999999999999,
                        "patientId": 123,
                        "contestedAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    [
                        "grossAmount": 2.3399999999999999,
                        "feeType": "M",
                        "quantity": 123,
                        "id": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "netAmount": 2.3399999999999999,
                        "grpRateCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "points": 2.3399999999999999,
                        "clinicId": 123,
                        "visitId": 123,
                        "invoiceId": 123,
                        "designationRate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "treatmentDate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "visa": "APPROVED",
                        "refundRate": 2.3399999999999999,
                        "patientId": 123,
                        "contestedAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ]
                ],
                "paymentStatus": "PAID",
                "id": 123,
                "accountingDate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "visitId": 123,
                "patient": [
                    "firstName": "Ida",
                    "id": 123,
                    "gender": "M",
                    "lastName": "Adams",
                    "birthDate": "2017-07-21"
                ],
                "visa": "APPROVED",
                "contestedAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            ],
            [
                "patient": [
                    "firstName": "Ida",
                    "id": 123,
                    "gender": "M",
                    "lastName": "Adams",
                    "birthDate": "2017-07-21"
                ],
                "treatments": [
                    [
                        "grossAmount": 2.3399999999999999,
                        "feeType": "M",
                        "quantity": 123,
                        "id": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "netAmount": 2.3399999999999999,
                        "grpRateCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "points": 2.3399999999999999,
                        "clinicId": 123,
                        "visitId": 123,
                        "invoiceId": 123,
                        "designationRate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "treatmentDate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "visa": "APPROVED",
                        "refundRate": 2.3399999999999999,
                        "patientId": 123,
                        "contestedAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    [
                        "grossAmount": 2.3399999999999999,
                        "feeType": "M",
                        "quantity": 123,
                        "id": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "netAmount": 2.3399999999999999,
                        "grpRateCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "points": 2.3399999999999999,
                        "clinicId": 123,
                        "visitId": 123,
                        "invoiceId": 123,
                        "designationRate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "treatmentDate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "visa": "APPROVED",
                        "refundRate": 2.3399999999999999,
                        "patientId": 123,
                        "contestedAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    [
                        "grossAmount": 2.3399999999999999,
                        "feeType": "M",
                        "quantity": 123,
                        "id": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "netAmount": 2.3399999999999999,
                        "grpRateCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "points": 2.3399999999999999,
                        "clinicId": 123,
                        "visitId": 123,
                        "invoiceId": 123,
                        "designationRate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "treatmentDate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "visa": "APPROVED",
                        "refundRate": 2.3399999999999999,
                        "patientId": 123,
                        "contestedAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ]
                ],
                "contestedAt": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "visa": "APPROVED",
                "visitId": 123,
                "paymentStatus": "PAID",
                "id": 123,
                "accountingDate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "clinicId": 123
            ]
        ].map { $0.formatted }
        
        // When
        var responseJson: ResponseType?
        call(request: request, description: "Get valid invoices") { (response: ResponseType?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [[:]] == expectedResponse)
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
