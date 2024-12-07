//
//  WeatherServiceProtocol.swift
//  WeatherApp
//
//  Created by Sourav Santra on 07/12/24.
//

import Foundation

protocol WeatherServiceProtocol {
    func getWeather<T: WeatherProtocol>(latitude: Double, longitude: Double) async throws -> T
}
