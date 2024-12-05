//
//  RequestManager.swift
//  WeatherApp
//
//  Created by Sourav Santra on 05/12/24.
//

import Foundation

class RequestManager: RequestManagerProtocol {
    let apiManager: APIManagerProtocol
    let parser: DataParserProtocol
    
    init(apiManager: APIManagerProtocol = APIManager(),
        parser: DataParserProtocol = DataParser()) {
        self.apiManager = apiManager
        self.parser = parser
    }
    
    func perform<T>(_ request: any URLRequestProtocol) async throws -> T where T : Decodable {
        let data = try await apiManager.perform(request)
        let stringResponse = String(data: data, encoding: .utf8)
        print("stringResponse" + String(describing: stringResponse))
        let decoded: T = try parser.parse(from: data)
        return decoded
    }
}
