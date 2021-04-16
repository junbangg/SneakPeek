//
//  Search.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/22.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//
// MARK: - TODO Change the structure of Search/Nonsearch view

import SwiftUI
import SwiftKeychainWrapper

/**
 Logic:
    1. Search View that receives Search input from User
    2. Search query is sent to ViewModel (SearchViewModel)
    3. Receives search result as [ShoeDataModel] from viewModel(SearchViewModel)
    4. Presents Search Results
 */
struct Search: View {
    //MARK: - Properties
    /// view model that will provide all required data for the view
    @ObservedObject var viewModel : SearchViewModel
    
    init(viewModel : SearchViewModel) {
        self.viewModel = viewModel
    }
    @State private var inputSwitch : Bool = false
    @State private var shoeID : String = ""
    
    //MARK: - View Body
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
                        /// Search Results are presented here
                        List {
                            if viewModel.searchDatasource.isEmpty {
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
        }
        
    }
}

//MARK: - Extensions
private extension Search {
    //MARK: - Custom Logo view
    var logo : some View {
        Image("Chicago")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300)
            .padding(.top,30)
    }
    //MARK: - Search button view
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
    //MARK: - Search Field view
    var searchField : some View {
        TextField("Jordan Chicago", text: $viewModel.shoe)
            .padding()
            .background(MyColors.lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
            .padding()
    }
    //MARK: - results view
    var results : some View {
        Section {
            ForEach(viewModel.searchDatasource) { result in
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
    //MARK: - View for when search is empty
    var searchEmpty : some View {
        Section {
            Text("신발의 리셀 가격 한 눈에 확인하세요!")
                .foregroundColor(.gray)
        }
    }
    //MARK: - View for Empty section
    var emptySection: some View {
        Section {
            Text("검색 할 신발을 입력해주세요!")
                .foregroundColor(.gray)
        }
        
    }
    
}
