//
//  Errors.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/21.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//


import Foundation
enum APIError: Error {
    /// Encoding issue when trying to send data.
    case encodingError(String?)
    /// No data recieved from the server.
    case noData
    /// The server response was invalid (unexpected format).
    case invalidResponse
    /// The request was rejected: 400-499
    case badRequest(String?)
    /// Encountered a server error.
    case serverError(String?)
    /// There was an error parsing the data.
    case parseError(String?)
    /// Unknown error.
    case mappingError(String?)
    case unknown
}
