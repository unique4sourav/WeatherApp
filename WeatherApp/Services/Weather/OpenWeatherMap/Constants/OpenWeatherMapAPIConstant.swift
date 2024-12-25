//
//  OpenWeatherMapAPIConstant.swift
//  WeatherApp
//
//  Created by Sourav Santra on 05/12/24.
//

import Foundation

struct OpenWeatherMapAPIConstant: APIConstantProtocol {
    private init() {}
    
    static let shared = OpenWeatherMapAPIConstant()
    
    let scheme: String = "https"
    let host: String = "api.openweathermap.org"
    let apiKey = "c088700d43b1fe1a0bc01a082d071b64"
}
