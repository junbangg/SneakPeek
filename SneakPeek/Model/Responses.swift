//
//  Responses.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/20.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//

import Foundation

// MARK: - ResponseElement

struct ShoeDataResponse: Codable {
    let lowestResellPrice: LowestResellPrice?
    let imageLinks: [String]
    let id, shoeName, brand, silhoutte: String
    let styleID, make, colorway: String
    let retailPrice: Int?
    let thumbnail: String
    let releaseDate, responseDescription, urlKey: String
    let resellLinks: ResellLinks
    
    enum CodingKeys: String, CodingKey {
        case lowestResellPrice, imageLinks
        case id = "_id"
        case shoeName, brand, silhoutte, styleID, make, colorway, retailPrice, thumbnail, releaseDate
        case responseDescription = "description"
        case urlKey, resellLinks
    }
}
// MARK: - PriceDataResponse
struct PriceDataResponse: Codable {
    let lowestResellPrice: LowestResellPrice
    let resellPrices: ResellPrices
    let imageLinks: [String]
    let id, shoeName, brand, silhoutte: String
    let styleID, make, colorway: String
    let retailPrice: Int
    let thumbnail: String
    let releaseDate, description, urlKey: String
    let resellLinks: ResellLinks

    enum CodingKeys: String, CodingKey {
        case lowestResellPrice, resellPrices, imageLinks
        case id = "_id"
        case shoeName, brand, silhoutte, styleID, make, colorway, retailPrice, thumbnail, releaseDate, description
        case urlKey, resellLinks
    }
}

// MARK: - LowestResellPrice
struct LowestResellPrice: Codable {
    let stockX : Int?
    let flightClub : Int?
    let goat : Int?
    let stadiumGoods : Int?
}

// MARK: - ResellLinks
struct ResellLinks: Codable {
    let stockX : String?
    let flightClub : String?
    let goat : String?
    let stadiumGoods : String?
    
}
// MARK: - ResellPrices
struct ResellPrices: Codable {
    let goat, flightClub, stockX, stadiumGoods: [String: Double]
}


