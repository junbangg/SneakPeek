//
//  Parsing.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/21.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//
import Foundation
import Combine


/// Function to decode data
/// - Parameter data: <#data description#>
/// - Returns: AnyPublisher<T, APIError>
func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, APIError> {
  return Just(data)
    .decode(type: T.self, decoder: JSONDecoder())
    .mapError { error in
      .parseError(error.localizedDescription)
    }
    .eraseToAnyPublisher()
}
