//
//  SwaggerHeader.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/4/20.
//  Copyright © 2020 Nguyen Truong Luu. All rights reserved.
//

import Foundation
import ObjectMapper

class SwaggerHeader: Mappable {
    var type: String?
    var format: String?
    var defaultValue: String?
    var value: String {
        return defaultValue ?? ""
    }
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        type <- map["type"]
        format <- map["format"]
        defaultValue <- map["default"]
    }
}
