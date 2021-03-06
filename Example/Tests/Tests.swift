import SwaggerAutomocker
import XCTest

class Tests: XCTestCase {
    static var mockServer: MockServer?
    
    class var dataGenerator: DataGenerator {
        let dataGenerator = DataGenerator()
        dataGenerator.defaultDataConfigurator.dateTimeDefaultValue = "2021-01-01T17:32:28Z"
        return dataGenerator
    }
    
    class var port: Int {
        return 8089
    }
    
    class var jsonFileName: String {
        return "swagger"
    }
    
    override class func setUp() {
        super.setUp()
        
        if let json = readJSONFromFile(fileName: jsonFileName) as? [String: Any] {
            Tests.mockServer = MockServer(port: Self.port,
                                          swaggerJson: json,
                                          dataGenerator: Self.dataGenerator)
            Tests.mockServer?.start()
        }
    }
    
    override class func tearDown() {
        super.tearDown()
        
        Tests.mockServer?.stop()
        Tests.mockServer = nil
    }
}

// MARK: HTTP Request helpers

extension Tests {
    class func readJSONFromFile(fileName: String) -> Any? {
        if let fileUrl = Bundle(for: Self.self).url(forResource: fileName, withExtension: "json"),
           let data = try? Data(contentsOf: fileUrl, options: .mappedIfSafe)
        {
            return try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        }
        return nil
    }
    
    func get(path: String) -> URLRequest {
        let url = serverURL(path: path)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    func post(path: String, body: Any? = nil) -> URLRequest {
        let url = serverURL(path: path)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [.prettyPrinted, .fragmentsAllowed])
        }
        return request
    }
    
    func put(path: String, body: Any? = nil) -> URLRequest {
        let url = serverURL(path: path)
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [.prettyPrinted, .fragmentsAllowed])
        }
        return request
    }
    
    func delete(path: String) -> URLRequest {
        let url = serverURL(path: path)
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    func head(path: String) -> URLRequest {
        let url = serverURL(path: path)
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    func patch(path: String, body: Any? = nil) -> URLRequest {
        let url = serverURL(path: path)
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [.prettyPrinted, .fragmentsAllowed])
        }
        return request
    }
    
    func call(request: URLRequest, description: String = "Requesting", completionHandler: @escaping ([[String: Any]]?, [AnyHashable: Any]?, Int?, Error?) -> Void) {
        let exp = expectation(description: description)
        let httpClient = URLSession.shared
        let httpTask = httpClient.dataTask(with: request) { data, response, error in
            
            let jsonArray: [[String: Any]]? = data?.jsonArray
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            if let error = error {
                print("[CLIENT]", "Request failed - status:", statusCode, "- error: \(error)")
            }
            print(httpClient.responseDescription(data: data, request: request, response: response))
            completionHandler(jsonArray,
                              (response as? HTTPURLResponse)?.allHeaderFields,
                              statusCode,
                              error)
            exp.fulfill()
        }
        print(httpClient.requestDescription(dataTask: httpTask))
        httpTask.resume()
        wait(for: [exp], timeout: 60)
    }
    
    func call(request: URLRequest, description: String = "Requesting", completionHandler: @escaping ([String: Any]?, [AnyHashable: Any]?, Int?, Error?) -> Void) {
        let exp = expectation(description: description)
        let httpClient = URLSession.shared
        let httpTask = httpClient.dataTask(with: request) { data, response, error in
            
            let jsonObject: [String: Any]? = data?.jsonObject
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            if let error = error {
                print("[CLIENT]", "Request failed - status:", statusCode, "- error: \(error)")
            }
            print(httpClient.responseDescription(data: data, request: request, response: response))
            completionHandler(jsonObject,
                              (response as? HTTPURLResponse)?.allHeaderFields,
                              statusCode,
                              error)
            exp.fulfill()
        }
        print(httpClient.requestDescription(dataTask: httpTask))
        httpTask.resume()
        wait(for: [exp], timeout: 60)
    }
    
    func call(request: URLRequest, description: String = "Requesting", completionHandler: @escaping (String?, [AnyHashable: Any]?, Int?, Error?) -> Void) {
        let exp = expectation(description: description)
        let httpClient = URLSession.shared
        let httpTask = httpClient.dataTask(with: request) { data, response, error in
            
            let responseString: String? = data?.string
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            if let error = error {
                print("[CLIENT]", "Request failed - status:", statusCode, "- error: \(error)")
            }
            print(httpClient.responseDescription(data: data, request: request, response: response))
            completionHandler(responseString,
                              (response as? HTTPURLResponse)?.allHeaderFields,
                              statusCode,
                              error)
            exp.fulfill()
        }
        print(httpClient.requestDescription(dataTask: httpTask))
        httpTask.resume()
        wait(for: [exp], timeout: 60)
    }
    
    func uploadImages(path: String, images: [UIImage], parameters: [String: String]?, description: String = "Uploading", completionHandler: @escaping (Any?, [AnyHashable: Any]?, Int?, Error?) -> Void) {
        let url = serverURL(path: path)
        let boundary = "Boundary-\(NSUUID().uuidString)"
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let mediaImages = images.compactMap { Media(withImage: $0, forKey: "file") }
        request.httpBody = requesBodyWith(params: parameters, media: mediaImages, boundary: boundary)
        
        let exp = expectation(description: description)
        let httpClient = URLSession.shared
        let httpTask = httpClient.dataTask(with: request) { data, response, error in
            
            let jsonObject: [String: Any]? = data?.jsonObject
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            if let error = error {
                print("[CLIENT]", "Request failed - status:", statusCode, "- error: \(error)")
            }
            print(httpClient.responseDescription(data: data, request: request, response: response))
            completionHandler(jsonObject,
                              (response as? HTTPURLResponse)?.allHeaderFields,
                              statusCode,
                              error)
            exp.fulfill()
        }
        print(httpClient.requestDescription(dataTask: httpTask))
        httpTask.resume()
        wait(for: [exp], timeout: 60)
    }
    
    private func requesBodyWith(params: [String: String]?, media: [Media], boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        
        for photo in media {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.fileName)\"\(lineBreak)")
            body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
            body.append(photo.data)
            body.append(lineBreak)
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }

    func serverURL(path: String) -> URL {
        var components = URLComponents()
        components.scheme = "http"
        components.port = Self.port
        components.host = "localhost"
        let pathAndQueries = path.components(separatedBy: "?")
        components.path = pathAndQueries.first ?? ""
        components.query = pathAndQueries.count > 1 ? pathAndQueries.last : nil
        return components.url!
    }
    
    func expectedResponseFromJson(request: URLRequest) -> Any? {
        let fullPath = String(describing: type(of: self)) +
            "_" +
            (request.httpMethod?.lowercased() ?? "") +
            (request.url?.path ?? "")
        let jsonFileName = fullPath.replacingOccurrences(of: "/", with: "_")
        return Tests.readJSONFromFile(fileName: jsonFileName)
    }
}

// MARK: JSON helpers

func areEqual(_ left: Any, _ right: Any) -> Bool {
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

extension Dictionary where Key == String, Value == Any {
    var formatted: [String: Any] {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
            let formattedDictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any]
            return formattedDictionary ?? self
        } catch {
            return self
        }
    }
}

extension Dictionary where Value: Any {
    static func != (left: [Key: Value], right: [Key: Value]) -> Bool { return !(left == right) }
    static func == (left: [Key: Value], right: [Key: Value]) -> Bool {
        if left.count != right.count { return false }
        for leftElement in left {
            guard let rightValue = right[leftElement.key],
                  areEqual(rightValue, leftElement.value) else { return false }
        }
        return true
    }
}

extension URLSession {
    /// Print the request in a nice way
    func requestDescription(dataTask: URLSessionDataTask) -> String {
        guard let request = dataTask.originalRequest,
              let url = request.url else { return "Unable to describe request" }
        
        let components = requestComponents(dataTask: dataTask)
        
        var logRequest = "Request description (\(String(describing: self)):\n"
        let urlString = url.absoluteString
        logRequest += String(repeating: "- ", count: 14 + urlString.count/2)
        logRequest += "\n|"
            + String(repeating: " ", count: 13)
            + "\(urlString)"
            + String(repeating: " ", count: 12)
            + "|"
        logRequest += "\n" + String(repeating: "- ", count: 14 + urlString.count/2)
        if let httpMethod = request.httpMethod {
            logRequest += "\n|     Request: \(String(describing: httpMethod)) - \(url)"
        }
        
        if let cookies = components["Cookies"] as? [String: String], !cookies.isEmpty {
            logRequest += "\n|     Cookies: \(cookies)"
        }
        if let headerFields = components["Headers"] as? [String: Any], !headerFields.isEmpty {
            logRequest += "\n|     Headers: \(headerFields)"
        }
        
        if let payload = request.httpBody {
            if let payloadObject = payload.jsonObject {
                logRequest += "\n|     Body    :\n \(payloadObject)"
            } else if let payloadArray = payload.jsonArray {
                logRequest += "\n|     Body    :\n \(payloadArray)"
            } else if let payloadArray = payload.stringArray {
                logRequest += "\n|     Body    :\n \(payloadArray)"
            } else if let payloadString = payload.string {
                logRequest += "\n|     Body    :\n \(payloadString)"
            }
        }
        
        logRequest += "\n" + String(repeating: "- ", count: 14 + urlString.count/2) + "\n"
        
        return logRequest
    }
    
    /// Print the response in a nice way
    func responseDescription(data: Data?, request: URLRequest, response: URLResponse?) -> String {
        guard let url = request.url,
              let response = response as? HTTPURLResponse else { return "Unable to describe response" }
        
        let maxResponseLength = 10000000
        var logResponse = "Response description (\(String(describing: self).hashValue)):\n"
        let urlString = url.absoluteString
        logResponse += String(repeating: "- ", count: 14 + urlString.count/2)
        logResponse += "\n|"
            + String(repeating: " ", count: 13)
            + "\(urlString)"
            + String(repeating: " ", count: 12)
            + "|"
        logResponse += "\n" + String(repeating: "- ", count: 14 + urlString.count/2)
        if let httpMethod = request.httpMethod {
            logResponse += "\n|     Response: \(String(describing: httpMethod)) - \(url)"
        }
        
        logResponse += "\n|     Status: \(response.statusCode)"
        if let headerFields = response.allHeaderFields as? [String: String], !headerFields.isEmpty {
            logResponse += "\n|     Headers\(headerFields.count):\n\(headerFields)"
        }
        if let responseObject = data?.jsonObject {
            var responseJSON = responseObject.prettyPrinted
            responseJSON = "      " + responseJSON.replacingOccurrences(of: "\n", with: "\n      ")
            if responseJSON.count > maxResponseLength {
                responseJSON = String(responseJSON.prefix(maxResponseLength))
                responseJSON += " (...) \n     The response is too long and has been truncated to the first \(maxResponseLength) chars)"
            }
            logResponse += "\n|     \(type(of: responseObject)) :\n\(responseJSON)"
        } else if let responseObjectArray = data?.jsonArray {
            var responseJSON = responseObjectArray.prettyPrinted
            if responseJSON.count > maxResponseLength {
                responseJSON = String(responseJSON.prefix(maxResponseLength))
                responseJSON += " (...) \n     The response is too long and has been truncated to the first \(maxResponseLength) chars)"
            }
            responseJSON = "      " + responseJSON.replacingOccurrences(of: "\n", with: "\n      ")
            logResponse += "\n|     \(type(of: responseObjectArray)) (\(responseObjectArray.count) objects):\n\(responseJSON)"
        } else if let responseObjectArray = data?.stringArray {
            var responseJSON = responseObjectArray.prettyPrinted
            if responseJSON.count > maxResponseLength {
                responseJSON = String(responseJSON.prefix(maxResponseLength))
                responseJSON += " (...) \n     The response is too long and has been truncated to the first \(maxResponseLength) chars)"
            }
            responseJSON = "      " + responseJSON.replacingOccurrences(of: "\n", with: "\n      ")
            logResponse += "\n|     \(type(of: responseObjectArray)) (\(responseObjectArray.count) objects):\n\(responseJSON)"
        } else if var responseString = data?.string {
            if responseString.count > maxResponseLength {
                responseString = String(responseString.prefix(maxResponseLength))
                responseString += " (...) \n     The response is too long and has been truncated to the first \(maxResponseLength) chars)"
            }
            responseString = "      " + responseString.replacingOccurrences(of: "\n", with: "\n      ")
            logResponse += "\n|     \(type(of: responseString)) :\n\(responseString)"
        }
        
        logResponse += "\n" + String(repeating: "- ", count: 14 + urlString.count/2) + "\n"
        
        return logResponse
    }
    
    private func requestComponents(dataTask: URLSessionDataTask) -> [String: Any] {
        guard let url = dataTask.originalRequest?.url else {
            return [:]
        }
        
        var cookiesComponents: [String: String] = [:]
        var headersComponents: [AnyHashable: Any] = [:]
        
        if let cookies = HTTPCookieStorage.shared.cookies(for: url), !cookies.isEmpty {
            cookies.forEach { cookiesComponents[$0.name] = $0.value }
        }
        
        var headers: [AnyHashable: Any] = [:]
        
        if let additionalHeaders = configuration.httpAdditionalHeaders {
            for (field, value) in additionalHeaders where field != AnyHashable("Cookie") {
                headers[field] = value
            }
        }
        
        if let headerFields = dataTask.originalRequest?.allHTTPHeaderFields {
            for (field, value) in headerFields where field != "Cookie" {
                headers[field] = value
            }
        }
        
        for (field, value) in headers {
            headersComponents[field] = value
        }
        
        return ["Cookies": cookiesComponents, "Headers": headersComponents]
    }
}

struct Media {
    enum ImageCompressionType {
        case jpg(quality: CGFloat), png
    }

    let key: String
    let fileName: String
    let data: Data
    let mimeType: String
    
    init?(withImage image: UIImage,
          forKey key: String,
          compressionType: ImageCompressionType = .jpg(quality: 0.5))
    {
        self.key = key
        switch compressionType {
        case .jpg(let quality):
            guard let data = image.jpegData(compressionQuality: quality) else { return nil }
            self.mimeType = "image/jpg"
            self.fileName = "\(arc4random()).jpeg"
            self.data = data
        case .png:
            guard let data = image.pngData() else { return nil }
            self.mimeType = "image/png"
            self.fileName = "\(arc4random()).png"
            self.data = data
        }
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
