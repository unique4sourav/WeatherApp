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
