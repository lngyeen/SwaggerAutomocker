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

Start mock server:
```swift
var mockServer: MockServer?

let swaggerJson = readJSONFromFile(fileName: "swagger")
if let swaggerJson = swaggerJson {
    mockServer = MockServer(port: 8080, swaggerJson: json)
    mockServer?.start()
}
```

Stop mock server when app is send to the background mode:
```swift
mockServer?.stop()
```

Restart mock server when the app returns to the active mode:
```swift
mockServer?.start()
```

## Author

lngyeen, lngyeen@openwt.com

## License

SwaggerAutomocker is available under the MIT license. See the LICENSE file for more info.
