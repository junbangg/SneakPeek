//
//  Networking.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/20.
//  Copyright © 2020 Jun Bang. All rights reserved.
//

import Foundation
import Combine

// MARK: - Protocols
protocol APIRequests {
    //Get Products
    func getProducts(shoeName : String) -> AnyPublisher<ProductResponse, APIError>
//    func getProductPrices(shoeID : String) -> AnyPublisher<ProductResponse, APIError>
    
}
// MARK: - Main Class
class APINetworking {
    private let session : URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
}
// MARK: - Fetching Data functions
extension APINetworking : APIRequests {
    //MARK: -login
    ///
    /// - Parameters:
    ///     - email: user email
    ///     - password: user password
    /// - Returns: send(with: prepareForLogin())
    func getProducts(shoeName: String) -> AnyPublisher<ProductResponse, APIError> {
        return send(with: prepareForProductSearch(shoeName: shoeName))
    }
    
    //MARK: -function to send request to backend
    ///
    /// - Parameters:
    ///     - request: receives URLRequest prepared by  functions in extension
    private func send<T> (with request : URLRequest) -> AnyPublisher<T, APIError> where T : Decodable{
        
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
        static let baseURL : String = "http://localhost:3000/"
    }
    //MARK: -function to prepare login request
    ///
    /// - Parameters:
    ///     - shoeName: shoe name : String for search
    /// - Returns: URLRequest
    func prepareForProductSearch(shoeName: String) -> URLRequest {
        let url = URL(string: BaseAPI.baseURL + "search/" + shoeName)!
        var dataRequest = URLRequest(url: url)
        dataRequest.httpMethod = "GET"
        dataRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        //        do {
        //            dataRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        //        } catch let error{
        //            print(error.localizedDescription)
        //        }
        return dataRequest
    }
    
    
    
    
}
