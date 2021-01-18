//
//  Search.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/22.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//
// MARK: - TODO! Change the structure of Search/Nonsearch view

import SwiftUI
import SwiftKeychainWrapper

struct Search: View {
    @ObservedObject var viewModel : SearchViewModel
    //    @ObservedObject var productViewModel : ProductViewModel
    
    init(viewModel : SearchViewModel) {
        self.viewModel = viewModel
        //        self.productViewModel = productViewModel
    }
    @State private var inputSwitch : Bool = false
    @State private var shoeID : String = ""
    
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
    //SearchResult.init(viewModel:)
    // Product(viewmodel: self.productViewModel)
    var results : some View {
        Section {
            ForEach(viewModel.datasource) { result in
                NavigationButton(action: {
                    let _ : Bool = KeychainWrapper.standard.set(result.id, forKey: "shoeID")
                    //                    self.shoeID = result.id
                }, destination: {
                    //                    Product(viewmodel: self.productViewModel)
                    self.viewModel.ProductDetails
                }) {
                    SearchResult.init(viewModel: result, shoeID: result.id)
                }
                
            }
        }
    }
    var searchEmpty : some View {
        Section {
            Text("신발의 리셀 가격 한 눈에 확인하세요!")
                .foregroundColor(.gray)
        }
    }
    var emptySection: some View {
        Section {
            Text("검색 할 신발을 입력해주세요!")
                .foregroundColor(.gray)
        }
        
    }
    
}
