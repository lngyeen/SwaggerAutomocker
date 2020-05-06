import XCTest
import SwaggerAutomocker

class Tests: XCTestCase {
    private let PORT = 8080
    var mockServer: MockServer?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let json = readJSONFromFile(fileName: "swagger")
        if let json = json {
            mockServer = MockServer(port: PORT, swaggerJson: json)
            mockServer?.start()
        }
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        mockServer?.stop()
    }
    
    
    // MARK: Inventory tests
    
    func testGetInventory() throws {
        let request = get(path: "/store/inventory")
        let expectedResponse = formatDictionary([
            "id": "123",
            "name": "string"])
        var jsonResponse: [String: Any]?
        
        call(request: request, description: "Loading Inventory") { (data, response, _) in
            if let jsonData = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any]
                    jsonResponse = json
                } catch let error as NSError {
                    print(error)
                }
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
    
    func testPostOrder() throws {
        let request = post(path: "/store/order", body: [:])
        var responseCode: Int?
        
        call(request: request, description: "Posting Order") { (data, response, _) in
            if let httpResponse = response as? HTTPURLResponse {
                responseCode = httpResponse.statusCode
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(responseCode, 200)
    }
    
    func testGetOrder() throws {
        let request = get(path: "/store/order/123")
        let expectedResponse: [String: Any] = formatDictionary([
            "petId": "123",
            "quantity": "123",
            "status": "string",
            "shipDate": "string",
            "id": "123",
            "complete": "true"])
        var jsonResponse: [String: Any]?
        
        call(request: request, description: "Loading Order") { (data, response, _) in
            if let jsonData = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: jsonData, options : .allowFragments) as? [String: Any]
                    jsonResponse = json
                } catch let error as NSError {
                    print(error)
                }
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
    
    func testDeleteOrder() throws {
        let request = delete(path: "/store/order/123")
        var responseCode: Int?
        
        call(request: request, description: "Deleting Order") { (data, response, _) in
            if let httpResponse = response as? HTTPURLResponse {
                responseCode = httpResponse.statusCode
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(responseCode, 204)
    }
    
    //MARK: - Pet Tests
    
    func testGetPet() throws {
        let request = get(path: "/pet/123")
        let expectedResponse: [String: Any] = formatDictionary([
            "id": "123",
            "category": [
                "id": "123",
                "name": "string"
            ],
            "name": "doggie",
            "photoUrls": [
                "string",
                "string",
                "string"
            ],
            "tags": [
                [
                    "id": "123",
                    "name": "string"
                ],
                [
                    "id": "123",
                    "name": "string"
                ],
                [
                    "id": "123",
                    "name": "string"
                ]
            ],
            "status": "string"])
        var jsonResponse: [String: Any]?
        
        call(request: request, description: "Loading Pet") { (data, response, _) in
            if let jsonData = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: jsonData, options : .allowFragments) as? [String: Any]
                    jsonResponse = json
                } catch let error as NSError {
                    print(error)
                }
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
    
    func testFindPet() throws {
        let request = get(path: "/pet/findByStatus")
        let expectedResponse = [
            ["id": "123",
             "category": ["id": "123", "name": "string"],
             "name": "doggie",
             "photoUrls": ["string", "string", "string"],
             "tags": [
                ["id": "123", "name": "string"],
                ["id": "123", "name": "string"],
                ["id": "123", "name": "string"]
                ],
             "status": "string"],
            ["id": "123",
             "category": ["id": "123", "name": "string"],
             "name": "doggie",
             "photoUrls": ["string", "string", "string"],
             "tags": [
                ["id": "123", "name": "string"],
                ["id": "123", "name": "string"],
                ["id": "123", "name": "string"]
                ],
             "status": "string"],
            ["id": "123",
             "category": ["id": "123", "name": "string"],
             "name": "doggie",
             "photoUrls": ["string", "string", "string"],
             "tags": [
                ["id": "123", "name": "string"],
                ["id": "123", "name": "string"],
                ["id": "123", "name": "string"]
                ],
             "status": "string"]
            ].map({formatDictionary($0)})
        
        var jsonResponse: [[String: Any]]?
        
        call(request: request, description: "Finding Pet") { (data, response, _) in
            if let jsonData = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: jsonData, options : .allowFragments) as? [[String: Any]]
                    jsonResponse = json
                } catch let error as NSError {
                    print(error)
                }
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [] == expectedResponse)
    }
    
    func testPostPet() throws {
        let request = post(path: "/pet")
        var responseCode: Int?
        
        call(request: request, description: "Posting Pet") { (data, response, _) in
            if let httpResponse = response as? HTTPURLResponse {
                responseCode = httpResponse.statusCode
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(responseCode, 204)
    }
    
    func testPostPet2() throws {
        let request = post(path: "/pet/123")
        var responseCode: Int?
        
        call(request: request, description: "Posting Pet 2") { (data, response, _) in
            if let httpResponse = response as? HTTPURLResponse {
                responseCode = httpResponse.statusCode
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(responseCode, 204)
    }
    
    func testPutPet() throws {
        let request = put(path: "/pet")
        var responseCode: Int?
        
        call(request: request, description: "Updating Pet") { (data, response, _) in
            if let httpResponse = response as? HTTPURLResponse {
                responseCode = httpResponse.statusCode
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(responseCode, 204)
    }
    
    func testDeletePet() throws {
        let request = delete(path: "/pet/123")
        var responseCode: Int?
        
        call(request: request, description: "Deleting Pet") { (data, response, _) in
            if let httpResponse = response as? HTTPURLResponse {
                responseCode = httpResponse.statusCode
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(responseCode, 204)
    }
    
    func testPostPetPicture() throws {
        let request = post(path: "/pet/123/uploadImage")
        var responseCode: Int?
        
        call(request: request, description: "Uploading Pet Picture") { (data, response, _) in
            if let httpResponse = response as? HTTPURLResponse {
                responseCode = httpResponse.statusCode
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(responseCode, 200)
    }
    
    //MARK: - User tests
    
    func testPostUser() throws {
        let request = post(path: "/user")
        var responseCode: Int?
        
        call(request: request, description: "Posting User") { (data, response, _) in
            if let httpResponse = response as? HTTPURLResponse {
                responseCode = httpResponse.statusCode
            }
        }
        
        waitForExpectations(timeout: 10)
        XCTAssertEqual(responseCode, 204)
    }
    
    func testPostUserArray() throws {
        let request = post(path: "/user/createWithArray", body: [])
        var responseCode: Int?
        
        call(request: request, description: "Creating User With Array") { (data, response, _) in
            if let httpResponse = response as? HTTPURLResponse {
                responseCode = httpResponse.statusCode
            }
        }
        
        waitForExpectations(timeout: 10)
        XCTAssertEqual(responseCode, 204)
    }
    
    func testPostUserList() throws {
        let request = post(path: "/user/createWithList", body: [])
        var responseCode: Int?
        
        call(request: request, description: "Creating User With List") { (data, response, _) in
            if let httpResponse = response as? HTTPURLResponse {
                responseCode = httpResponse.statusCode
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(responseCode, 204)
    }
    
    func testGetLogin() throws {
        let request = get(path: "/user/login")
        var stringResponse: String?
        
        call(request: request, description: "Login") { (data, response, _) in
            if let jsonData = data {
                stringResponse = String(data: jsonData, encoding: .utf8)
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertNotNil(stringResponse)
        XCTAssertTrue(stringResponse == "string")
    }
    
    func testGetLogout() throws {
        let request = get(path: "/user/logout")
        var stringResponse: String?
        
        call(request: request, description: "Logout") { (data, response, _) in
            if let jsonData = data {
                stringResponse = String(data: jsonData, encoding: .utf8)
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertNotNil(stringResponse)
        XCTAssertTrue(stringResponse == "")
    }
    
    func testGetUser() throws {
        let request = get(path: "/user/john")
        let expectedResponse: [String: Any] = formatDictionary([
            "id": "123",
            "username": "string",
            "firstName": "string",
            "lastName": "string",
            "email": "string",
            "password": "string",
            "phone": "string",
            "userStatus": "123"])
        var jsonResponse: [String: Any]?
        
        call(request: request, description: "Loading User") { (data, response, _) in
            if let jsonData = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: jsonData, options : .allowFragments) as? [String: Any]
                    jsonResponse = json
                } catch let error as NSError {
                    print(error)
                }
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [:] == expectedResponse)
    }
    
    func testPutUser() throws {
        let request = put(path: "/user/john")
        var responseCode: Int?
        call(request: request, description: "Updating User") { (data, response, _) in
            if let httpResponse = response as? HTTPURLResponse {
                responseCode = httpResponse.statusCode
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(responseCode, 204)
    }
    
    func testDeleteUser() throws {
        let request = delete(path: "/user/john")
        var responseCode: Int?
        call(request: request, description: "Deleting User") { (data, response, _) in
            if let httpResponse = response as? HTTPURLResponse {
                responseCode = httpResponse.statusCode
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(responseCode, 204)
    }
}


// MARK: HTTP Request helpers
extension Tests {
    fileprivate func get(path: String)  -> URLRequest {
        let url = serverURL(path: path)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    fileprivate func post(path: String, body: Any = [:]) -> URLRequest {
        let url = serverURL(path: path)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [.prettyPrinted, .fragmentsAllowed])
        return request
    }
    
    fileprivate func put(path: String, body: Any = [:]) -> URLRequest {
        let url = serverURL(path: path)
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [.prettyPrinted, .fragmentsAllowed])
        return request
    }
    
    fileprivate func delete(path: String) -> URLRequest {
        let url = serverURL(path: path)
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    fileprivate func call(request: URLRequest, description: String = "Requesting", completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let exp = expectation(description: description)
        let httpClient = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: nil)
        let httpTask = httpClient.dataTask(with: request) { data, response, error in
            if let error = error {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                print("[CLIENT]", "Request failed - status:", statusCode, "- error: \(error)")
                completionHandler(nil, nil, error)
            } else {
                completionHandler(data, response, nil)
            }
            exp.fulfill()
        }
        httpTask.resume()
    }
    
    fileprivate func serverURL(path: String = "") -> URL {
        var components = URLComponents()
        if let mockServer = mockServer {
            components.scheme = mockServer.server.isSecure ? "https" : "http"
            components.port = Int(mockServer.port)
        }
        components.host = "localhost"
        components.path = "/v2" + path
        return components.url!
    }
    
    fileprivate func formatDictionary(_ dictionary: [String: Any]) -> [String: Any] {
        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [.prettyPrinted, .fragmentsAllowed])
            let formattedDictionary: [String: Any]? = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            return formattedDictionary ?? [:]
        } catch {
            return [:]
        }
    }
}


// MARK: JSON helpers

extension Tests {
    fileprivate func readJSONFromFile(fileName: String) -> [String: Any]? {
        var json: Any?
        
        if let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                do {
                    json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                } catch {
                    print("Error!! Unable to parse \(fileName).json")
                }
            } catch {
                print("Error!! Unable to load \(fileName).json")
            }
        }
        return json as? [String : Any]
    }
}

func areEqual (_ left: Any, _ right: Any) -> Bool {
    if type(of: left) == type(of: right), String(describing: left) == String(describing: right) { return true }
    if let left = left as? [Any], let right = right as? [Any] { return left == right }
    if let left = left as? [AnyHashable: Any], let right = right as? [AnyHashable: Any] { return left == right }
    return false
}

extension Array where Element: Any {
    static func != (left: [Element], right: [Element]) -> Bool { return !(left == right) }
    static func == (left: [Element], right: [Element]) -> Bool {
        if left.count != right.count { return false }
        var right = right
        loop: for leftValue in left {
            for (rightIndex, rightValue) in right.enumerated() where areEqual(leftValue, rightValue) {
                right.remove(at: rightIndex)
                continue loop
            }
            return false
        }
        return true
    }
}

extension Dictionary where Value: Any {
    static func != (left: [Key : Value], right: [Key : Value]) -> Bool { return !(left == right) }
    static func == (left: [Key : Value], right: [Key : Value]) -> Bool {
        if left.count != right.count { return false }
        for leftElement in left {
            guard let rightValue = right[leftElement.key],
                areEqual(rightValue, leftElement.value) else { return false }
        }
        return true
    }
}
