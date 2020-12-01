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
        return details.description
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
    func getSize(size : String) -> [Double]{
        let goat : Double = details.resellPrices.goat[size] ?? 0
        let flightClub : Double = details.resellPrices.flightClub[size] ?? 0
        let stockX : Double = details.resellPrices.stockX[size] ?? 0
        let stadiumGoods : Double = details.resellPrices.stadiumGoods[size] ?? 0
        
        let sizeList : [Double] = [goat, flightClub, stockX, stadiumGoods]
        
        return sizeList
    }
    
    init(details : PriceDataResponse) {
        self.details = details
    }
    
}
