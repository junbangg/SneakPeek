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
    
    @ObservedObject var viewModel: SearchViewModel
    @State private var inputSwitch: Bool = false
    @State private var shoeID: String = ""
    
    //MARK: - Initializer
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
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
                        List {
                            if viewModel.searchDatasource == nil {
                                emptySection
                            } else {
                                results
                            }
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

//MARK: - Helper Views

private extension Search {
    //MARK: - Custom Logo
    
    var logo: some View {
        Image("Chicago")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300)
            .padding(.top,30)
    }
    
    //MARK: - Search Button
    
    var searchButton: some View {
        Button(action: {
            self.inputSwitch = true
        }) {
            HStack {
                Text("Jordan Chicago")
                Spacer()
                Spacer()
            }
            .padding()
            .foregroundColor(.gray)
            .background(MyColors.lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
            .padding(20)
        }.buttonStyle(PlainButtonStyle())
    }
    
    //MARK: - Search Field
    
    var searchField: some View {
        TextField("Jordan Chicago", text: $viewModel.shoe)
            .padding()
            .background(MyColors.lightGreyColor)
            .cornerRadius(5.0)
//            .padding(.bottom, 20)
            .padding()
    }
    
    //MARK: - Results
    
    var results: some View {
        Section {
            ForEach(viewModel.searchDatasource!.results) { shoe in
                NavigationButton(action: {
                    let _: Bool = KeychainWrapper.standard.set(shoe.id, forKey: "shoeID")
                    //                    self.shoeID = result.id
                }, destination: {
                    Product(viewmodel: self.viewModel)
                }) {
                    SearchResult.init(viewModel: shoe, shoeID: shoe.id)
                }
            }
        }
    }
    
    //MARK: - Home Section(Empty Search)
    
    var searchEmpty: some View {
        Section {
            Text("신발의 리셀 가격을 한 눈에 확인해보세요!")
                .foregroundColor(.gray)
        }
    }
    
    //MARK: - Search Empty Section
    
    var emptySection: some View {
        Section {
            Text("검색할 신발을 입력해주세요!")
                .foregroundColor(.gray)
        }
    }
}
