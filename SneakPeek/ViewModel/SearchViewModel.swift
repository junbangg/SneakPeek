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

class SearchViewModel : ObservableObject {
    @Published var shoe : String = ""
//    @Published var shoeID : String = ""
    @State var inputSwitch : Bool = false
    @Published var datasource : [SearchResultViewModel] = []
    @Published var productDatasource : ProductDetailsViewModel?
    private let shoeFetcher : APIRequest
    private var disposables = Set<AnyCancellable>()
    init(
//        shoeID : String,
        shoeFetcher : APIRequest,
        scheduler: DispatchQueue = DispatchQueue(label: "SearchViewModel")
    ) {
//        self.shoeID = shoeID
        self.shoeFetcher = shoeFetcher
        //2
        $shoe
            //3
            .dropFirst(1)
            //4
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            //5
            .sink(receiveValue: fetchShoe(forShoe:))
            //6
            .store(in: &disposables)
    }
    
    func fetchShoe(forShoe shoe : String) {
        shoeFetcher.getProducts(shoeName: shoe)
            .map{response in
                response.map(SearchResultViewModel.init)}
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        //6
                        print(value)
                        self.datasource = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] shoe in
                    guard let self = self else { return }
                    //7
                    self.datasource = shoe
//                    print(shoe)
            })
            .store(in: &disposables)
        
        
    }
    
    func refresh() {
        let shoeID : String? = KeychainWrapper.standard.string(forKey: "shoeID")
        print(shoeID!)
        shoeFetcher.getProductPrices(shoeID: shoeID!)
            .map(ProductDetailsViewModel.init)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    print(value)
                    self.refresh()
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

extension SearchViewModel {
    var ProductDetails: some View {
        return ProductViewBuilder.makeProductDetailView(shoeFetcher: shoeFetcher)
    }
}
