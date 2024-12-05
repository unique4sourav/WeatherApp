//
//  CurrentPlaceWeatherView.swift
//  WeatherApp
//
//  Created by Sourav Santra on 05/12/24.
//

import SwiftUI

struct CurrentLocationWeatherView: View {
    let weather: Weather
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text(weather.place)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
            }
            
            Text(weather.currentTemperature.temperatureString)
                .font(.largeTitle)
            
            Text(weather.description)
                .font(.title3)
            HStack {
                Text(DashboardConstant.humidity)
                
                Text(weather.humidity.humidityString)
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CurrentLocationWeatherView(weather: PreviewContent.shared.weather)
}
