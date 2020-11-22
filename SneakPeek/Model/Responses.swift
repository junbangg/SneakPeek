//
//  Responses.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/20.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//

/*
 {
   lowestResellPrice: { stockX: 385, stadiumGoods: 515, flightClub: 403, goat: 403 },
   imageLinks: [],
   _id: 5fb76336afb59504b04181ea,
   shoeName: 'adidas Yeezy Boost 350 V2 Cinder Reflective',
   brand: 'adidas',
   silhoutte: 'adidas Yeezy Boost 350 V2',
   styleID: 'FY4176',
   make: 'adidas Yeezy Boost 350 V2',
   colorway: 'Cinder/Cinder/Cinder',
   retailPrice: 220,
   thumbnail: 'https://stockx.imgix.net/adidas-Yeezy-Boost-350-V2-Cinder-Reflective.png?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&trim=color&q=90&dpr=2&updated_at=1603481985',
   releaseDate: '2020-04-04',
   description: "The Yeezy Boost 350 V2 'Cinder Reflective' emerges with an almost-monochromatic look. Built with Primeknit, the shoe's Cinder upper is bolstered by a bootie-style collar and a heel pull-loop for easy on and off. The signature monofilament stripe sports reflective detailing, while underfoot, an encased Boost midsole gives way to a gum rubber outsole for traction.",
   urlKey: 'adidas-yeezy-boost-350-v2-cinder-reflective',
   resellLinks: {
     stockX: 'https://stockx.com/adidas-yeezy-boost-350-v2-cinder-reflective',
     stadiumGoods: 'https://www.stadiumgoods.com/adidas-yeezy-boost-350-v2-reflective-cinder-fy4176',
     flightClub: 'https://www.flightclub.com/yeezy-boost-350-v2-cinder-reflective-fy4176',
     goat: 'https://www.goat.com/sneakers/yeezy-boost-350-v2-cinder-reflective-fy4176'
   }
 }
 */

import Foundation

struct ShoeDataResponse : Codable {
    
    let productList : [Shoe]
    
    struct Shoe : Codable {
        let lowestResell : LowestResells
        let imageLinks : [String]
        let _id : String
        let shoeName : String
        let brand : String
        let silhoutte : String
        let styleID: String
        let make : String//same thing as silhouette
        let colorway : String
        let retailPrice : Int
        let thumbnail : String
        let releaseDate : String
        let description: String
        let urlKey : String
        let resellLinks : [ResellLinks]
    }
    
    struct LowestResells : Codable {
        let stockX : Int?
        let stadiumGoods : Int?
        let flightClub : Int?
        let goat : Int?
    }
    struct ResellLinks : Codable {
        let stockX: String
        let stadiumGoods : String
        let flightClub : String
        let goat : String
    }
}
