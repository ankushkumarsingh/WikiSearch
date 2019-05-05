//
//  WikiConstants.swift
//  iOS Test
//
//  Created by Ankush Kumar Singh on 03/09/17.
//  Copyright © 2017 Castle. All rights reserved.
//

import Foundation

let BASE_URL = "https://en.wikipedia.org/w/api.php"

//"https://en.wikipedia.org/w/api.php?format=json&action=query&generator=search&gsrnamespace=0&gsrsearch=apple&gsrlimit=10&prop=pageimages|extracts&pilimit=max&exintro&explaintext&exsentences=1&exlimit=max"
let FIRST_URL_COMPONENT = "?format=json&action=query&generator=search&gsrnamespace=0&gsrsearch="
let SECOND_URL_COMPONENT = "&gsrlimit=10&prop=pageimages|extracts&pilimit=max&exintro&explaintext&exsentences=1&exlimit=max"


let VERSION_CONSTANT = "CFBundleShortVersionString"
let DEFAULT_VERSION = "1.0"

//Mark:- Response Constants
let TITLE = "title"
let THUMBNAIL = "thumbnail"
let EXTRACT = "extract"
let PAGE_IMAGE = "pageimage"

let SOURCE = "source"
let WIDTH = "width"
let HEIGHT = "height"

let QUERY = "query"
let PAGES = "pages"


//Mark:- Loading Image
let PLACEHOLDER_LOADING = "loading"

//Mark:- Constraints
let MINIMUM_HEIGHT  = 75


//Mark: Identifiers
let CELL_IDENTIFIER = "resultCell"
let SEAGUE_IDENTIFIER = "showDetails"

//Mark: SearchBar Constants
let SEARCH_BAR_PADDING = 40
let SEARCH_BAR_HEIGHT = 20
let SEARCH_ROW_HEIGHT = 50
let SEARCH_BAR_X_POSITION = 0
let SEARCH_BAR_Y_POSITION = 0

//Mark:- Placeholders
let PLACEHOLDER_TEXT = "I want to learn about..."



