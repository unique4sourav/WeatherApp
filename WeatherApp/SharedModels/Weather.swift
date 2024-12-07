//
//  Weather.swift
//  WeatherApp
//
//  Created by Sourav Santra on 05/12/24.
//

import Foundation

struct Weather: WeatherProtocol {
    let place: String
    let currentTemperature: Double
    let lowestTemperature: Double
    let highestTemperature: Double
    let humidity: Double
    let description: String
}



extension Weather: Decodable {
    enum Keys: String, CodingKey {
        case name
        case main
        case weather
        
        enum MainKeys: String, CodingKey {
            case temp
            case tempMin
            case tempMax
            case humidity
        }
        
        enum WeatherKeys: String, CodingKey {
            case description
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.place = try container.decode(String.self, forKey: .name)
        let mainContainer = try container.nestedContainer(keyedBy: Keys.MainKeys.self, forKey: .main)
        self.currentTemperature = try mainContainer.decode(Double.self, forKey: .temp)
        self.lowestTemperature = try mainContainer.decode(Double.self, forKey: .tempMin)
        self.highestTemperature = try mainContainer.decode(Double.self, forKey: .tempMax)
        self.humidity = try mainContainer.decode(Double.self, forKey: .humidity)
        var weatherArray = try container.nestedUnkeyedContainer(forKey: .weather)
        let weatherDetails = try weatherArray.nestedContainer(keyedBy: Keys.WeatherKeys.self)
        self.description = try weatherDetails.decode(String.self, forKey: .description)
    }

}
