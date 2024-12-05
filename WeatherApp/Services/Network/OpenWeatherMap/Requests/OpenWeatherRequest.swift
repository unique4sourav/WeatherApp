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
    
    func createURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = OpenWeatherMapAPIConstant.shared.scheme
        components.host = OpenWeatherMapAPIConstant.shared.host
        components.path = path
        
        
        if !urlParams.isEmpty {
            components.queryItems = urlParams.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let url = components.url else { throw NetworkError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        
        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        if authorization != .notNeeded {
            switch authorization {
            case .needed(let field, let value):
                urlRequest.setValue(value, forHTTPHeaderField: field)
                
            case .notNeeded:
                break
            }
        }
        
        if !params.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        }
        print("urlRequest" + String(describing: urlRequest))
        return urlRequest
    }
    
    
}
