//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Sourav Santra on 04/12/24.
//

import SwiftUI
import DependencyInjection

@main
struct WeatherAppApp: App {
    init() {
        addDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}

private extension WeatherAppApp {
    func addDependencies() {
        let locationManager = LocationManager()
        DependencyContainer.shared.register(locationManager)
        
        let dataParser = DataParser(keyDecodingStrategy: .convertFromSnakeCase)
        let requestManager = RequestManager(parser: dataParser)
        let weatherService = WeatherService(requestManager: requestManager)
        DependencyContainer.shared.register(weatherService)
    }
}
