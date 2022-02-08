//
//  SearchViewModel.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/22.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//

import SwiftUI
import Combine
import SwiftKeychainWrapper

/**
 ViewModel for Search View & Product View
 Logic:
    1. fetchShoe() is used to retreive search results from Model(APIRequest)
    2. results are mapped to [ShoeDataModel] and Published to Search view
 or
    1. fetchShoeDetails() is used to retreive search results from Model(APIRequest)
    2. results are mapped to ShoeDetailsDataModel and Published to Product View
        
 */
 
/// ViewModel for Search View
class SearchViewModel: ObservableObject {
    //MARK: - Publishers and States
    
    @Published var shoe: String = ""
    @State var inputSwitch: Bool = false
    /// Publisher that Search view will subscribe to in order to receive SearchResultData
//    @Published var searchDatasource: [ShoeDataModel] = []
    @Published var searchDatasource: ShoeSearchDataModel?
    /// Publisher that Search view will subscribe to in order to receive SearchResultData
    @Published var productDatasource: ShoeDetailsDataModel?
    /// property for communicating with Model(APIRequest)
    private let shoeFetcher: APINetworking
    /// Trash can
    private var disposables = Set<AnyCancellable>()
    
    //MARK: - init
    
    init(
        shoeFetcher: APINetworking,
        scheduler: DispatchQueue = DispatchQueue(label: "SearchViewModel")
    ) {
        self.shoeFetcher = shoeFetcher
        //2
        $shoe
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink(receiveValue: fetchShoe(forShoe:))
            .store(in: &disposables)
    }
    
    //MARK: - fetchShoe()
    
    /**
     Method for fetching a shoe product's data.
        1.  The function will make a request to the model with given parameter (shoe)
        2.  response(ShoeSearchResponse) will be mapped to ShoeDataModel
        3. save the converted [ShoeDataModel] to the shoeDatasource Publisher
     - Parameter shoe: Search query
    */
    func fetchShoe(forShoe shoe: String) {
        shoeFetcher.requestShoe(sneakerName: shoe)
            .map(ShoeSearchDataModel.init)
//            .map{response in
//                response.map(ShoeDataModel.init)}
            /// main 으로 받는게 맞을까?
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        print(value)
                        self.searchDatasource = nil
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] searchResult in
                    guard let self = self else { return }
                    print(searchResult)
                    self.searchDatasource = searchResult
                })
            .store(in: &disposables)
        
    }
    
    //MARK: - fetchProductDetails()
    
    /**
        Method for refreshing search and retreiving data
        1. The function will make a request to the Model with shoeID and request data
        2. The search result(ShoeDetailsSearchResponse) will be mapped to ShoeDetailsDataModel
        3. save the converted [ShoeDetailsDataModel] to the productDatasource Publisher
     */
    func fetchShoeDetails() {
        //Retreive searched shoeID from keychain
        let shoeID: String? = KeychainWrapper.standard.string(forKey: "shoeID")
        shoeFetcher.requestShoeDetails(sneakerID: shoeID!)
            /// ShoeDetailsSearchResponse -> ShoeDetailsDataModel
            .map(ShoeDetailsDataModel.init)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    print(value)
                    self.fetchShoeDetails()
                    self.productDatasource = nil
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] details in
                guard let self = self else { return }
                self.productDatasource = details
            })
            .store(in: &disposables)
    }
}
/// Extension that will build a view with shoe data
extension SearchViewModel {
    var ProductDetails: some View {
        return ProductViewBuilder.makeProductDetailView(shoeFetcher: shoeFetcher)
    }
}
