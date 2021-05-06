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

public class SwaggerParam: Mappable {
    public private(set) var name: String?
    public private(set) var position: String?
    public private(set) var type: String?

    required public init?(map: Map) {}
    public func mapping(map: Map) {
        name <- map[SwaggerParamAttribute.name.rawValue]
        position <- map[SwaggerParamAttribute.position.rawValue]
        type <- map[SwaggerParamAttribute.type.rawValue]
    }
}
