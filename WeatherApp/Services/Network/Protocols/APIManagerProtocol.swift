//
//  APIManagerProtocol.swift
//  WeatherApp
//
//  Created by Sourav Santra on 05/12/24.
//

import Foundation

protocol APIManagerProtocol {
    func perform(_ request: URLRequestProtocol) async throws -> Data
}
