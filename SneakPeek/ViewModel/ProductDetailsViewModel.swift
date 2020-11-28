//
//  ProductDetailsViewModel.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/28.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//

import Foundation
import Combine

struct ProductDetailsViewModel{
    
    private let details : PriceDataResponse
    
    var shoeName : String {
        return details.shoeName
    }
    var brand : String {
        return details.brand
    }
    var description : String {
        return details.responseDescription
    }
    var retailPrice : Int {
        return details.retailPrice
    }
    var releaseDate : String {
        return details.releaseDate
    }
    var thumbnail : String {
        return details.thumbnail
    }
    
    init(details : PriceDataResponse) {
        self.details = details
    }
    
}
