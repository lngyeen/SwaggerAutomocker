# SwaggerAutomocker

[![CI Status](https://img.shields.io/travis/lngyeen/SwaggerAutomocker.svg?style=flat)](https://travis-ci.org/lngyeen/SwaggerAutomocker)
[![Version](https://img.shields.io/cocoapods/v/SwaggerAutomocker.svg?style=flat)](https://cocoapods.org/pods/SwaggerAutomocker)
[![License](https://img.shields.io/cocoapods/l/SwaggerAutomocker.svg?style=flat)](https://cocoapods.org/pods/SwaggerAutomocker)
[![Platform](https://img.shields.io/cocoapods/p/SwaggerAutomocker.svg?style=flat)](https://cocoapods.org/pods/SwaggerAutomocker)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SwaggerAutomocker is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwaggerAutomocker'
```

## Usage

Configure App Transport Security:
Because the purpose of this mock server is only for mock environment, our server only supports http protocol, so to be able to run the mock server you need to disable App Transport Security by adding the key App Transport Security Settings to your Info.plist, with a sub-key where Allow Arbitrary Loads is set to Yes.

Config data generator:
```swift
var dataGenerator: DataGenerator {
    let dataGenerator = DataGenerator()
    dataGenerator.useFakeryDataGenerator = true
    dataGenerator.distinctElementsInArray = true
    dataGenerator.generateDummyDataLazily = true
    dataGenerator.rootArrayElementCount = 3
    dataGenerator.childArrayElementCount = 3
    
    // DefaultDataConfigurator
    dataGenerator.defaultDataConfigurator.dateTimeDefaultValue = "2021-01-01T17:32:28Z"
    // ...
    
    // FakeryDataConfigurator
    dataGenerator.fakeryDataConfigurator.minInt = 0
    dataGenerator.fakeryDataConfigurator.maxInt = 1000000
    // ...
    return dataGenerator
}
```

Start mock server from embedded swagger json file:
```swift
var mockServer: MockServer?

let swaggerJson = readJSONFromFile(fileName: "swagger")
if let swaggerJson = swaggerJson {
    mockServer = MockServer(port: 8080, swaggerJson: swaggerJson, dataGenerator: dataGenerator)
    mockServer?.responseDataSource = self
    mockServer?.start()
}
```

or from swagger json url:
```swift
var mockServer: MockServer?

let swaggerUrl = "https://mobileapp-fe-dev.swissmedical.net/aevis-app-backend-api/v3/api-docs"
mockServer = MockServer(port: 8080, swaggerUrl: swaggerUrl, dataGenerator: dataGenerator)
mockServer?.responseDataSource = self
mockServer?.start()
```

Stop mock server:
```swift
mockServer?.stop()
```

Custom response for each request if needed via MockServerResponseDataSource protocol:
```swift
func mockServer(_ mockServer: MockServer, responseFor request: HTTPRequest, possibleResponses: [HTTPResponse]) -> HTTPResponse? {
    // Pick one response from possibleResponses array
    return possibleResponses.first(where: {$0.statusCode > 299})
    
    // or customize your own response for each request depending on
    // request.path, request.method, request.pathParams, request.queryItems
    // request.body.jsonObject, request.body.jsonArray, request.body.stringArray, request.body.string
    return HTTPResponse(statusCode: 409, 
                        headers: ["X-Server-Message": "Conflict"], 
                        body: "Email was used to sign up for another account.".utf8Data)
}
```

## Author

lngyeen, lngyeen@openwt.com

## License

SwaggerAutomocker is available under the MIT license. See the LICENSE file for more info.
