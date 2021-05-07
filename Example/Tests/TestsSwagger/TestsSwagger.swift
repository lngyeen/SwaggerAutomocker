import SwaggerAutomocker
import XCTest

final class TestsSwagger: Tests {
    override class var jsonFileName: String {
        return "swagger"
    }
    
    // MARK: Inventory tests
    
    func testGetInventory() {
        // Given
        let request = get(path: "/v2/store/inventory")
        let expectedResponse = [
            "id": 123456789,
            "name": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        ].formatted
        
        // When
        var responseJson: [String: Any]?
        call(request: request, description: "Loading Inventory") { (response: [String: Any]?, _, _, _) in
            responseJson = response
        }
    
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [:] == expectedResponse)
    }
    
    func testPostOrder() {
        // Given
        let request = post(path: "/v2/store/order")
        
        // When
        var responseCode: Int?
        call(request: request, description: "Posting Order") { (_: [String: Any]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertEqual(responseCode, 200)
    }
    
    func testGetOrder() {
        // Given
        let request = get(path: "/v2/store/order/123")
        let expectedResponse = [
            "petId": 123456789,
            "quantity": 123,
            "status": "placed",
            "shipDate": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "id": 123456789,
            "complete": true
        ].formatted
        
        // When
        var responseJson: [String: Any]?
        call(request: request, description: "Loading Order") { (response: [String: Any]?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [:] == expectedResponse)
    }
    
    func testDeleteOrder() {
        // Given
        let request = delete(path: "/v2/store/order/123")
        
        // When
        var responseCode: Int?
        call(request: request, description: "Deleting Order") { (_: [String: Any]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertEqual(responseCode, 204)
    }
    
    // MARK: - Pet Tests
    
    func testGetPetById() {
        // Given
        let request = get(path: "/v2/pet/123")
        let expectedResponse = [
            "id": 123456789,
            "category": [
                "id": 123456789,
                "name": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            ],
            "name": "doggie",
            "photoUrls": [
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            ],
            "tags": [
                [
                    "id": 123456789,
                    "name": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                ],
                [
                    "id": 123456789,
                    "name": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                ],
                [
                    "id": 123456789,
                    "name": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                ]
            ],
            "status": "available"
        ].formatted
        
        // When
        var responseJson: [String: Any]?
        call(request: request, description: "Loading Pet") { (response: [String: Any]?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [:] == expectedResponse)
    }
    
    func testFindPet() {
        // Given
        let request = get(path: "/v2/pet/findByStatus")
        let expectedResponse = [
            ["id": 123456789,
             "category": ["id": 123456789, "name": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."],
             "name": "doggie",
             "photoUrls": ["Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit."],
             "tags": [
                 ["id": 123456789, "name": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."],
                 ["id": 123456789, "name": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."],
                 ["id": 123456789, "name": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."]
             ],
             "status": "available"],
            ["id": 123456789,
             "category": ["id": 123456789, "name": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."],
             "name": "doggie",
             "photoUrls": ["Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit."],
             "tags": [
                 ["id": 123456789, "name": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."],
                 ["id": 123456789, "name": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."],
                 ["id": 123456789, "name": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."]
             ],
             "status": "available"],
            ["id": 123456789,
             "category": ["id": 123456789, "name": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."],
             "name": "doggie",
             "photoUrls": ["Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit."],
             "tags": [
                 ["id": 123456789, "name": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."],
                 ["id": 123456789, "name": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."],
                 ["id": 123456789, "name": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."]
             ],
             "status": "available"]
        ].map { $0.formatted }
        
        // When
        var responseJson: [[String: Any]]?
        call(request: request, description: "Finding Pet") { (response: [[String: Any]]?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [] == expectedResponse)
    }
    
    func testPostPet() {
        // Given
        let request = post(path: "/v2/pet")
        
        // When
        var responseCode: Int?
        call(request: request, description: "Posting Pet") { (_: [String: Any]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertEqual(responseCode, 204)
    }
    
    func testPostPet2() {
        // Given
        let request = post(path: "/v2/pet/123")
        
        // When
        var responseCode: Int?
        call(request: request, description: "Posting Pet 2") { (_: [String: Any]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertEqual(responseCode, 204)
    }
    
    func testPutPet() {
        // Given
        let request = put(path: "/v2/pet")
        
        // When
        var responseCode: Int?
        call(request: request, description: "Updating Pet") { (_: [String: Any]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertEqual(responseCode, 204)
    }
    
    func testDeletePet() {
        // Given
        let request = delete(path: "/v2/pet/123")
        
        // When
        var responseCode: Int?
        call(request: request, description: "Deleting Pet") { (_: [String: Any]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertEqual(responseCode, 204)
    }
    
    func testPostPetPicture() {
        // Given
        let request = post(path: "/v2/pet/123/uploadImage")
        
        // When
        var responseCode: Int?
        call(request: request, description: "Uploading Pet Picture") { (_: [String: Any]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertEqual(responseCode, 200)
    }
    
    // MARK: - User tests
    
    func testPostUser() {
        // Given
        let request = post(path: "/v2/user")
        
        // When
        var responseCode: Int?
        call(request: request, description: "Posting User") { (_: [String: Any]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertEqual(responseCode, 204)
    }
    
    func testPostUserArray() {
        // Given
        let request = post(path: "/v2/user/createWithArray", body: [])
        
        // When
        var responseCode: Int?
        call(request: request, description: "Creating User With Array") { (_: [String: Any]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertEqual(responseCode, 204)
    }
    
    func testPostUserList() {
        // Given
        let request = post(path: "/v2/user/createWithList", body: [])
        
        // When
        var responseCode: Int?
        call(request: request, description: "Creating User With List") { (_: [String: Any]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertEqual(responseCode, 204)
    }
    
    func testGetLogin() {
        // Given
        let request = get(path: "/v2/user/login")
        
        // When
        var responseString: String?
        call(request: request, description: "Login") { (response: String?, _, _, _) in
            responseString = response
        }
        
        // Then
        XCTAssertNotNil(responseString)
        XCTAssertTrue(responseString == "Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
    }
    
    func testGetLogout() {
        // Given
        let request = get(path: "/v2/user/logout")
        
        // When
        var responseString: String?
        call(request: request, description: "Logout") { (response: String?, _, _, _) in
            responseString = response
        }
        
        // Then
        XCTAssertNil(responseString)
    }
    
    func testGetUser() {
        // Given
        let request = get(path: "/v2/user/john")
        let expectedResponse = [
            "id": 123456789,
            "username": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "firstName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "lastName": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "email": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "password": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "phone": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "userStatus": 123
        ].formatted
        
        // When
        var responseJson: [String: Any]?
        call(request: request, description: "Loading User") { (response: [String: Any]?, _, _, _) in
            responseJson = response
        }
        
        // Then
        XCTAssertNotNil(responseJson)
        XCTAssertTrue(responseJson ?? [:] == expectedResponse)
    }
    
    func testPutUser() {
        // Given
        let request = put(path: "/v2/user/john")
        
        // When
        var responseCode: Int?
        call(request: request, description: "Updating User") { (_: [String: Any]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertEqual(responseCode, 204)
    }
    
    func testDeleteUser() {
        // Given
        let request = delete(path: "/v2/user/john")
        
        // When
        var responseCode: Int?
        call(request: request, description: "Deleting User") { (_: [String: Any]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertEqual(responseCode, 204)
    }
}
