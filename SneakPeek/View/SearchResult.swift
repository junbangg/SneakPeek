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
            //Thumbnail
            Thumbnail(url: viewModel.thumbnail)
                .aspectRatio(contentMode: .fit)
                .frame(width: 80)
                .padding(.trailing)
            Text("\(viewModel.shoeName)")
                .font(.footnote)
//            Spacer()
//            Text("Check Price!")
//                .font(.body)
//                .fontWeight(.light)
//                .foregroundColor(MyColors.ferrariRed)
//            Text("\(viewModel.retailPrice)")
        }
    .padding()
    }
}