//
//  Page.swift
//  iOS Test
//
//  Created by Ankush Kumar Singh on 03/09/17.
//  Copyright © 2017 Castle. All rights reserved.
//

import Foundation
import ObjectMapper

struct Page : Mappable {
    var title = ""
    var thumbnail : Thumbnail?
    var extract = ""
    var pageImage = ""


    init?(map: Map) {
    }

    init() {
    }

    mutating func mapping(map: Map) {
        title <- map[TITLE]
        thumbnail <- map[THUMBNAIL]
        extract <- map[EXTRACT]
        pageImage <- map[PAGE_IMAGE]
    }
}

struct Thumbnail : Mappable {
    var source = ""
    var width = 0
    var height = 0

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        source <- map[SOURCE]
        width <- map[WIDTH]
        height <- map[HEIGHT]
    }
}

//struct PageArray {
//    let pageArray = [Page]()
//}
