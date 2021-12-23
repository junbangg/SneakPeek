//
//  ProductViewModel.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/28.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//

import Foundation
import Combine

class ProductViewModel: ObservableObject {
    @Published var datasource: ShoeDetailsDataModel?
    private let shoeID : String
    private let shoeFetcher: APINetworking
    private var disposables = Set<AnyCancellable>()
    
    init(shoeID: String, shoeFetcher: APINetworking) {
        self.shoeID = shoeID
        self.shoeFetcher = shoeFetcher
    }
    
    func refresh() {
        shoeFetcher.requestShoeDetails(shoeID: shoeID)
            .map(ShoeDetailsDataModel.init)
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
