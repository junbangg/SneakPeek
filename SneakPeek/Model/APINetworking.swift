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
    func requestShoe(shoeName: String) -> AnyPublisher<ShoeResponse, Error>
//    func requestShoeDetails(shoeID: String) -> AnyPublisher<ShoeDetailsSearchResponse, APIError>
    
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
    func requestShoe(shoeName: String) -> AnyPublisher<ShoeResponse, Error> {
        let request = prepareForShoeSearch(shoeName: shoeName, itemLimit: 10)
        
        return sendShoeSearchRequest(with: request)
    }
    
    //MARK: -getProductPrices
    
//    func requestShoeDetails(shoeID: String) -> AnyPublisher<ShoeDetailsSearchResponse, APIError> {
//        return sendShoeDetailsRequest(with: prepareForShoeDetailsSearch(shoeID: shoeID))
//    }
    
    //MARK: - send shoe request to API
    
    ///
    /// - Parameters:
    ///     - request: receives URLRequest prepared by  functions in extension
    /// - Returns: An array of JSON Objects
    private func sendShoeSearchRequest<T> (with request: URLRequest) -> AnyPublisher<T, Error> where T: Decodable{
        return session.dataTaskPublisher(for: request)
//            .mapError { error in
//                .badRequest(error.localizedDescription)
//            }
                        .map{$0.data}
                        .decode(type: T.self, decoder: JSONDecoder())
//            .flatMap(maxPublishers: .max(1)) { response in
//                decode(response.data)
//            }
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

// MARK: - URL components

private extension APINetworking {
    private enum API {
        private enum URLString {
            static let baseURL = "https://the-sneaker-database.p.rapidapi.com/"
        }
        
        private enum Path {
            static let search = "search"
        }
        
        enum APIKey {
            static let apiKey = "ee9760ab69msh475edf1666457cbp1c3876jsn65c171d09766"
        }
        
        case fetchShoe
        
        var url: String {
            switch self {
            case .fetchShoe:
                return URLString.baseURL + Path.search
            }
        }
    }
}

// MARK: - Prepare methods

private extension APINetworking {
    
    //MARK: -prepare shoe search
    
    ///
    /// - Parameters:
    ///     - shoeName: shoe name : String for search
    /// - Returns: URLRequest
    func prepareForShoeSearch(shoeName: String, itemLimit: Int) -> URLRequest {
        let urlstring = API.fetchShoe.url + "?" + "limit=\(itemLimit)" + "&query=\(shoeName)"
        let url = URL(string: urlstring)!
//        let parameters: [String: Any] = ["limit": itemLimit, "query": shoeName]
        let headers = ["x-rapidapi-key": API.APIKey.apiKey]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
//        } catch let error {
//            print(error.localizedDescription)
//        }
        
        return request
    }
}
