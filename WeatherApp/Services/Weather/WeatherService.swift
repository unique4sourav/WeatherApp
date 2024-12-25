//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Sourav Santra on 07/12/24.
//

import Foundation

final class WeatherService: WeatherServiceProtocol {
    let requestManager: RequestManagerProtocol

    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
    
    func getWeather<T: WeatherProtocol>(latitude: Double, longitude: Double) async throws -> T {
        let request = OpenWeatherRequest.getCurrentWeatherFor(latitude: latitude, longitude: longitude)
        return try await requestManager.perform(request)
    }
}
