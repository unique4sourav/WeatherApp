//
//  DataParser.swift
//  WeatherApp
//
//  Created by Sourav Santra on 05/12/24.
//

import Foundation

class DataParser: DataParserProtocol {
    private var jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
    }
    
    func parse<T>(from data: Data) throws -> T where T : Decodable {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
