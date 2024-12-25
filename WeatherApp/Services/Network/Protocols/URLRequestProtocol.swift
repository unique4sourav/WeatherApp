//
//  URLRequestProtocol.swift
//  WeatherApp
//
//  Created by Sourav Santra on 05/12/24.
//

import Foundation

protocol URLRequestProtocol {
    var path: String { get }
    var requestType: RequestType { get }
    var headers: [String: String] { get }
    var params: [String: Any] { get }
    var urlParams: [String: String?] { get }
    var authorization: Authorization { get }
    
    func createURLRequest() throws -> URLRequest
}

extension URLRequestProtocol {
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
        print("\nurlRequest:\n" + String(describing: urlRequest))
        return urlRequest
    }
}
