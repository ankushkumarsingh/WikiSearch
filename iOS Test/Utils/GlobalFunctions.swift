//
//  GlobalFunctions.swift
//  iOS Test
//
//  Created by Ankush Kumar Singh on 03/09/17.
//  Copyright © 2017 Castle. All rights reserved.
//

import Foundation
import Alamofire

class GlobalFunctions: NSObject {
    class func getGenericHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Accept-Language":"en-GB,en-US",
            "User-Agent":"iOS/" + getApplicationVersion(),
        ]

        return headers
    }

    class func getApplicationVersion() -> String {
        guard let version = Bundle.main.infoDictionary?[VERSION_CONSTANT] as? String
            else {
                return DEFAULT_VERSION
        }
        return version
    }

}
