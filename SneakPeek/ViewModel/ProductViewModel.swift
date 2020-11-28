//
//  ProductViewModel.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/28.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//

import Foundation
import Combine

class ProductViewModel : ObservableObject {
    @Published var datasource : ProductDetailsViewModel?
//    @Published var shoeID : String = ""
    private let shoeID : String
    private let shoeFetcher : APIRequest
    private var disposables = Set<AnyCancellable>()
    
    init(shoeID: String, shoeFetcher: APIRequest) {
//        self.id = id
        self.shoeID = shoeID
        self.shoeFetcher = shoeFetcher
    }
    
    func refresh() {
        shoeFetcher.getProductPrices(shoeID: shoeID)
            .map(ProductDetailsViewModel.init)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.datasource = nil
                case .finished:
                    break
                }
                }, receiveValue: { [weak self] details in
                    guard let self = self else { return }
                    self.datasource = details
            })
            .store(in: &disposables)
    }
}
