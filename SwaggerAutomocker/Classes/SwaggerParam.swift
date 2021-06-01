//
//  SwaggerParam.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/6/20.
//  Copyright © 2020 Nguyen Truong Luu. All rights reserved.
//

import Foundation
import ObjectMapper

enum SwaggerParamAttribute {
    static var name: String { "name" }
    static var `in`: String { "in" }
    static var type: String { "type" }
}

public class SwaggerParam: Mappable {
    public private(set) var name: String?
    public private(set) var position: String?
    public private(set) var type: String?

    public required init?(map: Map) {}
    public func mapping(map: Map) {
        name <- map[SwaggerParamAttribute.name]
        position <- map[SwaggerParamAttribute.in]
        type <- map[SwaggerParamAttribute.type]
    }
}
