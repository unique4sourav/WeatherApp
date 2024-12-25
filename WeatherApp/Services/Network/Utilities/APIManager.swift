//
//  APIManager.swift
//  WeatherApp
//
//  Created by Sourav Santra on 06/12/24.
//

import Foundation

final class APIManager: APIManagerProtocol {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func perform(_ request: URLRequestProtocol) async throws -> Data {
        let (data, response) = try await urlSession.data(for: request.createURLRequest())
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else { throw NetworkError.invalidServerResponse }
        
        return data
    }
}
