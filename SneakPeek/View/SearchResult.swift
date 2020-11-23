//
//  SearchResult.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/23.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//

import SwiftUI

struct SearchResult: View {
    private let viewModel : SearchResultViewModel
    
    init(viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        HStack {
            Text("\(viewModel.shoeName)")
            Spacer()
            Text("\(viewModel.brand)")
            Spacer()
            Text("\(viewModel.retailPrice)")
        }
    }
}
