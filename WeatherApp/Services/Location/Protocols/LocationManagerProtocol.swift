//
//  LocationManagerProtocol.swift
//  WeatherApp
//
//  Created by Sourav Santra on 07/12/24.
//

import Foundation
import CoreLocation

@MainActor
protocol LocationManagerProtocol {
    var location: CLLocation? { get }
    var authorizationStatus: CLAuthorizationStatus? { get }
    
    func requestPermission()
    func startUpdatingLocation()
    func stopUpdatingLocation()
}
