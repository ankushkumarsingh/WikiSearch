//
//  WikiSearchService.swift
//  iOS Test
//
//  Created by Ankush Kumar Singh on 03/09/17.
//  Copyright © 2017 Castle. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

protocol WikiResponseDelegate : class {
    func search(sender: WikiSearchService ,searchResults response: WikiResponseModel?)
}
class WikiSearchService: NSObject {

    weak var delegate : WikiResponseDelegate?

    func getSearchResults(searchText: String) {
        guard let url = getUrl(search: searchText) else {
            self.delegate?.search(sender: self, searchResults: nil)
            return
        }

        let headers = GlobalFunctions.getGenericHeaders()
        Alamofire.request(url,method: .get, headers: headers).responseObject{(response: DataResponse <WikiResponseModel>) in
            let responseModel = response.result.value

            if responseModel != nil {
                self.delegate?.search(sender: self, searchResults: responseModel)
            } else  {
                self.delegate?.search(sender: self, searchResults: nil)
            }
        }
    }

    func getUrl(search:String) -> String? {

        if search == "" {
            return nil
        }
        guard let searchEncoded = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return nil
        }

        guard let secondUrlEncoded = SECOND_URL_COMPONENT.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return nil
        }
        return BASE_URL+FIRST_URL_COMPONENT+searchEncoded+secondUrlEncoded
    }
}

