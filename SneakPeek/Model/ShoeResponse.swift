//
//  ShoeResponse.swift
//  SneakPeek
//
//  Created by Jun Bang on 2022/01/16.
//  Copyright © 2022 Jun suk Bang. All rights reserved.
//
import Foundation

// MARK: - Welcome
struct ShoeResponse: Codable {
    let count, totalPages: Int
    let results: [Shoe]
}

// MARK: - Result
struct Shoe: Codable, Identifiable {
    let id, sku, brand: String
    let name, colorway: String
    let gender: String
    let silhouette: String
    let releaseYear: String
    let releaseDate: String
    let retailPrice, estimatedMarketValue: Int
    let story: String
    let image: ShoeImages
    let links: Links
}

// MARK: - Image
struct ShoeImages: Codable {
    let the360: [String]
    let original, small, thumbnail: String

    enum CodingKeys: String, CodingKey {
        case the360 = "360"
        case original, small, thumbnail
    }
}

// MARK: - Links
struct Links: Codable {
    let stockX, goat: String
    let flightClub, stadiumGoods: String
}
