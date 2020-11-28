//
//  Networking.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/20.
//  Copyright © 2020 Jun Bang. All rights reserved.
//

import Foundation
import Combine
//

// MARK: - Protocols
protocol APIRequest {
    //Get Products
    func getProducts(shoeName : String) -> AnyPublisher<[ShoeDataResponse], Error>
    func getProductPrices(shoeID : String) -> AnyPublisher<PriceDataResponse, Error>
    
}
// MARK: - Main Class
class APINetworking {
    private let session : URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
}
// MARK: - Fetching Data functions
extension APINetworking : APIRequest {
    //MARK: -getProducts
    ///
    /// - Parameters:
    ///     - shoeName: shoe name search : String
    /// - Returns: send(with: prepareForProductSearch())
    func getProducts(shoeName: String) -> AnyPublisher<[ShoeDataResponse], Error> {
        return sendSearchRequest(with: prepareForProductSearch(shoeName: shoeName))
    }
    //MARK: -getProductPrices
    ///
    /// - Parameters:
    ///     - shoeID: String
    /// - Returns: send()with: prepareForPriceSearch()
    func getProductPrices(shoeID: String) -> AnyPublisher<PriceDataResponse, Error> {
        return sendPriceRequest(with: prepareForPriceSearch(shoeID: shoeID))
    }
    
    //MARK: -function to send search request to backend
    ///
    /// - Parameters:
    ///     - request: receives URLRequest prepared by  functions in extension
    /// - Returns: An array of JSON Objects
    private func sendSearchRequest<T> (with request : URLRequest) -> AnyPublisher<[T], Error> where T : Decodable{
        
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
    //MARK: -function to send price request to backend
    ///
    /// - Parameters:
    ///     - request: receives URLRequest prepared by  functions in extension
    /// - Returns:  JSON Object
    private func sendPriceRequest<T> (with request : URLRequest) -> AnyPublisher<T, Error> where T : Decodable {
        return session.dataTaskPublisher(for: request)
            .map{$0.data}
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
// MARK: -URL components
private extension APINetworking {
    
    //http://localhost:3000
    struct BaseAPI {
        static let baseURL : String = "http://localhost:3000/"
        static let search : String = "search/"
    }
    
    
    //MARK: -function to prepare shoe search
    ///
    /// - Parameters:
    ///     - shoeName: shoe name : String for search
    /// - Returns: URLRequest
    func prepareForProductSearch(shoeName: String) -> URLRequest {
        //MARK: - TODO Error handeling
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
        
        
        //        dataRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        //        do {
        //            dataRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        //        } catch let error{
        //            print(error.localizedDescription)
        //        }
        
    }
    //MARK: -function to prepare price search
    ///
    /// - Parameters:
    ///     - shoeID: id for shoe : String for search
    /// - Returns: URLRequest
    
    //GET localhost:3000/id/:styleID/prices
    func prepareForPriceSearch(shoeID: String) -> URLRequest {
        let url = URL(string: BaseAPI.baseURL + "id/" + shoeID + "prices")!
        var dataRequest = URLRequest(url: url)
        dataRequest.httpMethod = "GET"
        
        return dataRequest
    }
    
    
}
