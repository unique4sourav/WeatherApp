//
//  RequestManagerProtocol.swift
//  WeatherApp
//
//  Created by Sourav Santra on 05/12/24.
//

import Foundation

protocol RequestManagerProtocol {
    func perform<T: Decodable>(_ request: URLRequestProtocol) async throws -> T
}
