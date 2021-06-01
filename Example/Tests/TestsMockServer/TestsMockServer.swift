import SwaggerAutomocker
import XCTest

final class TestsMockServer: Tests {
    private var privateMockServer: MockServer?
    
    override class var port: Int {
        return 8089
    }
    
    override class var dataGenerator: DataGenerator {
        let dataGenerator = DataGenerator()
        dataGenerator.useFakeryDataGenerator = false
        dataGenerator.rootArrayElementCount = 3
        dataGenerator.defaultDataConfigurator.dateTimeDefaultValue = "2021-01-01T17:32:28Z"
        return dataGenerator
    }
    
    override class func setUp() {}
    override class func tearDown() {}
    
    override func tearDown() {
        stopServer()
    }
    
    private func startServer(_ swaggerJson: [String: Any]) {
        privateMockServer = MockServer(port: Self.port,
                                       swaggerJson: swaggerJson,
                                       dataGenerator: Self.dataGenerator)
        privateMockServer?.start()
    }
    
    private func stopServer() {
        privateMockServer?.stop()
        privateMockServer = nil
    }
    
    // MARK: Mock server should cover all endpoints in swagger json
    
    func testsMockserverShouldCoverAllEndpointsInSwaggerJson() {
        testMockserverShouldHasNoAnyEndpoint()
        
        testMockserverShouldCoverOneEndpoint()
        
        testMockserverShouldCoverTwoEndpoints()
        
        testMockserverShouldCoverFourEndpoints()
    }
    
    func testMockserverShouldHasNoAnyEndpoint() {
        // Given
        guard let emptyEndpointSwaggerJson = Tests.readJSONFromFile(fileName: "empty_swagger") as? [String: Any] else { return }
        
        // When
        startServer(emptyEndpointSwaggerJson)
        
        // Then
        XCTAssert(privateMockServer?.endpoints.count == 0)
    }
    
    func testMockserverShouldCoverOneEndpoint() {
        // Given
        guard let oneEndpointSwaggerJson = Tests.readJSONFromFile(fileName: "one_endpoint_swagger") as? [String: Any] else { return }
        
        // When
        startServer(oneEndpointSwaggerJson)
        
        // Then
        XCTAssert(privateMockServer?.endpoints.count == 1)
    }
    
    func testMockserverShouldCoverTwoEndpoints() {
        // Given
        guard let twoEndpointsSwaggerJson = Tests.readJSONFromFile(fileName: "two_endpoints_swagger") as? [String: Any] else { return }
        
        // When
        startServer(twoEndpointsSwaggerJson)
        
        // Then
        XCTAssert(privateMockServer?.endpoints.count == 2)
    }
    
    func testMockserverShouldCoverFourEndpoints() {
        // Given
        guard let fourEndpointsSwaggerJson = Tests.readJSONFromFile(fileName: "four_endpoints_swagger") as? [String: Any] else { return }

        // When
        startServer(fourEndpointsSwaggerJson)

        // Then
        XCTAssert(privateMockServer?.endpoints.count == 4)
    }
    
    // MARK: Number of response objects should equal to default array element count in data generator
    
    func testNumberOfResponseObjectsShouldEqualToRootArrayElementCountInDataGenerator() {
        // Given
        guard let oneEndpointSwaggerJson = Tests.readJSONFromFile(fileName: "four_endpoints_swagger") as? [String: Any] else { return }
        let request = get(path: "/api/v1/hospital")
        startServer(oneEndpointSwaggerJson)

        // When
        var jsonResponse: [[String: Any]]?
        call(request: request, description: "Get all hospitals") { (response: [[String: Any]]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        guard let jsonArray = jsonResponse else { return XCTFail() }
        XCTAssertEqual(jsonArray.count, TestsMockServer.dataGenerator.rootArrayElementCount)
        for element in jsonArray {
            XCTAssertTrue(element.elementCountInChildrenArrayisEqualTo(TestsMockServer.dataGenerator.rootArrayElementCount))
        }
    }
    
    func testServerShouldReturnEnumValueForPropertyThatHasEnumFieldInSchema() {
        // Given
        guard let twoEndpointSwaggerJson = Tests.readJSONFromFile(fileName: "two_endpoints_swagger") as? [String: Any] else { return }
        startServer(twoEndpointSwaggerJson)
        let request = get(path: "/api/v1/company/123")
        
        // When
        var jsonResponse: [String: Any]?
        call(request: request, description: "Get company by id") { (response: [String: Any]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue([
            "ACTIVE",
            "NON_ACTIVE"
        ].contains((jsonResponse?["status"] as? String) ?? ""))
    }
    
    func testServerShouldReturnSuccessStatusCodeForAllEndpoints() {
        testServerShouldReturnSuccessStatusCodeWhenGetAllCompanies()
        
        testServerShouldReturnSuccessStatusCodeWhenPostNewCompany()
        
        testServerShouldReturnSuccessStatusCodeWhenGetAllHospitals()
        
        testServerShouldReturnSuccessStatusCodeWhenPostNewHospital()
    }
    
    // MARK: Server should return success status code
    
    func testServerShouldReturnSuccessStatusCodeWhenGetAllCompanies() {
        // Given
        guard let fourEndpointSwaggerJson = Tests.readJSONFromFile(fileName: "four_endpoints_swagger") as? [String: Any] else { return }
        startServer(fourEndpointSwaggerJson)
        let request = get(path: "/api/v1/company")
        
        // When
        var responseCode: Int?
        call(request: request, description: "Get all companies") { (_: [[String: Any]]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertNotNil(responseCode)
        XCTAssertTrue(Array(200...299).contains(responseCode ?? 0))
    }
    
    func testServerShouldReturnSuccessStatusCodeWhenPostNewCompany() {
        // Given
        guard let fourEndpointSwaggerJson = Tests.readJSONFromFile(fileName: "four_endpoints_swagger") as? [String: Any] else { return }
        startServer(fourEndpointSwaggerJson)
        let request = post(path: "/api/v1/company")
        
        // When
        var responseCode: Int?
        call(request: request, description: "Post new company") { (_: [[String: Any]]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertNotNil(responseCode)
        XCTAssertTrue(Array(200...299).contains(responseCode ?? 0))
    }
    
    func testServerShouldReturnSuccessStatusCodeWhenGetAllHospitals() {
        // Given
        guard let fourEndpointSwaggerJson = Tests.readJSONFromFile(fileName: "four_endpoints_swagger") as? [String: Any] else { return }
        startServer(fourEndpointSwaggerJson)
        let request = get(path: "/api/v1/hospital?name=foo&title=bar")
        
        // When
        var responseCode: Int?
        call(request: request, description: "Get all hospitals") { (_: [[String: Any]]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertNotNil(responseCode)
        XCTAssertTrue(Array(200...299).contains(responseCode ?? 0))
    }
    
    func testServerShouldReturnSuccessStatusCodeWhenPostNewHospital() {
        // Given
        guard let fourEndpointSwaggerJson = Tests.readJSONFromFile(fileName: "four_endpoints_swagger") as? [String: Any] else { return }
        startServer(fourEndpointSwaggerJson)
        let request = post(path: "/api/v1/hospital")
        
        // When
        var responseCode: Int?
        call(request: request, description: "Post new hospital") { (_: [[String: Any]]?, _, statusCode, _) in
            responseCode = statusCode
        }
        
        // Then
        XCTAssertNotNil(responseCode)
        XCTAssertTrue(Array(200...299).contains(responseCode ?? 0))
    }
    
    // MARK: Server should return default email value for property that has email format
    
    func testServerShouldReturnDefaultEmailValueForPropertyThatHasEmailFormat() {
        // Given
        guard let twoEndpointSwaggerJson = Tests.readJSONFromFile(fileName: "two_endpoints_swagger") as? [String: Any] else { return }
        startServer(twoEndpointSwaggerJson)
        let request = get(path: "/api/v1/company/123?name=foo")
        
        // When
        var jsonResponse: [String: Any]?
        call(request: request, description: "Get company by id") { (response: [String: Any]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertEqual((jsonResponse?["contact"] as? [String: Any])?["email"] as? String, TestsMockServer.dataGenerator.defaultDataConfigurator.emailDefaultValue)
    }
    
    func testServerShouldReturnExampleDataWhenSwaggerJsonHasExampleValue() {
        // Given
        guard let twoEndpointSwaggerJson = Tests.readJSONFromFile(fileName: "two_endpoints_swagger") as? [String: Any] else { return }
        startServer(twoEndpointSwaggerJson)
        let request = get(path: "/api/v1/company")
        let expectedResponse = [
            [
                "contactDetails": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "contact": [
                "name": "Rodrigo Armstrong",
                "id": 123456789
                ],
                "name": "Rodrigo Armstrong",
                "status": "ACTIVE",
                "id": 123456789
            ],
            [
                "contactDetails": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "contact": [
                "name": "Selena Hessel",
                "id": 234567890
                ],
                "name": "Selena Hessel",
                "status": "NON_ACTIVE",
                "id": 234567890
            ],
            [
                "contactDetails": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "contact": [
                "name": "Vernon Wiza",
                "id": 345678901
                ],
                "name": "Vernon Wiza",
                "status": "ACTIVE",
                "id": 345678901
            ]
        ].map{ $0.formatted }
        
        // When
        var jsonResponse: [[String: Any]]?
        call(request: request, description: "Get all companies") { (response: [[String: Any]]?, _, _, _) in
            jsonResponse = response
        }
        
        // Then
        XCTAssertNotNil(jsonResponse)
        XCTAssertTrue(jsonResponse ?? [[:]] == expectedResponse)
    }
}

private extension Dictionary where Key == String, Value == Any {
    /// Check all nested array element count is equal to number or not
    /// - Parameter number: Int
    /// - Returns: Bool
    func elementCountInChildrenArrayisEqualTo(_ number: Int) -> Bool {
        var result: Bool = true
        
        for value in values {
            if let childArray = value as? [Any] {
                result = result && (childArray.isEmpty ? true : childArray.count == number)
                for element in childArray {
                    if let elementObject = element as? [String: Any] {
                        result = result && elementObject.elementCountInChildrenArrayisEqualTo(number)
                    }
                }
            }
            if let childObject = value as? [String: Any] {
                result = result && childObject.elementCountInChildrenArrayisEqualTo(number)
            }
        }
        return result
    }
}
