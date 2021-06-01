//
//  DataGenerator.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/3/21.
//

import Fakery
import Foundation

public final class DefaultDataConfigurator {
    // MARK: Default values
    
    public var booleanDefaultValue: Bool = true
    public var floatDefaultValue: Float = 1.23
    public var doubleDefaultValue: Double = 2.34
    public var int32DefaultValue: Int32 = 123
    public var int64DefaultValue: Int64 = 123456789
    public var dateDefaultValue: Any = "2017-07-21"
    public var dateTimeDefaultValue: Any = "2017-07-21T17:32:28Z"
    public var byteDefaultValue: String = "U3dhZ2dlciByb2Nrcw=="
    public var uuidDefaultValue: String = "123e4567-e89b-12d3-a456-426614174000"
    public var othersDefaultValue: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    
    // MARK: Internet
    
    public var passwordDefaultValue: String = "********"
    public var emailDefaultValue: String = "firstname@domain.com"
    public var uriDefaultValue: String = "https://www.example.com/foo.html"
    public var uriPathDefaultValue: String = "/foo/bar/123"
    public var hostnameDefaultValue: String = "www.example.com"
    public var domainnameDefaultValue: String = "example.com"
    public var ipv4DefaultValue: String = "192.0.2.235"
    public var ipv6DefaultValue: String = "2001:0db8:85a3:0000:0000:8a2e:0370:7334"
    
    // MARK: Address
    
    public var cityDefaultValue: String = "Oslo"
    public var streetNameDefaultValue: String = "North Avenue"
    public var secondaryAddressDefaultValue: String = "Apt. 123"
    public var streetAddressDefaultValue: String = "12 North Avenue"
    public var buildingNumberDefaultValue: String = "123"
    public var postCodeDefaultValue: String = "0884"
    public var timeZoneDefaultValue: String = "America/Los_Angeles"
    public var streetSuffixDefaultValue: String = "Avenue"
    public var citySuffixDefaultValue: String = "town"
    public var cityPrefixDefaultValue: String = "North"
    public var stateAbbreviationDefaultValue: String = "CA"
    public var stateDefaultValue: String = "California"
    public var countyDefaultValue: String = "Autauga County"
    public var countryDefaultValue: String = "United States of America"
    public var countryCodeDefaultValue: String = "US"
    public var latitudeDefaultValue: Double = -58.17256227443719
    public var longitudeDefaultValue: Double = -156.65548382095133
    public var coordinateDefaultValue: String = "(-58.17256227443719, -156.65548382095133)"
    public var phoneNumberDefaultValue: String = "1-333-333-3333"
    
    // MARK: App
    
    public var appNameDefaultValue: String = "Namfix"
    public var appVersionDefaultValue: String = "0.1.1"
    public var appAuthorDefaultValue: String = "Ida Adams"
    
    // MARK: Business
    
    public var creditCardNumberDefaultValue: String = "1234-2121-1221-1211"
    public var creditCardTypeDefaultValue: String = "visa"
    public lazy var creditCardExpiryDateDefaultValue: Date = {
        let isoDate = "2025-01-01"
        let dateFormatter = DateFormatter(withFormat: "yyyy-mm-dd", locale: "en_US_POSIX")
        let year2025 = dateFormatter.date(from: isoDate)!
        return year2025
    }()
    
    // MARK: Person
    
    public var nameDefaultValue: String = "Ida Adams"
    public var firstNameDefaultValue: String = "Ida"
    public var lastNameDefaultValue: String = "Adams"
    public var prefixDefaultValue: String = "Mrs."
    public var suffixDefaultValue: String = "PhD"
    public var titleDefaultValue: String = "Lead"
}

public final class FakeryDataConfigurator {
    public enum TextStyle {
        case words(amount: Int)
        case characters(amount: Int)
        case sentence(wordsAmount: Int)
        case sentences(amount: Int)
        case paragraph(sentencesAmount: Int)
        case paragraphs(amount: Int)
    }
    
    public var minInt: Int = 0
    public var maxInt: Int = 1000000000
    public var minFloat: Float = 0
    public var maxFloat: Float = 100000
    public var minDouble: Double = 0
    public var maxDouble: Double = 100000
    public var minDate = Date(timeIntervalSince1970: 0)
    public var maxDate = Date()
    public var passwordMinLength: Int = 8
    public var passwordMaxLength: Int = 16
    public var textStyle: TextStyle = .words(amount: 10)
}

public final class DataGenerator {
    /// If this variable is set to true, the data generator will use the Fakery library to generate dummy data. If false, generator will use default values
    public var useFakeryDataGenerator: Bool = false
    
    /// Only available when useFakeryDataGenerator is true. Fakery Data Generator will generate different objects in the array
    public var distinctElementsInArray: Bool = false
    
    /// The data will be generated lazily each time the server receives the request, meaning that for the same endpoint, the data will be different over time.
    public var generateDummyDataLazily: Bool = false
    
    /// Number of elements in the root response array
    public var rootArrayElementCount: Int = 3
    
    /// Number of elements in the child response array
    public var childArrayElementCount: Int = 3
    
    public let defaultDataConfigurator = DefaultDataConfigurator()
    
    public let fakeryDataConfigurator = FakeryDataConfigurator()
    
    public init() {}
    
    private lazy var faker = Faker()
    
    /// generate dummy value formats
    /// - Parameters:
    ///   - format: Data format
    ///   Support common formats:
    ///
    ///   COMMON
    ///   "float", "double", "int32", "int64", "date", "dateTime", "datetime", "byte", "base64", "uuid":
    ///
    ///   INTERNET
    ///   "password", "email", "uri", "url", "uriPath", "uripath", "hostName", "hostname", "domainName", "domainname", "ipv4", "ipv6":
    ///
    ///   ADDRESS
    ///   "city", "streetName", "streetname", "secondaryAddress", "secondaryaddress", "streetAddress", "streetaddress", "buildingNumber", "buildingnumber", "postCode", "postcode", "timeZone", "timezone", "streetSuffix", "streetsuffix", "citySuffix", "citysuffix", "cityPrefix", "cityprefix", "stateAbbreviation", "stateabbreviation", "state", "county", "country", "countryCode", "countrycode", "latitude", "longitude", "coordinate", "phone", "phoneNumber", "phonenumber":
    ///
    ///   APP
    ///   "appName", "appname", "appVersion", "appversion", "appAuthor", "appauthor":
    ///
    ///   BUSINESS
    ///   "creditCardNumber", "creditcardnumber", "creditCardType", "creditcardtype", "creditCardExpiryDate", "creditcardexpirydate":
    ///
    ///   PERSON
    ///   "name", "fullname", "fullName", "firstName", "firstname", "lastName", "lastname", "prefix", "suffix", "title":
    ///
    ///   - schema: schema object
    /// - Returns: Dummy value as Any
    func generateValueFor(format: String, schema: [String: Any]) -> Any {
        if useFakeryDataGenerator {
            return fakeryValueFor(format: format, schema: schema)
        } else {
            switch format {
            case "float": return defaultDataConfigurator.floatDefaultValue
            case "double": return defaultDataConfigurator.doubleDefaultValue
            case "int32": return defaultDataConfigurator.int32DefaultValue
            case "int64": return defaultDataConfigurator.int64DefaultValue
            case "date": return defaultDataConfigurator.dateDefaultValue
            case "dateTime", "datetime": return defaultDataConfigurator.dateTimeDefaultValue
            case "byte", "base64": return defaultDataConfigurator.byteDefaultValue
            case "uuid": return defaultDataConfigurator.uuidDefaultValue
                
            // MARK: Internet
            
            case "password": return defaultDataConfigurator.passwordDefaultValue
            case "email": return defaultDataConfigurator.emailDefaultValue
            case "uri", "url": return defaultDataConfigurator.uriDefaultValue
            case "uriPath", "uripath": return defaultDataConfigurator.uriPathDefaultValue
            case "hostName", "hostname": return defaultDataConfigurator.hostnameDefaultValue
            case "domainName", "domainname": return defaultDataConfigurator.domainnameDefaultValue
            case "ipv4": return defaultDataConfigurator.ipv4DefaultValue
            case "ipv6": return defaultDataConfigurator.ipv6DefaultValue
            
            // MARK: Address
            
            case "city": return defaultDataConfigurator.cityDefaultValue
            case "streetName", "streetname": return defaultDataConfigurator.streetNameDefaultValue
            case "secondaryAddress", "secondaryaddress": return defaultDataConfigurator.secondaryAddressDefaultValue
            case "streetAddress", "streetaddress": return defaultDataConfigurator.streetNameDefaultValue
            case "buildingNumber", "buildingnumber": return defaultDataConfigurator.buildingNumberDefaultValue
            case "postCode", "postcode": return defaultDataConfigurator.postCodeDefaultValue
            case "timeZone", "timezone": return defaultDataConfigurator.timeZoneDefaultValue
            case "streetSuffix", "streetsuffix": return defaultDataConfigurator.streetSuffixDefaultValue
            case "citySuffix", "citysuffix": return defaultDataConfigurator.citySuffixDefaultValue
            case "cityPrefix", "cityprefix": return defaultDataConfigurator.cityPrefixDefaultValue
            case "stateAbbreviation", "stateabbreviation": return defaultDataConfigurator.stateAbbreviationDefaultValue
            case "state": return defaultDataConfigurator.stateDefaultValue
            case "county": return defaultDataConfigurator.countyDefaultValue
            case "country": return defaultDataConfigurator.countryDefaultValue
            case "countryCode", "countrycode": return defaultDataConfigurator.countryCodeDefaultValue
            case "latitude": return defaultDataConfigurator.latitudeDefaultValue
            case "longitude": return defaultDataConfigurator.longitudeDefaultValue
            case "coordinate": return defaultDataConfigurator.coordinateDefaultValue
            case "phone", "phoneNumber", "phonenumber": return defaultDataConfigurator.phoneNumberDefaultValue
            
            // MARK: App
            
            case "appName", "appname": return defaultDataConfigurator.appNameDefaultValue
            case "appVersion", "appversion": return defaultDataConfigurator.appVersionDefaultValue
            case "appAuthor", "appauthor": return defaultDataConfigurator.appAuthorDefaultValue
            
            // MARK: Business
            
            case "creditCardNumber", "creditcardnumber": return defaultDataConfigurator.creditCardNumberDefaultValue
            case "creditCardType", "creditcardtype": return defaultDataConfigurator.creditCardTypeDefaultValue
            case "creditCardExpiryDate", "creditcardexpirydate": return defaultDataConfigurator.creditCardExpiryDateDefaultValue
            
            // MARK: Person
            
            case "name", "fullname", "fullName": return defaultDataConfigurator.nameDefaultValue
            case "firstName", "firstname": return defaultDataConfigurator.firstNameDefaultValue
            case "lastName", "lastname": return defaultDataConfigurator.lastNameDefaultValue
            case "prefix": return defaultDataConfigurator.prefixDefaultValue
            case "suffix": return defaultDataConfigurator.suffixDefaultValue
            case "title": return defaultDataConfigurator.titleDefaultValue
            
            default: return defaultDataConfigurator.othersDefaultValue
            }
        }
    }
    
    private func fakeryValueFor(format: String, schema: [String: Any]) -> Any {
        var dateFormatter: DateFormatter { DateFormatter(withFormat: "yyyy-MM-dd", locale: "en_US_POSIX") }
        var dateTimeFormatter: DateFormatter { DateFormatter(withFormat: "yyyy-MM-dd'T'HH:mm:ssZZZZZ", locale: "en_US_POSIX") }
        
        switch format {
        // MARK: Primitive
        
        case "float":
            let minimum = schema[SwaggerSchemaAttribute.minimum] as? Float
            let maximum = schema[SwaggerSchemaAttribute.maximum] as? Float
            
            return faker.number.randomFloat(min: minimum ?? fakeryDataConfigurator.minFloat, max: maximum ?? fakeryDataConfigurator.maxFloat)
            
        case "double":
            let minimum = schema[SwaggerSchemaAttribute.minimum] as? Double
            let maximum = schema[SwaggerSchemaAttribute.maximum] as? Double
            
            return faker.number.randomDouble(min: minimum ?? fakeryDataConfigurator.minDouble, max: maximum ?? fakeryDataConfigurator.maxDouble)
            
        case "int32", "int64":
            let minimum = schema[SwaggerSchemaAttribute.minimum] as? Int
            let maximum = schema[SwaggerSchemaAttribute.maximum] as? Int
            let exclusiveMinimum = schema[SwaggerSchemaAttribute.exclusiveMinimum] as? Bool ?? false
            let exclusiveMaximum = schema[SwaggerSchemaAttribute.exclusiveMaximum] as? Bool ?? false
            
            return faker.number.randomInt(min: (minimum ?? fakeryDataConfigurator.minInt) + (exclusiveMinimum ? 1 : 0),
                                          max: (maximum ?? fakeryDataConfigurator.maxInt) - (exclusiveMaximum ? 0 : 1))
            
        case "date":
            return dateFormatter.string(from: faker.date.between(fakeryDataConfigurator.minDate, fakeryDataConfigurator.maxDate))
            
        case "dateTime", "datetime":
            return dateTimeFormatter.string(from: faker.date.between(fakeryDataConfigurator.minDate, fakeryDataConfigurator.maxDate))
            
        case "byte", "base64":
            func uiImage(from color: UIColor?, size: CGSize) -> UIImage? {
                UIGraphicsBeginImageContextWithOptions(size, true, 0)
                defer {
                    UIGraphicsEndImageContext()
                }
                let context = UIGraphicsGetCurrentContext()
                color?.setFill()
                context?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
                return UIGraphicsGetImageFromCurrentImageContext()
            }
            
            return uiImage(from: .black, size: CGSize(width: 100, height: 100))?.pngData()?.base64EncodedString() as Any
            
        case "uuid":
            return UUID().uuidString
            
        // MARK: Internet
        
        case "password":
            return faker.internet.password(minimumLength: fakeryDataConfigurator.passwordMinLength, maximumLength: fakeryDataConfigurator.passwordMaxLength)
            
        case "email":
            return faker.internet.email()
            
        case "uri", "url":
            return faker.internet.url()
            
        case "uriPath", "uripath":
            return faker.internet.username()
            
        case "hostName", "hostname", "domainName", "domainname":
            return faker.internet.domainName()
            
        case "ipv4":
            return faker.internet.ipV4Address()
            
        case "ipv6":
            return faker.internet.ipV6Address()
            
        // MARK: Address
        
        case "city":
            return faker.address.city() // => "Oslo"
        
        case "streetName", "streetname":
            return faker.address.streetName() // => "North Avenue"
        
        case "secondaryAddress", "secondaryaddress":
            return faker.address.secondaryAddress() // => "Apt. 123"
        
        case "streetAddress", "streetaddress":
            return faker.address.streetAddress() // => "12 North Avenue"
        
        case "buildingNumber", "buildingnumber":
            return faker.address.buildingNumber() // => "123"
        
        case "postCode", "postcode":
            return faker.address.postcode() // => "0884"
        
        case "timeZone", "timezone":
            return faker.address.timeZone() // => "America/Los_Angeles"
        
        case "streetSuffix", "streetsuffix":
            return faker.address.streetSuffix() // => "Avenue"
        
        case "citySuffix", "citysuffix":
            return faker.address.citySuffix() // => "town"
        
        case "cityPrefix", "cityprefix":
            return faker.address.cityPrefix() // => "North"
        
        case "stateAbbreviation", "stateabbreviation":
            return faker.address.stateAbbreviation() // => "CA"
        
        case "state":
            return faker.address.state() // => "California"
        
        case "county":
            return faker.address.county() // => "Autauga County"
        
        case "country":
            return faker.address.country() // => "United States of America"
        
        case "countryCode", "countrycode":
            return faker.address.countryCode() // => "US"
        
        case "latitude":
            return faker.address.latitude() // => -58.17256227443719
        
        case "longitude":
            return faker.address.longitude() // => -156.65548382095133
        
        case "coordinate":
            return String(format: "(%@, %@)",
                          faker.address.latitude(),
                          faker.address.longitude()) // => (-58.17256227443719, -156.65548382095133)
        
        case "phone", "phoneNumber", "phonenumber":
            return faker.phoneNumber.cellPhone() // => "1-333-333-3333"
        
        // MARK: App
        
        case "appName", "appname":
            return faker.app.name() // => "Namfix"
        
        case "appVersion", "appversion":
            return faker.app.version() // => "0.1.1"
        
        case "appAuthor", "appauthor":
            return faker.app.author() // => "Ida Adams"
        
        // MARK: Business
        
        case "creditCardNumber", "creditcardnumber":
            return faker.business.creditCardNumber() // => "1234-2121-1221-1211"
        
        case "creditCardType", "creditcardtype":
            return faker.business.creditCardType() // => "visa"
        
        case "creditCardExpiryDate", "creditcardexpirydate":
            return dateFormatter.string(from: faker.business.creditCardExpiryDate() ?? Date().dateByAddingYears(5)) // => "2020-10-12"
        
        // MARK: Person
        
        case "name", "fullname", "fullName":
            return faker.name.name() // => "Ida Adams"
        
        case "firstName", "firstname":
            return faker.name.firstName() // => "Ida"
        
        case "lastName", "lastname":
            return faker.name.lastName() // => "Adams"
        
        case "prefix":
            return faker.name.prefix() // => "Mrs."
        
        case "suffix":
            return faker.name.suffix() // => "PhD"
        
        case "title":
            return faker.name.title() // => "Lead"
        
        default:
            switch fakeryDataConfigurator.textStyle {
            case .words(let amount):
                return faker.lorem.words(amount: amount)
                
            case .characters(let amount):
                return faker.lorem.characters(amount: amount)
                
            case .sentence(let wordsAmount):
                return faker.lorem.sentence(wordsAmount: wordsAmount)
                
            case .sentences(let amount):
                return faker.lorem.sentences(amount: amount)
                
            case .paragraph(let sentencesAmount):
                return faker.lorem.paragraph(sentencesAmount: sentencesAmount)
                
            case .paragraphs(let amount):
                return faker.lorem.paragraphs(amount: amount)
            }
        }
    }
}

extension Date {
    func dateByAddingYears(_ years: Int) -> Date {
        return Calendar.current.date(byAdding: .year, value: years, to: self)!
    }
    
    func dateBySubtractingYears(_ years: Int) -> Date {
        return Calendar.current.date(byAdding: .year, value: years * -1, to: self)!
    }
}
