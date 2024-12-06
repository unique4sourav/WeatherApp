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

final class DashboardViewModel: ObservableObject {
    private let locationManager = LocationManager()
    private let requestManager = RequestManager()
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var currentPlaceWeather: Weather?
    @Published var searchLocation: String = ""
    @Published var isLocationPermissionGiven: Bool = false
    @Published var shouldAskForLocationPermission = false
    @Published var shouldShowErrorAlert: Bool = false
    
    private var currentLocation: CLLocation? = nil
    private(set) var errorMessage: String = ""
    
    
    init() {
        locationManager.$authorizationStatus
            .map { $0 == .notDetermined }
            .assign(to: &$shouldAskForLocationPermission)
        
        locationManager.$authorizationStatus
            .map { $0 == .authorizedAlways || $0 == .authorizedWhenInUse }
            .assign(to: &$isLocationPermissionGiven)
        
        $isLocationPermissionGiven.sink { [weak self] givenPermission in
            guard let self else { return }
            
            if givenPermission {
                self.locationManager.startUpdatingLocation()
            }
        }
        .store(in: &cancellables)
        
        locationManager.$location
            .compactMap{ $0 }
            .filter({ [weak self] fetchedLocation in
                guard let self else { return false }
                guard let currentLocation else { return true}
                /// will fetch weather only if the displacement is more than equal to 50 km
                return fetchedLocation.distance(from: currentLocation) >= 50_000
            })
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
                let weather: Weather = try await self.requestManager
                    .perform(OpenWeatherRequest.getCurrentWeatherFor(latitude: latitude, longitude: longitude))
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
    
    func fetchWeatherOf(latitude: Double, longitude: Double) {
        Task {
            // TODO: - Handle the error
            let weather: Weather? = try? await self.requestManager
                .perform(OpenWeatherRequest.getCurrentWeatherFor(latitude: latitude, longitude: longitude))
            await MainActor.run {
                self.currentPlaceWeather = weather
            }
        }
    }
    
    func askForLocationPermission() {
        locationManager.requestPermission()
    }
    
    func acknowledgeError() {
        shouldShowErrorAlert = false
        errorMessage = ""
    }
}
