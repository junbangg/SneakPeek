//
//  Search.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/22.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//

import SwiftUI

struct Search: View {
    @ObservedObject var viewModel : SearchViewModel
    
    init(viewModel : SearchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        NavigationView {
            List {
                searchField
                results
                //                if viewModel.dataSource.isEmpty {
                //                    emptySection
                //                } else {
                //                    results
                //                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("SneakPeek")
        }
        
        
        
        
        
    }
}

private extension Search {
    var searchField : some View {
        TextField("Jordan 1 Chicago", text: $viewModel.shoe)
            .padding()
            .background(MyColors.lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
            .padding()
        //            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
        //            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
    }
    
    var results : some View {
        Section {
            ForEach(viewModel.datasource, content: SearchResult.init(viewModel:))
        }
    }
    var emptySection: some View {
        Section {
            Text("No results")
                .foregroundColor(.gray)
        }
        
    }
    
    //struct Search_Previews: PreviewProvider {
    //    static var previews: some View {
    //        Search()
    //    }
    //}
}
