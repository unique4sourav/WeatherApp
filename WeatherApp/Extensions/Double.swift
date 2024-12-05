//
//  Double.swift
//  WeatherApp
//
//  Created by Sourav Santra on 05/12/24.
//

import Foundation

extension Double {
    var temperatureString: String {
        var stringValue = String(describing: Int(self)) + "°"
        switch SharedConstant.defaultMeasurement {
        case .standard:
            stringValue += "K"
            
        case .metric:
            stringValue += "C"
            
        case .imperial:
            stringValue += "F"
        }
        
        return stringValue
    }
    
    var humidityString: String {
        String(describing: Int(self))
    }
}
