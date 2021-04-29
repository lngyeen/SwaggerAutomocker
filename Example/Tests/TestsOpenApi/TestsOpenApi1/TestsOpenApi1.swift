import SwaggerAutomocker
import XCTest

final class TestsOpenApi1: Tests {
    override class var jsonFileName: String {
        return "openapi1"
    }
    
    // MARK: User tests

    func testRegistration() {
        // Given
        let request = post(path: "/api/v1/registration/user", body: [
            "comment": "string value",
            "email": "string value",
            "firstName": "string value",
            "focusmeEntityId": 123,
            "glnNumber": "string value",
            "lastName": "string value",
            "nickName": "string value",
            "password": "string value",
            "phone": "0123456789",
            "termAndConditions": true,
            "userRole": "PATIENT"
        ])
        let expectedResponse = [
            "nickName": "string value",
            "status": "ACTIVE",
            "userRole": "ADMIN",
            "comment": "string value",
            "focusmeEntityId": 123456789,
            "description": "string value",
            "topics": [
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "string value"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "string value"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "string value"
                ]
            ],
            "settings": [
                "availability": "EVERY_TIME",
                "id": 123456789,
                "availabilityUntil": [
                    "hour": 123,
                    "nano": 123,
                    "minute": 123,
                    "second": 123
                ],
                "pushNotifications": true,
                "showPostCode": true,
                "daysOfWeek": [
                    "FRIDAY",
                    "FRIDAY",
                    "FRIDAY"
                ],
                "availabilityFrom": [
                    "nano": 123,
                    "second": 123,
                    "minute": 123,
                    "hour": 123
                ],
                "viewType": "EVERY_BODY",
                "language": "DE",
                "showHospital": true,
                "revealFullName": true
            ],
            "lastName": "string value",
            "glnNumber": "string value",
            "registration": [
                "id": 123456789,
                "invitationCode": "string value",
                "invitationLink": "string value"
            ],
            "avatar": "U3dhZ2dlciByb2Nrcw==",
            "phone": "string value",
            "firstName": "string value",
            "id": 123456789,
            "termAndConditions": true,
            "email": "string value",
            "profile": [
                "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                "additionalHospitals": [
                    [
                        "name": "string value",
                        "id": 123456789
                    ],
                    [
                        "name": "string value",
                        "id": 123456789
                    ],
                    [
                        "name": "string value",
                        "id": 123456789
                    ]
                ],
                "id": 123456789,
                "postCode": "string value",
                "ageGroup": "FIFTY_TO_FIFTY_NINE",
                "diseaseStatuses": [
                    "BRCA_PLUS",
                    "BRCA_PLUS",
                    "BRCA_PLUS"
                ]
            ]
        ].formatted
        
        // When
        var jsonResponse: [String: Any]?
        call(request: request, description: "Registration User") { (response: [String: Any]?, _, _, _) in
            jsonResponse = response
        }
    
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
    
    func testRegistrationResendCode() {
        // Given
        let request = post(path: "/api/v1/registration/resend-code/123")
        let expectedResponse = [
            "nickName": "string value",
            "status": "ACTIVE",
            "userRole": "ADMIN",
            "comment": "string value",
            "focusmeEntityId": 123456789,
            "description": "string value",
            "topics": [
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "string value"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "string value"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "string value"
                ]
            ],
            "settings": [
                "availability": "EVERY_TIME",
                "id": 123456789,
                "availabilityUntil": [
                    "hour": 123,
                    "nano": 123,
                    "minute": 123,
                    "second": 123
                ],
                "pushNotifications": true,
                "showPostCode": true,
                "daysOfWeek": [
                    "FRIDAY",
                    "FRIDAY",
                    "FRIDAY"
                ],
                "availabilityFrom": [
                    "nano": 123,
                    "second": 123,
                    "minute": 123,
                    "hour": 123
                ],
                "viewType": "EVERY_BODY",
                "language": "DE",
                "showHospital": true,
                "revealFullName": true
            ],
            "lastName": "string value",
            "glnNumber": "string value",
            "registration": [
                "id": 123456789,
                "invitationCode": "string value",
                "invitationLink": "string value"
            ],
            "avatar": "U3dhZ2dlciByb2Nrcw==",
            "phone": "string value",
            "firstName": "string value",
            "id": 123456789,
            "termAndConditions": true,
            "email": "string value",
            "profile": [
                "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                "additionalHospitals": [
                    [
                        "name": "string value",
                        "id": 123456789
                    ],
                    [
                        "name": "string value",
                        "id": 123456789
                    ],
                    [
                        "name": "string value",
                        "id": 123456789
                    ]
                ],
                "id": 123456789,
                "postCode": "string value",
                "ageGroup": "FIFTY_TO_FIFTY_NINE",
                "diseaseStatuses": [
                    "BRCA_PLUS",
                    "BRCA_PLUS",
                    "BRCA_PLUS"
                ]
            ]
        ].formatted
        
        // When
        var jsonResponse: [String: Any]?
        call(request: request, description: "Registration user resend code") { (response: [String: Any]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
    
    func testRegistrationUserVerification() {
        // Given
        let request = post(path: "/api/v1/registration/verification/123")
        let expectedResponse = [
            "email": "string value",
            "id": 123456789,
            "userRole": "ADMIN",
            "focusmeEntityId": 123456789,
            "glnNumber": "string value",
            "topics": [
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "string value"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "string value"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "string value"
                ]
            ],
            "description": "string value",
            "comment": "string value",
            "lastName": "string value",
            "settings": [
                "availability": "EVERY_TIME",
                "availabilityUntil": [
                    "hour": 123,
                    "nano": 123,
                    "minute": 123,
                    "second": 123
                ],
                "id": 123456789,
                "pushNotifications": true,
                "showHospital": true,
                "daysOfWeek": [
                    "FRIDAY",
                    "FRIDAY",
                    "FRIDAY"
                ],
                "revealFullName": true,
                "viewType": "EVERY_BODY",
                "showPostCode": true,
                "language": "DE",
                "availabilityFrom": [
                    "second": 123,
                    "nano": 123,
                    "minute": 123,
                    "hour": 123
                ]
            ],
            "status": "ACTIVE",
            "firstName": "string value",
            "nickName": "string value",
            "profile": [
                "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                "additionalHospitals": [
                    [
                        "id": 123456789,
                        "name": "string value"
                    ],
                    [
                        "id": 123456789,
                        "name": "string value"
                    ],
                    [
                        "id": 123456789,
                        "name": "string value"
                    ]
                ],
                "id": 123456789,
                "postCode": "string value",
                "ageGroup": "FIFTY_TO_FIFTY_NINE",
                "diseaseStatuses": [
                    "BRCA_PLUS",
                    "BRCA_PLUS",
                    "BRCA_PLUS"
                ]
            ],
            "termAndConditions": true,
            "phone": "string value",
            "avatar": "U3dhZ2dlciByb2Nrcw==",
            "registration": [
                "id": 123456789,
                "invitationCode": "string value",
                "invitationLink": "string value"
            ]
        ].formatted
        
        // When
        var jsonResponse: [String: Any]?
        call(request: request, description: "Registration user verification") { (response: [String: Any]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
    
    func testRegistrationUserApprove() {
        // Given
        let request = post(path: "/api/v1/registration/approve/123")
        let expectedResponse = [
            "topics": [
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "string value"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "string value"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "string value"
                ]
            ],
            "registration": [
                "id": 123456789,
                "invitationCode": "string value",
                "invitationLink": "string value"
            ],
            "settings": [
                "availability": "EVERY_TIME",
                "showPostCode": true,
                "revealFullName": true,
                "pushNotifications": true,
                "id": 123456789,
                "daysOfWeek": [
                    "FRIDAY",
                    "FRIDAY",
                    "FRIDAY"
                ],
                "availabilityFrom": [
                    "nano": 123,
                    "second": 123,
                    "minute": 123,
                    "hour": 123
                ],
                "viewType": "EVERY_BODY",
                "showHospital": true,
                "availabilityUntil": [
                    "nano": 123,
                    "hour": 123,
                    "minute": 123,
                    "second": 123
                ],
                "language": "DE"
            ],
            "firstName": "string value",
            "phone": "string value",
            "status": "ACTIVE",
            "avatar": "U3dhZ2dlciByb2Nrcw==",
            "nickName": "string value",
            "termAndConditions": true,
            "description": "string value",
            "comment": "string value",
            "lastName": "string value",
            "id": 123456789,
            "glnNumber": "string value",
            "profile": [
                "ageGroup": "FIFTY_TO_FIFTY_NINE",
                "additionalHospitals": [
                    [
                        "name": "string value",
                        "id": 123456789
                    ],
                    [
                        "name": "string value",
                        "id": 123456789
                    ],
                    [
                        "name": "string value",
                        "id": 123456789
                    ]
                ],
                "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                "postCode": "string value",
                "id": 123456789,
                "diseaseStatuses": [
                    "BRCA_PLUS",
                    "BRCA_PLUS",
                    "BRCA_PLUS"
                ]
            ],
            "focusmeEntityId": 123456789,
            "email": "string value",
            "userRole": "ADMIN"
        ].formatted
        
        // When
        var jsonResponse: [String: Any]?
        call(request: request, description: "Registration user approve") { (response: [String: Any]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
    
    func testGetCurrentUser() {
        // Given
        let request = get(path: "/api/v1/user/current")
        let expectedResponse = [
            "focusmeEntityId": 123456789,
            "profile": [
                "ageGroup": "FIFTY_TO_FIFTY_NINE",
                "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                "id": 123456789,
                "postCode": "string value",
                "additionalHospitals": [
                    [
                        "id": 123456789,
                        "name": "string value"
                    ],
                    [
                        "id": 123456789,
                        "name": "string value"
                    ],
                    [
                        "id": 123456789,
                        "name": "string value"
                    ]
                ],
                "diseaseStatuses": [
                    "BRCA_PLUS",
                    "BRCA_PLUS",
                    "BRCA_PLUS"
                ]
            ],
            "email": "string value",
            "registration": [
                "id": 123456789,
                "invitationCode": "string value",
                "invitationLink": "string value"
            ],
            "nickName": "string value",
            "avatar": "U3dhZ2dlciByb2Nrcw==",
            "status": "ACTIVE",
            "glnNumber": "string value",
            "topics": [
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "string value"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "string value"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "string value"
                ]
            ],
            "termAndConditions": true,
            "phone": "string value",
            "lastName": "string value",
            "id": 123456789,
            "comment": "string value",
            "description": "string value",
            "settings": [
                "pushNotifications": true,
                "availabilityUntil": [
                    "hour": 123,
                    "nano": 123,
                    "minute": 123,
                    "second": 123
                ],
                "revealFullName": true,
                "id": 123456789,
                "showHospital": true,
                "availabilityFrom": [
                    "second": 123,
                    "nano": 123,
                    "minute": 123,
                    "hour": 123
                ],
                "daysOfWeek": [
                    "FRIDAY",
                    "FRIDAY",
                    "FRIDAY"
                ],
                "viewType": "EVERY_BODY",
                "availability": "EVERY_TIME",
                "showPostCode": true,
                "language": "DE"
            ],
            "userRole": "ADMIN",
            "firstName": "string value"
        ].formatted
        
        // When
        var jsonResponse: [String: Any]?
        call(request: request, description: "Get Current User") { (response: [String: Any]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
    
    func testGetUserById() {
        // Given
        let request = get(path: "/api/v1/user/123")
        let expectedResponse = [
            "focusmeEntityId": 123456789,
            "profile": [
                "ageGroup": "FIFTY_TO_FIFTY_NINE",
                "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                "id": 123456789,
                "postCode": "string value",
                "additionalHospitals": [
                    [
                        "id": 123456789,
                        "name": "string value"
                    ],
                    [
                        "id": 123456789,
                        "name": "string value"
                    ],
                    [
                        "id": 123456789,
                        "name": "string value"
                    ]
                ],
                "diseaseStatuses": [
                    "BRCA_PLUS",
                    "BRCA_PLUS",
                    "BRCA_PLUS"
                ]
            ],
            "email": "string value",
            "registration": [
                "id": 123456789,
                "invitationCode": "string value",
                "invitationLink": "string value"
            ],
            "nickName": "string value",
            "avatar": "U3dhZ2dlciByb2Nrcw==",
            "status": "ACTIVE",
            "glnNumber": "string value",
            "topics": [
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "string value"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "string value"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "string value"
                ]
            ],
            "termAndConditions": true,
            "phone": "string value",
            "lastName": "string value",
            "id": 123456789,
            "comment": "string value",
            "description": "string value",
            "settings": [
                "pushNotifications": true,
                "availabilityUntil": [
                    "hour": 123,
                    "nano": 123,
                    "minute": 123,
                    "second": 123
                ],
                "revealFullName": true,
                "id": 123456789,
                "showHospital": true,
                "availabilityFrom": [
                    "second": 123,
                    "nano": 123,
                    "minute": 123,
                    "hour": 123
                ],
                "daysOfWeek": [
                    "FRIDAY",
                    "FRIDAY",
                    "FRIDAY"
                ],
                "viewType": "EVERY_BODY",
                "availability": "EVERY_TIME",
                "showPostCode": true,
                "language": "DE"
            ],
            "userRole": "ADMIN",
            "firstName": "string value"
        ].formatted
        
        // When
        var jsonResponse: [String: Any]?
        call(request: request, description: "Get User by Id") { (response: [String: Any]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
    
    /// DEMO With example data
    func testGetAllUsers() {
        // Given
        let request = get(path: "/api/v1/user")
        let expectedResponse = [
            [
                "userRole": "PATIENT",
                "nickName": "Luu Nguyen 1",
                "email": "luunguyen1@novahub.vn",
                "lastName": "Truong Luu 1",
                "firstName": "Nguyen",
                "focusmeEntity": [
                    "name": "Luu Nguyen 1",
                    "id": 3694734
                ],
                "status": "ACTIVE",
                "avatar": "U3dhZ2dlciByb2Nrcw==",
                "id": 98349702
            ],
            [
                "id": 98349702,
                "firstName": "Nguyen",
                "userRole": "PATIENT",
                "focusmeEntity": [
                    "name": "Luu Nguyen 2",
                    "id": 3694734
                ],
                "lastName": "Truong Luu 2",
                "nickName": "Luu Nguyen 2",
                "avatar": "U3dhZ2dlciByb2Nrcw==",
                "email": "luunguyen2@novahub.vn",
                "status": "IN_REGISTRATION"
            ],
            [
                "userRole": "PATIENT",
                "lastName": "Truong Luu 3",
                "focusmeEntity": [
                    "name": "Luu Nguyen 3",
                    "id": 3694734
                ],
                "status": "NON_ACTIVE",
                "firstName": "Nguyen",
                "avatar": "U3dhZ2dlciByb2Nrcw==",
                "nickName": "Luu Nguyen 3",
                "id": 98349702,
                "email": "luunguyen3@novahub.vn"
            ]
        ].map { $0.formatted }

        // When
        var jsonResponse: [[String: Any]]?
        call(request: request, description: "Loading Users") { (response: [[String: Any]]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [[:]] == expectedResponse)
    }
    
    func testUpdateUser() {
        // Given
        let request = put(path: "/api/v1/user/123")
        let expectedResponse =
            [
                "focusmeEntityId": 123456789,
                "profile": [
                    "ageGroup": "FIFTY_TO_FIFTY_NINE",
                    "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                    "id": 123456789,
                    "postCode": "string value",
                    "additionalHospitals": [
                        [
                            "id": 123456789,
                            "name": "string value"
                        ],
                        [
                            "id": 123456789,
                            "name": "string value"
                        ],
                        [
                            "id": 123456789,
                            "name": "string value"
                        ]
                    ],
                    "diseaseStatuses": [
                        "BRCA_PLUS",
                        "BRCA_PLUS",
                        "BRCA_PLUS"
                    ]
                ],
                "email": "string value",
                "registration": [
                    "id": 123456789,
                    "invitationCode": "string value",
                    "invitationLink": "string value"
                ],
                "nickName": "string value",
                "avatar": "U3dhZ2dlciByb2Nrcw==",
                "status": "ACTIVE",
                "glnNumber": "string value",
                "topics": [
                    [
                        "status": "ACTIVE",
                        "id": 123456789,
                        "icon": "U3dhZ2dlciByb2Nrcw==",
                        "name": "string value"
                    ],
                    [
                        "status": "ACTIVE",
                        "id": 123456789,
                        "icon": "U3dhZ2dlciByb2Nrcw==",
                        "name": "string value"
                    ],
                    [
                        "status": "ACTIVE",
                        "id": 123456789,
                        "icon": "U3dhZ2dlciByb2Nrcw==",
                        "name": "string value"
                    ]
                ],
                "termAndConditions": true,
                "phone": "string value",
                "lastName": "string value",
                "id": 123456789,
                "comment": "string value",
                "description": "string value",
                "settings": [
                    "pushNotifications": true,
                    "availabilityUntil": [
                        "hour": 123,
                        "nano": 123,
                        "minute": 123,
                        "second": 123
                    ],
                    "revealFullName": true,
                    "id": 123456789,
                    "showHospital": true,
                    "availabilityFrom": [
                        "second": 123,
                        "nano": 123,
                        "minute": 123,
                        "hour": 123
                    ],
                    "daysOfWeek": [
                        "FRIDAY",
                        "FRIDAY",
                        "FRIDAY"
                    ],
                    "viewType": "EVERY_BODY",
                    "availability": "EVERY_TIME",
                    "showPostCode": true,
                    "language": "DE"
                ],
                "userRole": "ADMIN",
                "firstName": "string value"
            ].formatted

        // When
        var jsonResponse: [String: Any]?
        call(request: request, description: "Update user by id") { (response: [String: Any]?, _, _, _) in
            jsonResponse = response
        }
            
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
    
    func testDeleteUser() {
        // Given
        let request = delete(path: "/api/v1/user/123")
        
        // When
        var responseCode: Int?
        call(request: request, description: "Delete user") { (_: [String: Any]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertEqual(responseCode, 200)
    }
    
    func testResetPasswordRequest() {
        // Given
        let request = put(path: "/api/v1/user/reset-password")
        
        // When
        var responseCode: Int?
        call(request: request, description: "Reset password request") { (_: [String: Any]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertEqual(responseCode, 200)
    }
    
    func testResetPasswordUpdate() {
        // Given
        let request = put(path: "/api/v1/user/10/reset-password")
        
        // When
        var responseCode: Int?
        call(request: request, description: "Reset password update") { (_: [String: Any]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertEqual(responseCode, 200)
    }
    
    // MARK: Topic tests
    
    func testGetAllTopics() {
        // Given
        let request = get(path: "/api/v1/topic")
        let expectedResponse = [
            [
                "name": "string value",
                "icon": "U3dhZ2dlciByb2Nrcw==",
                "status": "ACTIVE",
                "id": 123456789
            ],
            [
                "icon": "U3dhZ2dlciByb2Nrcw==",
                "id": 123456789,
                "name": "string value",
                "status": "ACTIVE"
            ],
            [
                "name": "string value",
                "icon": "U3dhZ2dlciByb2Nrcw==",
                "id": 123456789,
                "status": "ACTIVE"
            ]
        ].map { $0.formatted }
        
        // When
        var jsonResponse: [[String: Any]]?
        call(request: request, description: "Get all topics") { (response: [[String: Any]]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [[:]] == expectedResponse)
    }
    
    func testGetTopicById() {
        // Given
        let request = get(path: "/api/v1/topic/123")
        let expectedResponse = [
            "name": "string value",
            "icon": "U3dhZ2dlciByb2Nrcw==",
            "status": "ACTIVE",
            "id": 123456789
        ].formatted
        
        // When
        var jsonResponse: [String: Any]?
        call(request: request, description: "Get topic by id") { (response: [String: Any]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
    
    func testCreateTopic() {
        // Given
        let request = post(path: "/api/v1/topic")
        let expectedResponse = [
            "name": "string value",
            "icon": "U3dhZ2dlciByb2Nrcw==",
            "status": "ACTIVE",
            "id": 123456789
        ].formatted
        
        // When
        var jsonResponse: [String: Any]?
        call(request: request, description: "Create topic") { (response: [String: Any]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
    
    func testUpdateTopic() {
        // Given
        let request = put(path: "/api/v1/topic/123")
        let expectedResponse = [
            "name": "string value",
            "icon": "U3dhZ2dlciByb2Nrcw==",
            "status": "ACTIVE",
            "id": 123456789
        ].formatted
        
        // When
        var jsonResponse: [String: Any]?
        call(request: request, description: "Update topic") { (response: [String: Any]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
    
    func testDeleteTopic() {
        // Given
        let request = delete(path: "/api/v1/topic/123")
        
        // When
        var responseCode: Int?
        call(request: request, description: "Delete topic") { (_: [String: Any]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertEqual(responseCode, 200)
    }
    
    // MARK: Company tests
    
    func testGetAllCompanies() {
        // Given
        let request = get(path: "/api/v1/company")
        let expectedResponse = [
            [
                "contactDetails": "string value",
                "contact": [
                    "name": "string value",
                    "id": 123456789
                ],
                "name": "string value",
                "status": "ACTIVE",
                "id": 123456789
            ],
            [
                "name": "string value",
                "contactDetails": "string value",
                "id": 123456789,
                "contact": [
                    "name": "string value",
                    "id": 123456789
                ],
                "status": "ACTIVE"
            ],
            [
                "status": "ACTIVE",
                "id": 123456789,
                "contact": [
                    "name": "string value",
                    "id": 123456789
                ],
                "name": "string value",
                "contactDetails": "string value"
            ]
        ].map { $0.formatted }

        // When
        var jsonResponse: [[String: Any]]?
        call(request: request, description: "Get all companies") { (response: [[String: Any]]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [[:]] == expectedResponse)
    }
    
    func testGetCompanyById() {
        // Given
        let request = get(path: "/api/v1/company/123")
        let expectedResponse = [
            "contact": [
                "description": "string value",
                "id": 123456789,
                "profile": [
                    "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                    "ageGroup": "FIFTY_TO_FIFTY_NINE",
                    "id": 123456789,
                    "postCode": "string value",
                    "additionalHospitals": [
                        [
                            "id": 123456789,
                            "name": "string value"
                        ],
                        [
                            "id": 123456789,
                            "name": "string value"
                        ],
                        [
                            "id": 123456789,
                            "name": "string value"
                        ]
                    ],
                    "diseaseStatuses": [
                        "BRCA_PLUS",
                        "BRCA_PLUS",
                        "BRCA_PLUS"
                    ]
                ],
                "firstName": "string value",
                "glnNumber": "string value",
                "lastName": "string value",
                "phone": "string value",
                "userRole": "ADMIN",
                "registration": [
                    "id": 123456789,
                    "invitationCode": "string value",
                    "invitationLink": "string value"
                ],
                "settings": [
                    "showPostCode": true,
                    "pushNotifications": true,
                    "availability": "EVERY_TIME",
                    "id": 123456789,
                    "availabilityUntil": [
                        "second": 123,
                        "nano": 123,
                        "minute": 123,
                        "hour": 123
                    ],
                    "daysOfWeek": [
                        "FRIDAY",
                        "FRIDAY",
                        "FRIDAY"
                    ],
                    "availabilityFrom": [
                        "nano": 123,
                        "second": 123,
                        "minute": 123,
                        "hour": 123
                    ],
                    "viewType": "EVERY_BODY",
                    "language": "DE",
                    "revealFullName": true,
                    "showHospital": true
                ],
                "comment": "string value",
                "focusmeEntityId": 123456789,
                "avatar": "U3dhZ2dlciByb2Nrcw==",
                "topics": [
                    [
                        "status": "ACTIVE",
                        "id": 123456789,
                        "icon": "U3dhZ2dlciByb2Nrcw==",
                        "name": "string value"
                    ],
                    [
                        "status": "ACTIVE",
                        "id": 123456789,
                        "icon": "U3dhZ2dlciByb2Nrcw==",
                        "name": "string value"
                    ],
                    [
                        "status": "ACTIVE",
                        "id": 123456789,
                        "icon": "U3dhZ2dlciByb2Nrcw==",
                        "name": "string value"
                    ]
                ],
                "nickName": "string value",
                "email": "string value",
                "status": "ACTIVE",
                "termAndConditions": true
            ],
            "contactDetails": "string value",
            "id": 123456789,
            "name": "string value",
            "status": "ACTIVE"
        ].formatted
        
        // When
        var jsonResponse: [String: Any]?
        call(request: request, description: "Create company") { (response: [String: Any]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
    
    func testCreateCompany() {
        // Given
        let request = post(path: "/api/v1/company")
        let expectedResponse = [
            "contact": [
                "description": "string value",
                "id": 123456789,
                "profile": [
                    "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                    "ageGroup": "FIFTY_TO_FIFTY_NINE",
                    "id": 123456789,
                    "postCode": "string value",
                    "additionalHospitals": [
                        [
                            "id": 123456789,
                            "name": "string value"
                        ],
                        [
                            "id": 123456789,
                            "name": "string value"
                        ],
                        [
                            "id": 123456789,
                            "name": "string value"
                        ]
                    ],
                    "diseaseStatuses": [
                        "BRCA_PLUS",
                        "BRCA_PLUS",
                        "BRCA_PLUS"
                    ]
                ],
                "firstName": "string value",
                "glnNumber": "string value",
                "lastName": "string value",
                "phone": "string value",
                "userRole": "ADMIN",
                "registration": [
                    "id": 123456789,
                    "invitationCode": "string value",
                    "invitationLink": "string value"
                ],
                "settings": [
                    "showPostCode": true,
                    "pushNotifications": true,
                    "availability": "EVERY_TIME",
                    "id": 123456789,
                    "availabilityUntil": [
                        "second": 123,
                        "nano": 123,
                        "minute": 123,
                        "hour": 123
                    ],
                    "daysOfWeek": [
                        "FRIDAY",
                        "FRIDAY",
                        "FRIDAY"
                    ],
                    "availabilityFrom": [
                        "nano": 123,
                        "second": 123,
                        "minute": 123,
                        "hour": 123
                    ],
                    "viewType": "EVERY_BODY",
                    "language": "DE",
                    "revealFullName": true,
                    "showHospital": true
                ],
                "comment": "string value",
                "focusmeEntityId": 123456789,
                "avatar": "U3dhZ2dlciByb2Nrcw==",
                "topics": [
                    [
                        "status": "ACTIVE",
                        "id": 123456789,
                        "icon": "U3dhZ2dlciByb2Nrcw==",
                        "name": "string value"
                    ],
                    [
                        "status": "ACTIVE",
                        "id": 123456789,
                        "icon": "U3dhZ2dlciByb2Nrcw==",
                        "name": "string value"
                    ],
                    [
                        "status": "ACTIVE",
                        "id": 123456789,
                        "icon": "U3dhZ2dlciByb2Nrcw==",
                        "name": "string value"
                    ]
                ],
                "nickName": "string value",
                "email": "string value",
                "status": "ACTIVE",
                "termAndConditions": true
            ],
            "contactDetails": "string value",
            "id": 123456789,
            "name": "string value",
            "status": "ACTIVE"
        ].formatted

        // When
        var jsonResponse: [String: Any]?
        call(request: request, description: "Create company") { (response: [String: Any]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
    
    func testUpdateCompany() {
        // Given
        let request = put(path: "/api/v1/company/123")
        let expectedResponse =
            [
                "contact": [
                    "description": "string value",
                    "id": 123456789,
                    "profile": [
                        "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                        "ageGroup": "FIFTY_TO_FIFTY_NINE",
                        "id": 123456789,
                        "postCode": "string value",
                        "additionalHospitals": [
                            [
                                "id": 123456789,
                                "name": "string value"
                            ],
                            [
                                "id": 123456789,
                                "name": "string value"
                            ],
                            [
                                "id": 123456789,
                                "name": "string value"
                            ]
                        ],
                        "diseaseStatuses": [
                            "BRCA_PLUS",
                            "BRCA_PLUS",
                            "BRCA_PLUS"
                        ]
                    ],
                    "firstName": "string value",
                    "glnNumber": "string value",
                    "lastName": "string value",
                    "phone": "string value",
                    "userRole": "ADMIN",
                    "registration": [
                        "id": 123456789,
                        "invitationCode": "string value",
                        "invitationLink": "string value"
                    ],
                    "settings": [
                        "showPostCode": true,
                        "pushNotifications": true,
                        "availability": "EVERY_TIME",
                        "id": 123456789,
                        "availabilityUntil": [
                            "second": 123,
                            "nano": 123,
                            "minute": 123,
                            "hour": 123
                        ],
                        "daysOfWeek": [
                            "FRIDAY",
                            "FRIDAY",
                            "FRIDAY"
                        ],
                        "availabilityFrom": [
                            "nano": 123,
                            "second": 123,
                            "minute": 123,
                            "hour": 123
                        ],
                        "viewType": "EVERY_BODY",
                        "language": "DE",
                        "revealFullName": true,
                        "showHospital": true
                    ],
                    "comment": "string value",
                    "focusmeEntityId": 123456789,
                    "avatar": "U3dhZ2dlciByb2Nrcw==",
                    "topics": [
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "string value"
                        ],
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "string value"
                        ],
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "string value"
                        ]
                    ],
                    "nickName": "string value",
                    "email": "string value",
                    "status": "ACTIVE",
                    "termAndConditions": true
                ],
                "contactDetails": "string value",
                "id": 123456789,
                "name": "string value",
                "status": "ACTIVE"
            ].formatted
        
        // When
        var jsonResponse: [String: Any]?
        call(request: request, description: "Update company") { (response: [String: Any]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
    
    func testDeleteCompany() {
        // Given
        let request = delete(path: "/api/v1/company/123")
        
        // When
        var responseCode: Int?
        call(request: request, description: "Delete company") { (_: [String: Any]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertEqual(responseCode, 200)
    }

    // MARK: Hospital tests
    
    func testGetAllHospitals() {
        // Given
        let request = get(path: "/api/v1/hospital")
        let expectedResponse = [
            [
                "emailDomains": [
                    [
                        "domain": "string value",
                        "id": 123456789,
                        "description": "string value"
                    ],
                    [
                        "domain": "string value",
                        "id": 123456789,
                        "description": "string value"
                    ],
                    [
                        "domain": "string value",
                        "id": 123456789,
                        "description": "string value"
                    ]
                ],
                "contactDetails": "string value",
                "contact": [
                    "name": "string value",
                    "id": 123456789
                ],
                "name": "string value",
                "id": 123456789,
                "status": "ACTIVE"
            ],
            [
                "id": 123456789,
                "emailDomains": [
                    [
                        "domain": "string value",
                        "id": 123456789,
                        "description": "string value"
                    ],
                    [
                        "domain": "string value",
                        "id": 123456789,
                        "description": "string value"
                    ],
                    [
                        "domain": "string value",
                        "id": 123456789,
                        "description": "string value"
                    ]
                ],
                "name": "string value",
                "contact": [
                    "name": "string value",
                    "id": 123456789
                ],
                "status": "ACTIVE",
                "contactDetails": "string value"
            ],
            [
                "contactDetails": "string value",
                "contact": [
                    "name": "string value",
                    "id": 123456789
                ],
                "emailDomains": [
                    [
                        "domain": "string value",
                        "id": 123456789,
                        "description": "string value"
                    ],
                    [
                        "domain": "string value",
                        "id": 123456789,
                        "description": "string value"
                    ],
                    [
                        "domain": "string value",
                        "id": 123456789,
                        "description": "string value"
                    ]
                ],
                "status": "ACTIVE",
                "id": 123456789,
                "name": "string value"
            ]
        ].map { $0.formatted }
        
        // When
        var jsonResponse: [[String: Any]]?
        call(request: request, description: "Get all hospitals") { (response: [[String: Any]]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [[:]] == expectedResponse)
    }
    
    func testGetHospitalById() {
        // Given
        let request = get(path: "/api/v1/hospital/123")
        let expectedResponse =
            [
                "contact": [
                    "id": 123456789,
                    "registration": [
                        "id": 123456789,
                        "invitationCode": "string value",
                        "invitationLink": "string value"
                    ],
                    "profile": [
                        "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                        "additionalHospitals": [
                            [
                                "name": "string value",
                                "id": 123456789
                            ],
                            [
                                "name": "string value",
                                "id": 123456789
                            ],
                            [
                                "name": "string value",
                                "id": 123456789
                            ]
                        ],
                        "ageGroup": "FIFTY_TO_FIFTY_NINE",
                        "id": 123456789,
                        "postCode": "string value",
                        "diseaseStatuses": [
                            "BRCA_PLUS",
                            "BRCA_PLUS",
                            "BRCA_PLUS"
                        ]
                    ],
                    "firstName": "string value",
                    "glnNumber": "string value",
                    "phone": "string value",
                    "description": "string value",
                    "userRole": "ADMIN",
                    "lastName": "string value",
                    "settings": [
                        "showPostCode": true,
                        "availabilityUntil": [
                            "nano": 123,
                            "hour": 123,
                            "minute": 123,
                            "second": 123
                        ],
                        "id": 123456789,
                        "revealFullName": true,
                        "showHospital": true,
                        "availabilityFrom": [
                            "nano": 123,
                            "hour": 123,
                            "minute": 123,
                            "second": 123
                        ],
                        "daysOfWeek": [
                            "FRIDAY",
                            "FRIDAY",
                            "FRIDAY"
                        ],
                        "language": "DE",
                        "pushNotifications": true,
                        "viewType": "EVERY_BODY",
                        "availability": "EVERY_TIME"
                    ],
                    "comment": "string value",
                    "focusmeEntityId": 123456789,
                    "avatar": "U3dhZ2dlciByb2Nrcw==",
                    "topics": [
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "string value"
                        ],
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "string value"
                        ],
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "string value"
                        ]
                    ],
                    "nickName": "string value",
                    "email": "string value",
                    "status": "ACTIVE",
                    "termAndConditions": true
                ],
                "contactDetails": "string value",
                "id": 123456789,
                "name": "string value",
                "emailDomains": [
                    [
                        "id": 123456789,
                        "domain": "string value",
                        "description": "string value"
                    ],
                    [
                        "id": 123456789,
                        "domain": "string value",
                        "description": "string value"
                    ],
                    [
                        "id": 123456789,
                        "domain": "string value",
                        "description": "string value"
                    ]
                ],
                "status": "ACTIVE"
            ].formatted
        
        // When
        var jsonResponse: [String: Any]?
        call(request: request, description: "Get hospital by id") { (response: [String: Any]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
    
    func testUpdateHospital() {
        // Given
        let request = put(path: "/api/v1/hospital/123")
        let expectedResponse =
            [
                "contact": [
                    "id": 123456789,
                    "registration": [
                        "id": 123456789,
                        "invitationCode": "string value",
                        "invitationLink": "string value"
                    ],
                    "profile": [
                        "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                        "additionalHospitals": [
                            [
                                "name": "string value",
                                "id": 123456789
                            ],
                            [
                                "name": "string value",
                                "id": 123456789
                            ],
                            [
                                "name": "string value",
                                "id": 123456789
                            ]
                        ],
                        "ageGroup": "FIFTY_TO_FIFTY_NINE",
                        "id": 123456789,
                        "postCode": "string value",
                        "diseaseStatuses": [
                            "BRCA_PLUS",
                            "BRCA_PLUS",
                            "BRCA_PLUS"
                        ]
                    ],
                    "firstName": "string value",
                    "glnNumber": "string value",
                    "phone": "string value",
                    "description": "string value",
                    "userRole": "ADMIN",
                    "lastName": "string value",
                    "settings": [
                        "showPostCode": true,
                        "availabilityUntil": [
                            "nano": 123,
                            "hour": 123,
                            "minute": 123,
                            "second": 123
                        ],
                        "id": 123456789,
                        "revealFullName": true,
                        "showHospital": true,
                        "availabilityFrom": [
                            "nano": 123,
                            "hour": 123,
                            "minute": 123,
                            "second": 123
                        ],
                        "daysOfWeek": [
                            "FRIDAY",
                            "FRIDAY",
                            "FRIDAY"
                        ],
                        "language": "DE",
                        "pushNotifications": true,
                        "viewType": "EVERY_BODY",
                        "availability": "EVERY_TIME"
                    ],
                    "comment": "string value",
                    "focusmeEntityId": 123456789,
                    "avatar": "U3dhZ2dlciByb2Nrcw==",
                    "topics": [
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "string value"
                        ],
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "string value"
                        ],
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "string value"
                        ]
                    ],
                    "nickName": "string value",
                    "email": "string value",
                    "status": "ACTIVE",
                    "termAndConditions": true
                ],
                "contactDetails": "string value",
                "id": 123456789,
                "name": "string value",
                "emailDomains": [
                    [
                        "id": 123456789,
                        "domain": "string value",
                        "description": "string value"
                    ],
                    [
                        "id": 123456789,
                        "domain": "string value",
                        "description": "string value"
                    ],
                    [
                        "id": 123456789,
                        "domain": "string value",
                        "description": "string value"
                    ]
                ],
                "status": "ACTIVE"
            ].formatted
        
        // When
        var jsonResponse: [String: Any]?
        call(request: request, description: "Update hospital") { (response: [String: Any]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
    
    func testCreateHospital() {
        // Given
        let request = post(path: "/api/v1/hospital")
        let expectedResponse =
            [
                "contact": [
                    "id": 123456789,
                    "registration": [
                        "id": 123456789,
                        "invitationCode": "string value",
                        "invitationLink": "string value"
                    ],
                    "profile": [
                        "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                        "additionalHospitals": [
                            [
                                "name": "string value",
                                "id": 123456789
                            ],
                            [
                                "name": "string value",
                                "id": 123456789
                            ],
                            [
                                "name": "string value",
                                "id": 123456789
                            ]
                        ],
                        "ageGroup": "FIFTY_TO_FIFTY_NINE",
                        "id": 123456789,
                        "postCode": "string value",
                        "diseaseStatuses": [
                            "BRCA_PLUS",
                            "BRCA_PLUS",
                            "BRCA_PLUS"
                        ]
                    ],
                    "firstName": "string value",
                    "glnNumber": "string value",
                    "phone": "string value",
                    "description": "string value",
                    "userRole": "ADMIN",
                    "lastName": "string value",
                    "settings": [
                        "showPostCode": true,
                        "availabilityUntil": [
                            "nano": 123,
                            "hour": 123,
                            "minute": 123,
                            "second": 123
                        ],
                        "id": 123456789,
                        "revealFullName": true,
                        "showHospital": true,
                        "availabilityFrom": [
                            "nano": 123,
                            "hour": 123,
                            "minute": 123,
                            "second": 123
                        ],
                        "daysOfWeek": [
                            "FRIDAY",
                            "FRIDAY",
                            "FRIDAY"
                        ],
                        "language": "DE",
                        "pushNotifications": true,
                        "viewType": "EVERY_BODY",
                        "availability": "EVERY_TIME"
                    ],
                    "comment": "string value",
                    "focusmeEntityId": 123456789,
                    "avatar": "U3dhZ2dlciByb2Nrcw==",
                    "topics": [
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "string value"
                        ],
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "string value"
                        ],
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "string value"
                        ]
                    ],
                    "nickName": "string value",
                    "email": "string value",
                    "status": "ACTIVE",
                    "termAndConditions": true
                ],
                "contactDetails": "string value",
                "id": 123456789,
                "name": "string value",
                "emailDomains": [
                    [
                        "id": 123456789,
                        "domain": "string value",
                        "description": "string value"
                    ],
                    [
                        "id": 123456789,
                        "domain": "string value",
                        "description": "string value"
                    ],
                    [
                        "id": 123456789,
                        "domain": "string value",
                        "description": "string value"
                    ]
                ],
                "status": "ACTIVE"
            ].formatted
        
        // When
        var jsonResponse: [String: Any]?
        call(request: request, description: "Create hospital") { (response: [String: Any]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
    
    func testDeleteHospital() {
        // Given
        let request = delete(path: "/api/v1/hospital/123")
        
        // When
        var responseCode: Int?
        call(request: request, description: "Delete hospital") { (_: [String: Any]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertEqual(responseCode, 200)
    }
    
    // MARK: UserSettings tests
    
    func testUpdateUserSettings() {
        // Given
        let request = put(path: "/api/v1/user/settings/123")
        let expectedResponse =
            [
                "id": 123456789,
                "viewType": "EVERY_BODY",
                "pushNotifications": true,
                "availabilityFrom": [
                    "nano": 123,
                    "hour": 123,
                    "minute": 123,
                    "second": 123
                ],
                "language": "DE",
                "showPostCode": true,
                "availability": "EVERY_TIME",
                "revealFullName": true,
                "availabilityUntil": [
                    "nano": 123,
                    "second": 123,
                    "minute": 123,
                    "hour": 123
                ],
                "daysOfWeek": [
                    "FRIDAY",
                    "FRIDAY",
                    "FRIDAY"
                ],
                "showHospital": true
            ].formatted

        // When
        var jsonResponse: [String: Any]?
        call(request: request, description: "Update user settings") { (response: [String: Any]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
}

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
