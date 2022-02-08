//
//  SearchResult.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/23.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//

import SwiftUI
/**
 View for presenting each search result
 */
struct SearchResult: View {
    //MARK: - Properties
    
    private let viewModel : ShoeDataModel
    private let shoeID : String
    
    // MARK: - Initializer
    
    init(viewModel: ShoeDataModel, shoeID : String) {
        self.viewModel = viewModel
        self.shoeID = viewModel.styleID
    }
    
    //MARK: - View body
    
    var body: some View {
            HStack {
                //Thumbnail
                Thumbnail(url: viewModel.thumbnail)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80)
                    .padding(.trailing)
                Text("\(viewModel.shoeName)")
                    .font(.footnote)
            }
        .padding()
    }
}
