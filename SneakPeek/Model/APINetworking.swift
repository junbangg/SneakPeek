//
//  Networking.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/20.
//  Copyright © 2020 Jun Bang. All rights reserved.
//

//MARK: - TODO Fix error when retreiving prices


import Foundation
import Combine

// MARK: - Protocol

protocol APIRequest {
    //Get Products
    func requestShoe(shoeName: String) -> AnyPublisher<[ShoeSearchResponse], Error>
    func requestShoeDetails(shoeID: String) -> AnyPublisher<ShoeDetailsSearchResponse, APIError>
    
}

// MARK: - Main Class

class APINetworking {
    private let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
}

// MARK: - Protocol methods

extension APINetworking: APIRequest {
    //MARK: -getProducts
    
    ///
    /// - Parameters:
    ///     - shoeName: shoe name search : String
    /// - Returns: send(with: prepareForProductSearch())
    func requestShoe(shoeName: String) -> AnyPublisher<[ShoeSearchResponse], Error> {
        return sendShoeSearchRequest(with: prepareForShoeSearch(shoeName: shoeName))
    }
    
    //MARK: -getProductPrices
    
    ///
    /// - Parameters:
    ///     - shoeID: String
    /// - Returns: send()with: prepareForPriceSearch()
    func requestShoeDetails(shoeID: String) -> AnyPublisher<ShoeDetailsSearchResponse, APIError> {
        return sendShoeDetailsRequest(with: prepareForShoeDetailsSearch(shoeID: shoeID))
    }
    
    //MARK: - send shoe request to API
    
    ///
    /// - Parameters:
    ///     - request: receives URLRequest prepared by  functions in extension
    /// - Returns: An array of JSON Objects
    private func sendShoeSearchRequest<T> (with request: URLRequest) -> AnyPublisher<[T], Error> where T: Decodable{
        return session.dataTaskPublisher(for: request)
            //            .mapError { error in
            //                .badRequest(error.localizedDescription)
            //        }
            .map{$0.data}
            .decode(type: [T].self, decoder: JSONDecoder())
            //        .flatMap(maxPublishers: .max(1)) { response in
            //            decode(response.data)
            //        }
            .eraseToAnyPublisher()
    }
    
    //MARK: - send shoe details request to API
    
    ///
    /// - Parameters:
    ///     - request: receives URLRequest prepared by  functions in extension
    /// - Returns:  JSON Object
    // - TODO: ERROR when clicking product..retreiving prices
    private func sendShoeDetailsRequest<T> (with request: URLRequest) -> AnyPublisher<T, APIError> where T: Decodable {
        return session.dataTaskPublisher(for: request)
            .mapError { error in
                .badRequest(error.localizedDescription)
        }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
        }
            .eraseToAnyPublisher()
    }
}

// MARK: -URL components

private extension APINetworking {
    
    //http://localhost:3000
    struct BaseAPI {
        static let baseURL: String = "http://localhost:3000/"
        static let search: String = "search/"
    }
    
    //MARK: -prepare shoe search
    
    ///
    /// - Parameters:
    ///     - shoeName: shoe name : String for search
    /// - Returns: URLRequest
    func prepareForShoeSearch(shoeName: String) -> URLRequest {
        //TODO: Error handeling
        let urlstring = BaseAPI.baseURL + BaseAPI.search + shoeName
        
        if let url = URL(string: urlstring) {
            var dataRequest = URLRequest(url: url)
            dataRequest.httpMethod = "GET"
            print(url)
            return dataRequest
        }else {
            let url = URL(fileURLWithPath: BaseAPI.baseURL + BaseAPI.search)
            print("Failed:")
            print(url)
            var dataRequest = URLRequest(url: url)
            dataRequest.httpMethod = "GET"
            return dataRequest
        }
    }
    
    //MARK: - prepare shoe details search
    
    ///
    /// - Parameters:
    ///     - shoeID: id for shoe : String for search
    /// - Returns: URLRequest
    
    //GET localhost:3000/id/:styleID/prices
    func prepareForShoeDetailsSearch(shoeID: String) -> URLRequest {
        let url = URL(string: BaseAPI.baseURL + "id/" + shoeID + "/prices")!
        var dataRequest = URLRequest(url: url)
        dataRequest.httpMethod = "GET"
        
        return dataRequest
    }
}
