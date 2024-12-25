//
//  AuthorizationProtocol.swift
//  WeatherApp
//
//  Created by Sourav Santra on 05/12/24.
//

import Foundation

protocol AuthorizationProtocol {
}

// TODO: - Need to restructure
enum Authorization: Comparable {
    case needed(field: String, value: String)
    case notNeeded
}
