//
//  DataParser.swift
//  WeatherApp
//
//  Created by Sourav Santra on 05/12/24.
//

import Foundation

class DataParser: DataParserProtocol {
    private var jsonDecoder: JSONDecoder
    private(set) var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy
    
    init(jsonDecoder: JSONDecoder = JSONDecoder(),
         keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) {
        self.keyDecodingStrategy = keyDecodingStrategy
        self.jsonDecoder = jsonDecoder
    }
    
    func parse<T>(from data: Data) throws -> T where T : Decodable {
        self.jsonDecoder.keyDecodingStrategy = self.keyDecodingStrategy
        return try jsonDecoder.decode(T.self, from: data)
    }
}
