//
//  DataGenerator.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/3/21.
//

import Fakery
import Foundation

public class DataGenerator {
    /// If this variable is set to true, the data generator will use the Fakery library to generate dummy data. If false, generator will use default values
    public var useFakeryDataGenerator = false
    
    // MARK: Default values

    public var defaultArrayElementCount: Int = 3
    public var booleanDefaultValue = true
    public var floatDefaultValue = 1.23
    public var doubleDefaultValue = 2.34
    public var int32DefaultValue = 123
    public var int64DefaultValue = 123456789
    public var dateDefaultValue = "2017-07-21"
    public var dateTimeDefaultValue = "2017-07-21T17:32:28Z"
    public var byteDefaultValue = "U3dhZ2dlciByb2Nrcw=="
    public var uuidDefaultValue = "123e4567-e89b-12d3-a456-426614174000"
    public var othersDefaultValue = "string value"
    
    // MARK: Internet
    
    public var passwordDefaultValue = "********"
    public var emailDefaultValue = "firstname@domain.com"
    public var uriDefaultValue = "https://www.example.com/foo.html"
    public var uriPathDefaultValue = "/foo/bar/123"
    public var hostnameDefaultValue = "www.example.com"
    public var domainnameDefaultValue = "example.com"
    public var ipv4DefaultValue = "192.0.2.235"
    public var ipv6DefaultValue = "2001:0db8:85a3:0000:0000:8a2e:0370:7334"
    
    // MARK: Address
    
    public var cityDefaultValue = "Oslo"
    public var streetNameDefaultValue = "North Avenue"
    public var secondaryAddressDefaultValue = "Apt. 123"
    public var streetAddressDefaultValue = "12 North Avenue"
    public var buildingNumberDefaultValue = "123"
    public var postCodeDefaultValue = "0884"
    public var timeZoneDefaultValue = "America/Los_Angeles"
    public var streetSuffixDefaultValue = "Avenue"
    public var citySuffixDefaultValue = "town"
    public var cityPrefixDefaultValue = "North"
    public var stateAbbreviationDefaultValue = "CA"
    public var stateDefaultValue = "California"
    public var countyDefaultValue = "Autauga County"
    public var countryDefaultValue = "United States of America"
    public var countryCodeDefaultValue = "US"
    public var latitudeDefaultValue = -58.17256227443719
    public var longitudeDefaultValue = -156.65548382095133
    public var coordinateDefaultValue = "(-58.17256227443719, -156.65548382095133)"
    public var phoneNumberDefaultValue = "1-333-333-3333"
    
    // MARK: App
    
    public var appNameDefaultValue = "Namfix"
    public var appVersionDefaultValue = "0.1.1"
    public var appAuthorDefaultValue = "Ida Adams"
    
    // MARK: Business
    
    public var creditCardNumberDefaultValue = "1234-2121-1221-1211"
    public var creditCardTypeDefaultValue = "visa"
    public var creditCardExpiryDateDefaultValue: Date = {
        let isoDate = "2025-01-01T00:00:00+0000"
        let dateFormatter = DateFormatter(withFormat: "yyyy-MM-dd'T'HH:mm:ssZZZZZ", locale: "en_US_POSIX")
        let year2025 = dateFormatter.date(from: isoDate)!
        return year2025
    }()
    
    // MARK: Person
    
    public var nameDefaultValue = "Ida Adams"
    public var firstNameDefaultValue = "Ida"
    public var lastNameDefaultValue = "Adams"
    public var prefixDefaultValue = "Mrs."
    public var suffixDefaultValue = "PhD"
    public var titleDefaultValue = "Lead"
    
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
    ///   "city", "streetName", "streetname", "secondaryAddress", "secondaryaddress", "streetAddress", "streetaddress", "buildingNumber", "buildingnumber", "postCode", "postcode", "timeZone", "timezone", "streetSuffix", "streetsuffix", "citySuffix", "citysuffix", "cityPrefix", "cityprefix", "stateAbbreviation", "stateabbreviation", "state", "county", "country", "countryCode", "countrycode", "latitude", "longitude", "coordinate", "phoneNumber", "phonenumber":
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
            case "float": return floatDefaultValue
            case "double": return doubleDefaultValue
            case "int32": return int32DefaultValue
            case "int64": return int64DefaultValue
            case "date": return dateDefaultValue
            case "dateTime", "datetime": return dateTimeDefaultValue
            case "byte", "base64": return byteDefaultValue
            case "uuid": return uuidDefaultValue
                
            // MARK: Internet
            
            case "password": return passwordDefaultValue
            case "email": return emailDefaultValue
            case "uri", "url": return uriDefaultValue
            case "uriPath", "uripath": return uriPathDefaultValue
            case "hostName", "hostname": return hostnameDefaultValue
            case "domainName", "domainname": return domainnameDefaultValue
            case "ipv4": return ipv4DefaultValue
            case "ipv6": return ipv6DefaultValue
            
            // MARK: Address
            
            case "city": return cityDefaultValue
            case "streetName", "streetname": return streetNameDefaultValue
            case "secondaryAddress", "secondaryaddress": return secondaryAddressDefaultValue
            case "streetAddress", "streetaddress": return streetNameDefaultValue
            case "buildingNumber", "buildingnumber": return buildingNumberDefaultValue
            case "postCode", "postcode": return postCodeDefaultValue
            case "timeZone", "timezone": return timeZoneDefaultValue
            case "streetSuffix", "streetsuffix": return streetSuffixDefaultValue
            case "citySuffix", "citysuffix": return citySuffixDefaultValue
            case "cityPrefix", "cityprefix": return cityPrefixDefaultValue
            case "stateAbbreviation", "stateabbreviation": return stateAbbreviationDefaultValue
            case "state": return stateDefaultValue
            case "county": return countyDefaultValue
            case "country": return countryDefaultValue
            case "countryCode", "countrycode": return countryCodeDefaultValue
            case "latitude": return latitudeDefaultValue
            case "longitude": return longitudeDefaultValue
            case "coordinate": return coordinateDefaultValue
            case "phoneNumber", "phonenumber": return phoneNumberDefaultValue
            
            // MARK: App
            
            case "appName", "appname": return appNameDefaultValue
            case "appVersion", "appversion": return appVersionDefaultValue
            case "appAuthor", "appauthor": return appAuthorDefaultValue
            
            // MARK: Business
            
            case "creditCardNumber", "creditcardnumber": return creditCardNumberDefaultValue
            case "creditCardType", "creditcardtype": return creditCardTypeDefaultValue
            case "creditCardExpiryDate", "creditcardexpirydate": return creditCardExpiryDateDefaultValue
            
            // MARK: Person
            
            case "name", "fullname", "fullName": return nameDefaultValue
            case "firstName", "firstname": return firstNameDefaultValue
            case "lastName", "lastname": return lastNameDefaultValue
            case "prefix": return prefixDefaultValue
            case "suffix": return suffixDefaultValue
            case "title": return titleDefaultValue
            
            default: return othersDefaultValue
            }
        }
    }
    
    private func fakeryValueFor(format: String, schema: [String: Any]) -> Any {
        switch format {
        // MARK: Primitive
        
        case "float":
            let minimum = schema[SwaggerSchemaAttribute.minimum.rawValue] as? Float
            let maximum = schema[SwaggerSchemaAttribute.maximum.rawValue] as? Float
            
            return faker.number.randomFloat(min: Float(minimum ?? 0), max: Float(maximum ?? Float.greatestFiniteMagnitude))
            
        case "double":
            let minimum = schema[SwaggerSchemaAttribute.minimum.rawValue] as? Double
            let maximum = schema[SwaggerSchemaAttribute.maximum.rawValue] as? Double
            
            return faker.number.randomDouble(min: minimum ?? 0, max: maximum ?? Double.greatestFiniteMagnitude)
            
        case "int32", "int64":
            let minimum = schema[SwaggerSchemaAttribute.minimum.rawValue] as? Int
            let maximum = schema[SwaggerSchemaAttribute.maximum.rawValue] as? Int
            let exclusiveMinimum = schema[SwaggerSchemaAttribute.exclusiveMinimum.rawValue] as? Bool ?? false
            let exclusiveMaximum = schema[SwaggerSchemaAttribute.exclusiveMaximum.rawValue] as? Bool ?? false
            
            return faker.number.randomInt(min: Int(minimum ?? 0) + (exclusiveMinimum ? 1 : 0),
                                          max: Int(maximum ?? Int.max) - (exclusiveMaximum ? 0 : 1))
            
        case "date":
            let isoDate = "2010-01-01T00:00:00+0000"
            let dateFormatter = DateFormatter(withFormat: "yyyy-MM-dd", locale: "en_US_POSIX")
            let year2010 = dateFormatter.date(from: isoDate)!
            return dateFormatter.string(from: faker.date.between(year2010, Date()))
            
        case "dateTime", "datetime":
            let isoDate = "2010-01-01T00:00:00+0000"
            let dateFormatter = DateFormatter(withFormat: "yyyy-MM-dd'T'HH:mm:ssZZZZZ", locale: "en_US_POSIX")
            let year2010 = dateFormatter.date(from: isoDate)!
            return dateFormatter.string(from: faker.date.between(year2010, Date()))
            
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
            return faker.internet.password(minimumLength: 8, maximumLength: 16)
            
        case "email":
            return faker.internet.email()
            
        case "uri", "url":
            return faker.internet.url()
            
        case "uriPath", "uripath":
            return URL(string: faker.internet.url())?.path ?? faker.internet.url()
            
        case "hostName", "hostname":
            let url = URL(string: faker.internet.url())
            return url?.host as Any
            
        case "domainName", "domainname":
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
        
        case "phoneNumber", "phonenumber":
            return faker.phoneNumber.phoneNumber() // => "1-333-333-3333"
        
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
            let isoDate = "2025-01-01T00:00:00+0000"
            let dateFormatter = DateFormatter(withFormat: "yyyy-MM-dd'T'HH:mm:ssZZZZZ", locale: "en_US_POSIX")
            let year2025 = dateFormatter.date(from: isoDate)!
            return faker.business.creditCardExpiryDate() ?? year2025 // => "2020-10-12"
        
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
            return faker.lorem.paragraph(sentencesAmount: 4)
        }
    }
}
