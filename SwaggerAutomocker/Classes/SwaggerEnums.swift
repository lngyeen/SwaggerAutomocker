//
//  SwaggerEnums.swift
//  SwaggerAutomocker
//
//  Created by Nguyen Truong Luu on 5/1/21.
//  Copyright © 2020 Nguyen Truong Luu. All rights reserved.
//

import Foundation

enum SwaggerSchemaDataType: String {
    case string, integer, number, boolean, array, object
}

/// Format is an open value, so you can use any formats, even not those defined by the OpenAPI Specification
enum SwaggerSchemaFormatType: String, CaseIterable {
    case float, double
    case int32, int64
    case date, dateTime, password, byte
    case email, uuid, uri, hostname, ipv4, ipv6
    case others
}

enum SwaggerSchemaResponse {
    case string(content: String)
    case integer(content: Int)
    case number(content: Double)
    case boolean(content: Bool)
    case object(content: [String: Any])
    case array(content: [Any])
    case none
}
