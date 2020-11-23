//
//  SearchViewModel.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/22.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//

import SwiftUI
import Combine

class SearchViewModel : ObservableObject {
    @Published var shoe : String = ""
    @Published var datasource : [SearchResultViewModel] = []
    private let shoeFetcher : APIRequest
    private var disposables = Set<AnyCancellable>()
    init(
        shoeFetcher : APIRequest,
        scheduler: DispatchQueue = DispatchQueue(label: "SearchViewModel")
    ) {
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
                response.productList.map(SearchResultViewModel.init)}
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        //6
                        self.datasource = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] shoe in
                    guard let self = self else { return }
                    //7
                    self.datasource = shoe
            })
            .store(in: &disposables)
        
        
    }
    
}
