//
//  DataParserProtocol.swift
//  WeatherApp
//
//  Created by Sourav Santra on 05/12/24.
//

import Foundation

protocol DataParserProtocol {
    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy { get }
    func parse<T: Decodable>(from data: Data) throws -> T
}
