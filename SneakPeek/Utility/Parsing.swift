//
//  Parsing.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/21.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//
import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, APIError> {
  let decoder = JSONDecoder()
  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
      .parseError(error.localizedDescription)
    }
    .eraseToAnyPublisher()
}
