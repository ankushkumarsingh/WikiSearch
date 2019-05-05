//
//  WikiResponseModel.swift
//  iOS Test
//
//  Created by Ankush Kumar Singh on 03/09/17.
//  Copyright © 2017 Castle. All rights reserved.
//

import Foundation
import ObjectMapper

struct WikiResponseModel : Mappable {
    var query : Pages?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        query <- map[QUERY]
    }
}

struct Pages : Mappable {
    var pages = Dictionary<String,Page>()

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        pages <- map[PAGES]
    }

}
