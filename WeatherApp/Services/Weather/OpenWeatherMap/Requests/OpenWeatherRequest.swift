//
//  OpenWeatherRequest.swift
//  WeatherApp
//
//  Created by Sourav Santra on 05/12/24.
//

import Foundation

enum OpenWeatherRequest {
    case getCurrentWeatherFor(latitude: Double, longitude: Double)
}


extension OpenWeatherRequest: URLRequestProtocol {
    var path: String {
        "/data/2.5/weather"
    }
    
    var requestType: RequestType {
        .get
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var params: [String : Any] {
        [:]
    }
    
    var urlParams: [String : String?] {
        switch self {
        case let .getCurrentWeatherFor(latitude, longitude):
            var params: [String: String] = [:]
            
            params["lat"] = String(latitude)
            params["lon"] = String(longitude)
            params["appid"] = OpenWeatherMapAPIConstant.shared.apiKey
            params["units"] = SharedConstant.defaultMeasurement.rawValue
            
            return params
        }
    }
    
    var authorization: Authorization {
        .notNeeded
    }
}
