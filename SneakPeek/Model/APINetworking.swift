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
    //Login
    func login(email: String, password: String)-> AnyPublisher<APIResponse, APIError>
    //Get Data
    func getProfileData(userID: Int, token: String)-> AnyPublisher<APIResponse, APIError>
    //Update Data
    func updateProfileData(userID: Int, token: String, profileImage: String, intro: String)
//        -> AnyPublisher<APIResponse, APIError>
    

    
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
    func login(email: String, password: String) -> AnyPublisher<APIResponse, APIError> {
        return send(with: prepareForLogin(email: email, password: password))
    }
    //MARK: -function to GET profile data
    ///
    /// - Parameters:
    ///     - userID: receives userID saved in keychain
    ///     - token: receives authentication token saved in keychian
    /// - Returns: send(with: prepareGetProfileData())
    func getProfileData(userID: Int, token: String) -> AnyPublisher<APIResponse, APIError> {
        return send(with: prepareGETProfileData(userID: userID, token: token))
    }
    //MARK: -function to prepare POST profileData
    ///
    /// - Parameters:
    ///     - userID: userID saved in keychain
    ///     - token: authentication token saved in keychain
    ///     - profileImage: UIImage converted to url string
    ///     - intro: User input string from Profile
    func updateProfileData(userID: Int, token: String, profileImage: String, intro: String) {
        let task = session.dataTask(with: preparePATCHProfileData(userID: userID, token: token, profileImage: profileImage, intro: intro)) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let err = error {
                print("Failed to update:", err)
                return
            }
        }
        task.resume()
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
    
    //http://localhost:3000/api/users/
    struct BaseAPI {
        static let baseURL : String = "http://localhost:3000/api/"
    }
    //MARK: -function to prepare login request
    ///
    /// - Parameters:
    ///     - email: user email : String
    ///     - password: user password : String
    /// - Returns: URLRequest
    func prepareForLogin(email: String, password: String) -> URLRequest {
        let url = URL(string: BaseAPI.baseURL+"login")!
        let params = ["email": email, "password": password]
        var loginRequest = URLRequest(url: url)
        loginRequest.httpMethod = "POST"
        loginRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        do {
            loginRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch let error{
            print(error.localizedDescription)
        }
        return loginRequest
    }
    //MARK: -function to prepare GET profileData
    ///
    /// - Parameters:
    ///     - userID: userID saved in keychain
    ///     - token: authentication token saved in keychain
    /// - Returns: URLRequest(GET)
    func prepareGETProfileData(userID: Int, token: String) -> URLRequest{
        let url = URL(string: BaseAPI.baseURL + String(userID))!
//        let params = ["id" : userID]
        var dataRequest = URLRequest(url: url)
        dataRequest.httpMethod = "GET"
        dataRequest.addValue(token, forHTTPHeaderField: "Authorization")
        dataRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//        do {
//            dataRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
//        } catch let error{
//            print(error.localizedDescription)
//        }
        return dataRequest
    }
    
    //MARK: -function to prepare POST profileData
    ///
    /// - Parameters:
    ///     - userID: userID saved in keychain
    ///     - token: authentication token saved in keychain
    ///     - profileImage: UIImage currently displayed in Profile converted to url string
    ///     - intro: User input string from Profile
    /// - Returns: URLRequest(PATCH))
    func preparePATCHProfileData(userID: Int, token: String, profileImage: String, intro: String)-> URLRequest {
        let url = URL(string: BaseAPI.baseURL)!
        let params = [
            "profile_image": profileImage,
            "intro": intro,
            "user_id": userID
            ] as [String : Any]
        
        var loginRequest = URLRequest(url: url)
        loginRequest.httpMethod = "PATCH"
        loginRequest.addValue(token, forHTTPHeaderField: "Authorization")
        loginRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        do {
            loginRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch let error{
            print(error.localizedDescription)
        }
        return loginRequest
    }
}
