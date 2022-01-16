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
    private let viewModel: Shoe
    private let shoeID: String
    
    init(viewModel: Shoe, shoeID : String) {
        self.viewModel = viewModel
        self.shoeID = viewModel.id
    }
    //MARK: - View body
    var body: some View {
            HStack {
                //Thumbnail
                Thumbnail(url: viewModel.image.thumbnail)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80)
                    .padding(.trailing)
                Text("\(viewModel.name)")
                    .font(.footnote)
            }
        .padding()
    }
}
