//
//  DashboardConstant.swift
//  WeatherApp
//
//  Created by Sourav Santra on 05/12/24.
//

import Foundation

struct DashboardConstant {
    private init() { }
    static let humidity = "Humidity:"
    static let highestTemperature = "H:"
    static let lowestTemperature = "L:"
    static let currentLocatiom = "Current Location"
    static let enableLocationPermission = "Enable Location Permission"
    static let locationPermissionDenied = "Location permission was denied."
    
    struct SearchBar {
        private init() { }
        
        static let prompt = "Search for a location..."
        
    }
    
    struct Error {
        private init() { }
        
        static let alertTitle = "Oops!"
        static let singleButtonTitle = "Ok"
    }
}
