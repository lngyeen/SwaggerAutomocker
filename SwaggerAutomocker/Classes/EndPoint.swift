//
//  EndPoint.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/5/20.
//  Copyright © 2020 Nguyen Truong Luu. All rights reserved.
//

import Foundation
import Telegraph

class EndPoint {
    var method: HTTPMethod
    var path: String
    var route: String
    var contentType: String?
    var statusCode: Int
    var headers: [String: String]
    var params: [SwaggerParam]?
    var responseData: String?
    var hasPathParameters: Bool {
        return path != route
    }
    
    init(method: String,
         path: String,
         contentType: String?,
         statusCode: Int,
         headers: [String: String],
         params: [SwaggerParam]?,
         responseData: String?) {
        self.method = HTTPMethod(stringLiteral: method)
        self.path = path
        
        var route = path
        if let params = params {
            let pathParams = params.filter({$0.position == "path"})
            for pathParam in pathParams {
                switch pathParam.type {
                case "integer":
                    route = route.removingRegexMatches(pattern: "\\{\(pathParam.name ?? ".*")\\}", replaceWith: "[-+]?[0-9]+")
                case "number":
                    route = route.removingRegexMatches(pattern: "\\{\(pathParam.name ?? ".*")\\}", replaceWith: "[-+]?[0-9]+(?:[.,][0-9]+)*")
                default:
                    route = route.removingRegexMatches(pattern: "\\{\(pathParam.name ?? ".*")\\}", replaceWith: "[^/]*")
                }
            }
        }
        
        self.route = route
        self.contentType = contentType
        self.statusCode = statusCode
        self.headers = headers
        self.params = params
        self.responseData = responseData
    }
}

private extension String {
    func removingRegexMatches(pattern: String, replaceWith: String = "") -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let range = NSMakeRange(0, self.count)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceWith)
        } catch {
            return self
        }
    }
}
