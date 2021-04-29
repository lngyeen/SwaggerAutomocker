//
//  SwaggerHeader.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/4/20.
//  Copyright © 2020 Nguyen Truong Luu. All rights reserved.
//

import Foundation
import ObjectMapper

enum SwaggerHeaderAttribute: String {
    case type
    case format
    case defaultValue = "default"
}

class SwaggerHeader: Mappable {
    var type: String?
    var format: String?
    var defaultValue: String?
    var value: String {
        return defaultValue ?? ""
    }

    required init?(map: Map) {}
    func mapping(map: Map) {
        type <- map[SwaggerHeaderAttribute.type.rawValue]
        format <- map[SwaggerHeaderAttribute.format.rawValue]
        defaultValue <- map[SwaggerHeaderAttribute.defaultValue.rawValue]
    }
}
