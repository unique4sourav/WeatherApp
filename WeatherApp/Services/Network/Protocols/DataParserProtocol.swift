//
//  DataParserProtocol.swift
//  WeatherApp
//
//  Created by Sourav Santra on 05/12/24.
//

import Foundation

protocol DataParserProtocol {
    func parse<T: Decodable>(from data: Data) throws -> T
}
