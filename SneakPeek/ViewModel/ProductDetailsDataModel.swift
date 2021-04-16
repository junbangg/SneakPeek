//
//  ProductDetailsViewModel.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/28.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//

import Foundation

/// DataModel for presenting shoe details in Product view
struct ShoeDetailsDataModel {
    
    private let details : ShoeDetailsSearchResponse
    
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
    func getSize(size : Float) -> [Double]{
        let convertedSize : String
        if size.rounded(.up) == size.rounded(.down) {
            //number is int
            convertedSize = String(String(format: "%.1f", size).dropLast(2))
        }else {
            convertedSize = String(format: "%.1f", size)
        }
        let goat : Double = details.resellPrices.goat[convertedSize] ?? 0
        let flightClub : Double = details.resellPrices.flightClub[convertedSize] ?? 0
        let stockX : Double = details.resellPrices.stockX[convertedSize] ?? 0
        let stadiumGoods : Double = details.resellPrices.stadiumGoods[convertedSize] ?? 0
        
        let sizeList : [Double] = [goat, flightClub, stockX, stadiumGoods]
        
//        let sizeList : [String: Double] = ["Goat": goat, "Flight Club": flightClub, "StockX": stockX, "Stadium Goods": stadiumGoods]
        
        return sizeList
    }
    
    init(details : ShoeDetailsSearchResponse) {
        self.details = details
    }
    
}
