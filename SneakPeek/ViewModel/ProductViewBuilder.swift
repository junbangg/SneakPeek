//
//  ProductViewBuilder.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/28.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//

import Foundation
import SwiftUI

enum ProductViewBuilder {
    static func makeProductDetailView(
        shoeFetcher : APIRequest
    ) -> some View {
        let viewmodel = SearchViewModel(shoeFetcher: shoeFetcher)
        return Product(viewmodel: viewmodel)
    }
}
