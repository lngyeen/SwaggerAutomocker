//
//  SwaggerParam.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/6/20.
//  Copyright © 2020 Nguyen Truong Luu. All rights reserved.
//

import Foundation
import ObjectMapper

enum SwaggerParamAttribute: String {
    case name
    case position = "in"
    case type
}

class SwaggerParam: Mappable {
    var name: String?
    var position: String?
    var type: String?

    required init?(map: Map) {}
    func mapping(map: Map) {
        name <- map[SwaggerParamAttribute.name.rawValue]
        position <- map[SwaggerParamAttribute.position.rawValue]
        type <- map[SwaggerParamAttribute.type.rawValue]
    }
}
