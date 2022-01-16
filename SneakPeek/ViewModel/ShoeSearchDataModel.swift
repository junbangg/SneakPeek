//
//  ShoeSearchDataModel.swift
//  SneakPeek
//
//  Created by Jun Bang on 2022/01/16.
//  Copyright © 2022 Jun suk Bang. All rights reserved.
//

import Foundation

struct ShoeSearchDataModel {
    
    private let shoe: ShoeResponse
    
    var count: Int {
        return shoe.count
    }
    
    var totalPages: Int {
        return shoe.totalPages
    }
    
    var results: [Shoe] {
        return shoe.results
    }
    
    init(shoe: ShoeResponse) {
        self.shoe = shoe
    }
    
}
