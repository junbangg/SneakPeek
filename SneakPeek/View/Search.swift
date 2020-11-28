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
    @State private var inputSwitch : Bool = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    if self.inputSwitch == false {
                        logo
                            .padding(.top, 50)
                            .padding(.horizontal, 50)
                        searchButton
                        searchEmpty
                    } else {
                        searchField
                        List {
                            if viewModel.datasource.isEmpty {
                                emptySection
                            }
                            results
                        }
                        .listStyle(GroupedListStyle())
                    }
                    Spacer()
                }
                .navigationBarTitle("SneakPeek")
                .navigationBarHidden(true)
            }
            //            .background(MyColors.cactusJack)
            
        }
        
    }
}

private extension Search {
    var logo : some View {
        Image("Chicago")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300)
            .padding(.top,30)
    }
    var searchButton : some View {
        Button(action: {
            self.inputSwitch = true
        }) {
            HStack {
                
                Text("Jordan Chicago")
                Spacer()
                Spacer()
            }            .padding()
                .foregroundColor(.gray)
                .background(MyColors.lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .padding(40)
        }.buttonStyle(PlainButtonStyle())
    }
    var searchField : some View {
        TextField("Jordan Chicago", text: $viewModel.shoe)
            .padding()
            .background(MyColors.lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
            .padding()
    }
    
    var results : some View {
        Section {
            ForEach(viewModel.datasource, content: SearchResult.init(viewModel:))
        }
    }
    var searchEmpty : some View {
        Section {
            Text("Search prices for your favorite shoe!")
                .foregroundColor(.gray)
        }
    }
    var emptySection: some View {
        Section {
            Text("No Results")
                .foregroundColor(.gray)
        }
        
    }
    
}
