//
//  PreviewContent.swift
//  WeatherApp
//
//  Created by Sourav Santra on 05/12/24.
//

import Foundation

class PreviewContent {
    private init() { }
    
    static let shared = PreviewContent()
    
    let weather = Weather(
        place: "Hyderabad",
        currentTemperature: 22,
        lowestTemperature: 21,
        highestTemperature: 29,
        humidity: 50,
        description: "Mostly Cloudy")
}
