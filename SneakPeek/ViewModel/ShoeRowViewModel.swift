//
//  ShoeRowViewModel.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/22.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct ShoeRowViewModel : Identifiable {
    var id: String {
        return styleID
    }
    private let shoe : ShoeDataResponse.Shoe
    
    var shoeName: String {
        return shoe.shoeName
    }
    var brand : String {
        return shoe.brand
    }
    var styleID : String {
        return shoe.styleID
    }
    
    var thumbnail : String {
        return shoe.thumbnail
    }
    var retailPrice : Int {
        return shoe.retailPrice
    }
    init(shoe: ShoeDataResponse.Shoe) {
        self.shoe = shoe
    }
    
}
