import SwaggerAutomocker
import XCTest

final class TestsSwagger: Tests {
    override class var jsonFileName: String {
        return "swagger"
    }
    
    // MARK: Inventory tests
    
    func testGetInventory() throws {
        // Given
        let request = get(path: "/v2/store/inventory")
        let expectedResponse = [
            "id": 123456789,
            "name": "string value"
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
    
    func testPostOrder() throws {
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
    
    func testGetOrder() throws {
        // Given
        let request = get(path: "/v2/store/order/123")
        let expectedResponse = [
            "petId": 123456789,
            "quantity": 123,
            "status": "placed",
            "shipDate": "string value",
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
    
    func testDeleteOrder() throws {
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
    
    func testGetPetById() throws {
        // Given
        let request = get(path: "/v2/pet/123")
        let expectedResponse = [
            "id": 123456789,
            "category": [
                "id": 123456789,
                "name": "string value"
            ],
            "name": "doggie",
            "photoUrls": [
                "string value",
                "string value",
                "string value"
            ],
            "tags": [
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
    
    func testFindPet() throws {
        // Given
        let request = get(path: "/v2/pet/findByStatus")
        let expectedResponse = [
            ["id": 123456789,
             "category": ["id": 123456789, "name": "string value"],
             "name": "doggie",
             "photoUrls": ["string value", "string value", "string value"],
             "tags": [
                 ["id": 123456789, "name": "string value"],
                 ["id": 123456789, "name": "string value"],
                 ["id": 123456789, "name": "string value"]
             ],
             "status": "available"],
            ["id": 123456789,
             "category": ["id": 123456789, "name": "string value"],
             "name": "doggie",
             "photoUrls": ["string value", "string value", "string value"],
             "tags": [
                 ["id": 123456789, "name": "string value"],
                 ["id": 123456789, "name": "string value"],
                 ["id": 123456789, "name": "string value"]
             ],
             "status": "available"],
            ["id": 123456789,
             "category": ["id": 123456789, "name": "string value"],
             "name": "doggie",
             "photoUrls": ["string value", "string value", "string value"],
             "tags": [
                 ["id": 123456789, "name": "string value"],
                 ["id": 123456789, "name": "string value"],
                 ["id": 123456789, "name": "string value"]
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
    
    func testPostPet() throws {
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
    
    func testPostPet2() throws {
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
    
    func testPutPet() throws {
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
    
    func testDeletePet() throws {
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
    
    func testPostPetPicture() throws {
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
    
    func testPostUser() throws {
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
    
    func testPostUserArray() throws {
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
    
    func testPostUserList() throws {
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
    
    func testGetLogin() throws {
        // Given
        let request = get(path: "/v2/user/login")
        
        // When
        var responseString: String?
        call(request: request, description: "Login") { (response: String?, _, _, _) in
            responseString = response
        }
        
        // Then
        XCTAssertNotNil(responseString)
        XCTAssertTrue(responseString == "string value")
    }
    
    func testGetLogout() throws {
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
    
    func testGetUser() throws {
        // Given
        let request = get(path: "/v2/user/john")
        let expectedResponse = [
            "id": 123456789,
            "username": "string value",
            "firstName": "string value",
            "lastName": "string value",
            "email": "string value",
            "password": "string value",
            "phone": "string value",
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
    
    func testPutUser() throws {
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
    
    func testDeleteUser() throws {
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
