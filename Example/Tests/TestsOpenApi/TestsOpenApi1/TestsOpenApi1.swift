import SwaggerAutomocker
import XCTest

final class TestsOpenApi1: Tests {
    override class var jsonFileName: String {
        return "openapi1"
    }
    
    // MARK: User tests

    func testRegistration() {
        // Given
        let request = post(path: "/api/v1/registration/user")
        let expectedResponse = [
            "focusmeEntityId": 123456789,
            "registration": [
                "id": 123456789,
                "invitationCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "invitationLink": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            ],
            "termAndConditions": true,
            "id": 123456789,
            "nickName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "lastName": "Adams",
            "phone": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "email": "firstname@domain.com",
            "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "status": "ACTIVE",
            "avatar": "U3dhZ2dlciByb2Nrcw==",
            "glnNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "userRole": "ADMIN",
            "firstName": "Ida",
            "settings": [
                "showPostCode": true,
                "availabilityUntil": [
                    "nano": 123,
                    "second": 123,
                    "minute": 123,
                    "hour": 123
                ],
                "id": 123456789,
                "pushNotifications": true,
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
                "language": "DE",
                "revealFullName": true,
                "availability": "EVERY_TIME"
            ],
            "topics": [
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "Ida Adams"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "Ida Adams"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "Ida Adams"
                ]
            ],
            "profile": [
                "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                "id": 123456789,
                "ageGroup": "FIFTY_TO_FIFTY_NINE",
                "postCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "additionalHospitals": [
                    [
                        "name": "Ida Adams",
                        "id": 123456789
                    ],
                    [
                        "name": "Ida Adams",
                        "id": 123456789
                    ],
                    [
                        "name": "Ida Adams",
                        "id": 123456789
                    ]
                ],
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
            "status": "ACTIVE",
            "glnNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "profile": [
                "ageGroup": "FIFTY_TO_FIFTY_NINE",
                "id": 123456789,
                "additionalHospitals": [
                    [
                        "id": 123456789,
                        "name": "Ida Adams"
                    ],
                    [
                        "id": 123456789,
                        "name": "Ida Adams"
                    ],
                    [
                        "id": 123456789,
                        "name": "Ida Adams"
                    ]
                ],
                "postCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                "diseaseStatuses": [
                    "BRCA_PLUS",
                    "BRCA_PLUS",
                    "BRCA_PLUS"
                ]
            ],
            "lastName": "Adams",
            "firstName": "Ida",
            "registration": [
                "id": 123456789,
                "invitationCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "invitationLink": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            ],
            "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "focusmeEntityId": 123456789,
            "topics": [
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "Ida Adams"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "Ida Adams"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "Ida Adams"
                ]
            ],
            "phone": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "settings": [
                "availability": "EVERY_TIME",
                "id": 123456789,
                "revealFullName": true,
                "showPostCode": true,
                "pushNotifications": true,
                "availabilityFrom": [
                    "nano": 123,
                    "hour": 123,
                    "minute": 123,
                    "second": 123
                ],
                "language": "DE",
                "daysOfWeek": [
                    "FRIDAY",
                    "FRIDAY",
                    "FRIDAY"
                ],
                "availabilityUntil": [
                    "hour": 123,
                    "nano": 123,
                    "minute": 123,
                    "second": 123
                ],
                "showHospital": true,
                "viewType": "EVERY_BODY"
            ],
            "id": 123456789,
            "userRole": "ADMIN",
            "termAndConditions": true,
            "email": "firstname@domain.com",
            "nickName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "avatar": "U3dhZ2dlciByb2Nrcw==",
            "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
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
            "status": "ACTIVE",
            "registration": [
                "id": 123456789,
                "invitationCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "invitationLink": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            ],
            "profile": [
                "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                "additionalHospitals": [
                    [
                        "id": 123456789,
                        "name": "Ida Adams"
                    ],
                    [
                        "id": 123456789,
                        "name": "Ida Adams"
                    ],
                    [
                        "id": 123456789,
                        "name": "Ida Adams"
                    ]
                ],
                "id": 123456789,
                "ageGroup": "FIFTY_TO_FIFTY_NINE",
                "postCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "diseaseStatuses": [
                    "BRCA_PLUS",
                    "BRCA_PLUS",
                    "BRCA_PLUS"
                ]
            ],
            "email": "firstname@domain.com",
            "nickName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "topics": [
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "Ida Adams"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "Ida Adams"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "Ida Adams"
                ]
            ],
            "id": 123456789,
            "userRole": "ADMIN",
            "glnNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "firstName": "Ida",
            "lastName": "Adams",
            "termAndConditions": true,
            "avatar": "U3dhZ2dlciByb2Nrcw==",
            "focusmeEntityId": 123456789,
            "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "phone": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "settings": [
                "showPostCode": true,
                "id": 123456789,
                "revealFullName": true,
                "availabilityUntil": [
                    "second": 123,
                    "nano": 123,
                    "minute": 123,
                    "hour": 123
                ],
                "showHospital": true,
                "language": "DE",
                "daysOfWeek": [
                    "FRIDAY",
                    "FRIDAY",
                    "FRIDAY"
                ],
                "viewType": "EVERY_BODY",
                "availability": "EVERY_TIME",
                "availabilityFrom": [
                    "nano": 123,
                    "second": 123,
                    "minute": 123,
                    "hour": 123
                ],
                "pushNotifications": true
            ],
            "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
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
            "firstName": "Ida",
            "settings": [
                "showPostCode": true,
                "id": 123456789,
                "revealFullName": true,
                "availability": "EVERY_TIME",
                "showHospital": true,
                "language": "DE",
                "availabilityFrom": [
                    "hour": 123,
                    "nano": 123,
                    "minute": 123,
                    "second": 123
                ],
                "daysOfWeek": [
                    "FRIDAY",
                    "FRIDAY",
                    "FRIDAY"
                ],
                "viewType": "EVERY_BODY",
                "pushNotifications": true,
                "availabilityUntil": [
                    "second": 123,
                    "nano": 123,
                    "minute": 123,
                    "hour": 123
                ]
            ],
            "profile": [
                "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                "additionalHospitals": [
                    [
                        "name": "Ida Adams",
                        "id": 123456789
                    ],
                    [
                        "name": "Ida Adams",
                        "id": 123456789
                    ],
                    [
                        "name": "Ida Adams",
                        "id": 123456789
                    ]
                ],
                "ageGroup": "FIFTY_TO_FIFTY_NINE",
                "postCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "id": 123456789,
                "diseaseStatuses": [
                    "BRCA_PLUS",
                    "BRCA_PLUS",
                    "BRCA_PLUS"
                ]
            ],
            "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "topics": [
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "Ida Adams"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "Ida Adams"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "Ida Adams"
                ]
            ],
            "focusmeEntityId": 123456789,
            "lastName": "Adams",
            "avatar": "U3dhZ2dlciByb2Nrcw==",
            "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "email": "firstname@domain.com",
            "status": "ACTIVE",
            "nickName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "glnNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "phone": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "registration": [
                "id": 123456789,
                "invitationCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "invitationLink": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            ],
            "id": 123456789,
            "termAndConditions": true,
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
                "postCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "additionalHospitals": [
                    [
                        "id": 123456789,
                        "name": "Ida Adams"
                    ],
                    [
                        "id": 123456789,
                        "name": "Ida Adams"
                    ],
                    [
                        "id": 123456789,
                        "name": "Ida Adams"
                    ]
                ],
                "diseaseStatuses": [
                    "BRCA_PLUS",
                    "BRCA_PLUS",
                    "BRCA_PLUS"
                ]
            ],
            "email": "firstname@domain.com",
            "registration": [
                "id": 123456789,
                "invitationCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "invitationLink": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            ],
            "nickName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "avatar": "U3dhZ2dlciByb2Nrcw==",
            "status": "ACTIVE",
            "glnNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "topics": [
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "Ida Adams"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "Ida Adams"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "Ida Adams"
                ]
            ],
            "termAndConditions": true,
            "phone": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "lastName": "Adams",
            "id": 123456789,
            "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
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
            "firstName": "Ida"
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
                "postCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "additionalHospitals": [
                    [
                        "id": 123456789,
                        "name": "Ida Adams"
                    ],
                    [
                        "id": 123456789,
                        "name": "Ida Adams"
                    ],
                    [
                        "id": 123456789,
                        "name": "Ida Adams"
                    ]
                ],
                "diseaseStatuses": [
                    "BRCA_PLUS",
                    "BRCA_PLUS",
                    "BRCA_PLUS"
                ]
            ],
            "email": "firstname@domain.com",
            "registration": [
                "id": 123456789,
                "invitationCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "invitationLink": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            ],
            "nickName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "avatar": "U3dhZ2dlciByb2Nrcw==",
            "status": "ACTIVE",
            "glnNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "topics": [
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "Ida Adams"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "Ida Adams"
                ],
                [
                    "status": "ACTIVE",
                    "id": 123456789,
                    "icon": "U3dhZ2dlciByb2Nrcw==",
                    "name": "Ida Adams"
                ]
            ],
            "termAndConditions": true,
            "phone": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "lastName": "Adams",
            "id": 123456789,
            "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
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
            "firstName": "Ida"
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
                "focusmeEntity": [
                    "name": "Luu Nguyen A",
                    "id": 3694734
                ],
                "userRole": "PATIENT",
                "avatar": "U3dhZ2dlciByb2Nrcw==",
                "lastName": "Truong Luu A",
                "firstName": "Nguyen",
                "email": "luunguyenA@novahub.vn",
                "nickName": "Luu Nguyen A",
                "status": "ACTIVE",
                "id": 98349702
            ],
            [
                "firstName": "Nguyen",
                "avatar": "U3dhZ2dlciByb2Nrcw==",
                "nickName": "Luu Nguyen B",
                "status": "ACTIVE",
                "userRole": "PATIENT",
                "lastName": "Truong Luu B",
                "id": 98349702,
                "email": "luunguyenB@novahub.vn",
                "focusmeEntity": [
                    "name": "Luu Nguyen B",
                    "id": 3694734
                ]
            ],
            [
                "nickName": "Luu Nguyen C",
                "avatar": "U3dhZ2dlciByb2Nrcw==",
                "status": "ACTIVE",
                "focusmeEntity": [
                    "name": "Luu Nguyen C",
                    "id": 3694734
                ],
                "lastName": "Truong Luu C",
                "firstName": "Nguyen",
                "email": "luunguyenC@novahub.vn",
                "id": 98349702,
                "userRole": "PATIENT"
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
                    "postCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "additionalHospitals": [
                        [
                            "id": 123456789,
                            "name": "Ida Adams"
                        ],
                        [
                            "id": 123456789,
                            "name": "Ida Adams"
                        ],
                        [
                            "id": 123456789,
                            "name": "Ida Adams"
                        ]
                    ],
                    "diseaseStatuses": [
                        "BRCA_PLUS",
                        "BRCA_PLUS",
                        "BRCA_PLUS"
                    ]
                ],
                "email": "firstname@domain.com",
                "registration": [
                    "id": 123456789,
                    "invitationCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "invitationLink": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                ],
                "nickName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "avatar": "U3dhZ2dlciByb2Nrcw==",
                "status": "ACTIVE",
                "glnNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "topics": [
                    [
                        "status": "ACTIVE",
                        "id": 123456789,
                        "icon": "U3dhZ2dlciByb2Nrcw==",
                        "name": "Ida Adams"
                    ],
                    [
                        "status": "ACTIVE",
                        "id": 123456789,
                        "icon": "U3dhZ2dlciByb2Nrcw==",
                        "name": "Ida Adams"
                    ],
                    [
                        "status": "ACTIVE",
                        "id": 123456789,
                        "icon": "U3dhZ2dlciByb2Nrcw==",
                        "name": "Ida Adams"
                    ]
                ],
                "termAndConditions": true,
                "phone": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "lastName": "Adams",
                "id": 123456789,
                "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
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
                "firstName": "Ida"
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
                "name": "Ida Adams",
                "icon": "U3dhZ2dlciByb2Nrcw==",
                "status": "ACTIVE",
                "id": 123456789
            ],
            [
                "icon": "U3dhZ2dlciByb2Nrcw==",
                "id": 123456789,
                "name": "Ida Adams",
                "status": "ACTIVE"
            ],
            [
                "name": "Ida Adams",
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
            "name": "Ida Adams",
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
            "name": "Ida Adams",
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
            "name": "Ida Adams",
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
                "contactDetails": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "contact": [
                    "name": "Ida Adams",
                    "id": 123456789
                ],
                "name": "Ida Adams",
                "status": "ACTIVE",
                "id": 123456789
            ],
            [
                "name": "Ida Adams",
                "contactDetails": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "id": 123456789,
                "contact": [
                    "name": "Ida Adams",
                    "id": 123456789
                ],
                "status": "ACTIVE"
            ],
            [
                "status": "ACTIVE",
                "id": 123456789,
                "contact": [
                    "name": "Ida Adams",
                    "id": 123456789
                ],
                "name": "Ida Adams",
                "contactDetails": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
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
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "id": 123456789,
                "profile": [
                    "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                    "ageGroup": "FIFTY_TO_FIFTY_NINE",
                    "id": 123456789,
                    "postCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "additionalHospitals": [
                        [
                            "id": 123456789,
                            "name": "Ida Adams"
                        ],
                        [
                            "id": 123456789,
                            "name": "Ida Adams"
                        ],
                        [
                            "id": 123456789,
                            "name": "Ida Adams"
                        ]
                    ],
                    "diseaseStatuses": [
                        "BRCA_PLUS",
                        "BRCA_PLUS",
                        "BRCA_PLUS"
                    ]
                ],
                "firstName": "Ida",
                "glnNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "lastName": "Adams",
                "phone": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "userRole": "ADMIN",
                "registration": [
                    "id": 123456789,
                    "invitationCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "invitationLink": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
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
                "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "focusmeEntityId": 123456789,
                "avatar": "U3dhZ2dlciByb2Nrcw==",
                "topics": [
                    [
                        "status": "ACTIVE",
                        "id": 123456789,
                        "icon": "U3dhZ2dlciByb2Nrcw==",
                        "name": "Ida Adams"
                    ],
                    [
                        "status": "ACTIVE",
                        "id": 123456789,
                        "icon": "U3dhZ2dlciByb2Nrcw==",
                        "name": "Ida Adams"
                    ],
                    [
                        "status": "ACTIVE",
                        "id": 123456789,
                        "icon": "U3dhZ2dlciByb2Nrcw==",
                        "name": "Ida Adams"
                    ]
                ],
                "nickName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "email": "firstname@domain.com",
                "status": "ACTIVE",
                "termAndConditions": true
            ],
            "contactDetails": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "id": 123456789,
            "name": "Ida Adams",
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
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "id": 123456789,
                "profile": [
                    "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                    "ageGroup": "FIFTY_TO_FIFTY_NINE",
                    "id": 123456789,
                    "postCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "additionalHospitals": [
                        [
                            "id": 123456789,
                            "name": "Ida Adams"
                        ],
                        [
                            "id": 123456789,
                            "name": "Ida Adams"
                        ],
                        [
                            "id": 123456789,
                            "name": "Ida Adams"
                        ]
                    ],
                    "diseaseStatuses": [
                        "BRCA_PLUS",
                        "BRCA_PLUS",
                        "BRCA_PLUS"
                    ]
                ],
                "firstName": "Ida",
                "glnNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "lastName": "Adams",
                "phone": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "userRole": "ADMIN",
                "registration": [
                    "id": 123456789,
                    "invitationCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "invitationLink": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
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
                "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "focusmeEntityId": 123456789,
                "avatar": "U3dhZ2dlciByb2Nrcw==",
                "topics": [
                    [
                        "status": "ACTIVE",
                        "id": 123456789,
                        "icon": "U3dhZ2dlciByb2Nrcw==",
                        "name": "Ida Adams"
                    ],
                    [
                        "status": "ACTIVE",
                        "id": 123456789,
                        "icon": "U3dhZ2dlciByb2Nrcw==",
                        "name": "Ida Adams"
                    ],
                    [
                        "status": "ACTIVE",
                        "id": 123456789,
                        "icon": "U3dhZ2dlciByb2Nrcw==",
                        "name": "Ida Adams"
                    ]
                ],
                "nickName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "email": "firstname@domain.com",
                "status": "ACTIVE",
                "termAndConditions": true
            ],
            "contactDetails": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "id": 123456789,
            "name": "Ida Adams",
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
                    "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "id": 123456789,
                    "profile": [
                        "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                        "ageGroup": "FIFTY_TO_FIFTY_NINE",
                        "id": 123456789,
                        "postCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "additionalHospitals": [
                            [
                                "id": 123456789,
                                "name": "Ida Adams"
                            ],
                            [
                                "id": 123456789,
                                "name": "Ida Adams"
                            ],
                            [
                                "id": 123456789,
                                "name": "Ida Adams"
                            ]
                        ],
                        "diseaseStatuses": [
                            "BRCA_PLUS",
                            "BRCA_PLUS",
                            "BRCA_PLUS"
                        ]
                    ],
                    "firstName": "Ida",
                    "glnNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "lastName": "Adams",
                    "phone": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "userRole": "ADMIN",
                    "registration": [
                        "id": 123456789,
                        "invitationCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "invitationLink": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
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
                    "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "focusmeEntityId": 123456789,
                    "avatar": "U3dhZ2dlciByb2Nrcw==",
                    "topics": [
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "Ida Adams"
                        ],
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "Ida Adams"
                        ],
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "Ida Adams"
                        ]
                    ],
                    "nickName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "email": "firstname@domain.com",
                    "status": "ACTIVE",
                    "termAndConditions": true
                ],
                "contactDetails": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "id": 123456789,
                "name": "Ida Adams",
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
                        "domain": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "id": 123456789,
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    [
                        "domain": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "id": 123456789,
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    [
                        "domain": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "id": 123456789,
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ]
                ],
                "contactDetails": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "contact": [
                    "name": "Ida Adams",
                    "id": 123456789
                ],
                "name": "Ida Adams",
                "id": 123456789,
                "status": "ACTIVE"
            ],
            [
                "id": 123456789,
                "emailDomains": [
                    [
                        "domain": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "id": 123456789,
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    [
                        "domain": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "id": 123456789,
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    [
                        "domain": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "id": 123456789,
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ]
                ],
                "name": "Ida Adams",
                "contact": [
                    "name": "Ida Adams",
                    "id": 123456789
                ],
                "status": "ACTIVE",
                "contactDetails": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            ],
            [
                "contactDetails": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "contact": [
                    "name": "Ida Adams",
                    "id": 123456789
                ],
                "emailDomains": [
                    [
                        "domain": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "id": 123456789,
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    [
                        "domain": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "id": 123456789,
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    [
                        "domain": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "id": 123456789,
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ]
                ],
                "status": "ACTIVE",
                "id": 123456789,
                "name": "Ida Adams"
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
                        "invitationCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "invitationLink": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    "profile": [
                        "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                        "additionalHospitals": [
                            [
                                "name": "Ida Adams",
                                "id": 123456789
                            ],
                            [
                                "name": "Ida Adams",
                                "id": 123456789
                            ],
                            [
                                "name": "Ida Adams",
                                "id": 123456789
                            ]
                        ],
                        "ageGroup": "FIFTY_TO_FIFTY_NINE",
                        "id": 123456789,
                        "postCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "diseaseStatuses": [
                            "BRCA_PLUS",
                            "BRCA_PLUS",
                            "BRCA_PLUS"
                        ]
                    ],
                    "firstName": "Ida",
                    "glnNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "phone": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "userRole": "ADMIN",
                    "lastName": "Adams",
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
                    "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "focusmeEntityId": 123456789,
                    "avatar": "U3dhZ2dlciByb2Nrcw==",
                    "topics": [
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "Ida Adams"
                        ],
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "Ida Adams"
                        ],
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "Ida Adams"
                        ]
                    ],
                    "nickName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "email": "firstname@domain.com",
                    "status": "ACTIVE",
                    "termAndConditions": true
                ],
                "contactDetails": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "id": 123456789,
                "name": "Ida Adams",
                "emailDomains": [
                    [
                        "id": 123456789,
                        "domain": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    [
                        "id": 123456789,
                        "domain": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    [
                        "id": 123456789,
                        "domain": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
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
                        "invitationCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "invitationLink": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    "profile": [
                        "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                        "additionalHospitals": [
                            [
                                "name": "Ida Adams",
                                "id": 123456789
                            ],
                            [
                                "name": "Ida Adams",
                                "id": 123456789
                            ],
                            [
                                "name": "Ida Adams",
                                "id": 123456789
                            ]
                        ],
                        "ageGroup": "FIFTY_TO_FIFTY_NINE",
                        "id": 123456789,
                        "postCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "diseaseStatuses": [
                            "BRCA_PLUS",
                            "BRCA_PLUS",
                            "BRCA_PLUS"
                        ]
                    ],
                    "firstName": "Ida",
                    "glnNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "phone": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "userRole": "ADMIN",
                    "lastName": "Adams",
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
                    "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "focusmeEntityId": 123456789,
                    "avatar": "U3dhZ2dlciByb2Nrcw==",
                    "topics": [
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "Ida Adams"
                        ],
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "Ida Adams"
                        ],
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "Ida Adams"
                        ]
                    ],
                    "nickName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "email": "firstname@domain.com",
                    "status": "ACTIVE",
                    "termAndConditions": true
                ],
                "contactDetails": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "id": 123456789,
                "name": "Ida Adams",
                "emailDomains": [
                    [
                        "id": 123456789,
                        "domain": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    [
                        "id": 123456789,
                        "domain": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    [
                        "id": 123456789,
                        "domain": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
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
                        "invitationCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "invitationLink": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    "profile": [
                        "maritalStatus": "DESIRE_TO_HAVE_CHILDREN",
                        "additionalHospitals": [
                            [
                                "name": "Ida Adams",
                                "id": 123456789
                            ],
                            [
                                "name": "Ida Adams",
                                "id": 123456789
                            ],
                            [
                                "name": "Ida Adams",
                                "id": 123456789
                            ]
                        ],
                        "ageGroup": "FIFTY_TO_FIFTY_NINE",
                        "id": 123456789,
                        "postCode": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "diseaseStatuses": [
                            "BRCA_PLUS",
                            "BRCA_PLUS",
                            "BRCA_PLUS"
                        ]
                    ],
                    "firstName": "Ida",
                    "glnNumber": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "phone": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "userRole": "ADMIN",
                    "lastName": "Adams",
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
                    "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "focusmeEntityId": 123456789,
                    "avatar": "U3dhZ2dlciByb2Nrcw==",
                    "topics": [
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "Ida Adams"
                        ],
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "Ida Adams"
                        ],
                        [
                            "status": "ACTIVE",
                            "id": 123456789,
                            "icon": "U3dhZ2dlciByb2Nrcw==",
                            "name": "Ida Adams"
                        ]
                    ],
                    "nickName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    "email": "firstname@domain.com",
                    "status": "ACTIVE",
                    "termAndConditions": true
                ],
                "contactDetails": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "id": 123456789,
                "name": "Ida Adams",
                "emailDomains": [
                    [
                        "id": 123456789,
                        "domain": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    [
                        "id": 123456789,
                        "domain": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ],
                    [
                        "id": 123456789,
                        "domain": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
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
