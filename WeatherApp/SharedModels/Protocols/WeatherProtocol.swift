//
//  WeatherProtocol.swift
//  WeatherApp
//
//  Created by Sourav Santra on 07/12/24.
//

import Foundation

protocol WeatherProtocol: Decodable {
    var place: String { get }
    var currentTemperature: Double { get }
    var lowestTemperature: Double { get }
    var highestTemperature: Double { get }
    var humidity: Double { get }
    var description: String { get }
}


