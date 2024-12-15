//
//  DashboardViewModel.swift
//  WeatherApp
//
//  Created by Sourav Santra on 05/12/24.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation
import DependencyInjection

@MainActor
final class DashboardViewModel: ObservableObject {
    @Injected var locationManager: LocationManager
    @Injected var weatherService: WeatherService
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var currentPlaceWeather: Weather?
    @Published var searchLocation: String = ""
    @Published var shouldShowErrorAlert: Bool = false
    
    private var currentLocation: CLLocation? = nil
    private(set) var errorMessage: String = ""
    
    @Published var locationPermissionDenied: Bool = false
    @Published var locationPermissionRestricted: Bool = false
    @Published var locationPermissionGiven: Bool = false
    
    init() {
        locationManager.$authorizationStatus
            .map { $0 == .denied}
            .assign(to: &$locationPermissionDenied)
        
        locationManager.$authorizationStatus
            .map { $0 == .restricted }
            .assign(to: &$locationPermissionRestricted)
        
        locationManager.$authorizationStatus
            .map { $0 == .authorizedAlways || $0 == .authorizedWhenInUse }
            .assign(to: &$locationPermissionGiven)
        
        
        $locationPermissionGiven
            .sink { [weak self] givenPermission in
            guard let self else { return }
            
            if givenPermission {
                self.locationManager.startUpdatingLocation()
            }
        }
        .store(in: &cancellables)
        
        locationManager.$location
            .compactMap{ $0 }
            .sink { [weak self] location in
                guard let self else { return }
                // print("Received value: \(String(describing: location))")
                // locationManager.stopUpdatingLocation()
                self.currentLocation = location
                fetchWeatherOfCurrentLocationWith(
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude)
            }
            .store(in: &cancellables)
    }
    
    
    func fetchWeatherOfCurrentLocationWith(latitude: Double, longitude: Double) {
        Task {
            do {
                let weather: Weather = try await self.weatherService.getWeather(latitude: latitude, longitude: longitude)
                await MainActor.run {
                    self.currentPlaceWeather = weather
                }
            }
            catch let error {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.shouldShowErrorAlert = true
                }
            }
            
        }
    }

    func checkLocationPermission() {
        if locationManager.authorizationStatus == nil ||
            locationManager.authorizationStatus == .notDetermined {
            locationManager.requestPermission()
        }
    }
    
    func acknowledgeError() {
        shouldShowErrorAlert = false
        errorMessage = ""
    }
}
