//
//  DashboardView.swift
//  WeatherApp
//
//  Created by Sourav Santra on 05/12/24.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel = DashboardViewModel()
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                locationPermissionView
                
                currentLocationWeatherView
            }
            .padding()
        }
        .searchable(
            text: $viewModel.searchLocation,
            prompt: Text(DashboardConstant.SearchBar.prompt)
        )
        .onAppear {
            viewModel.askForLocationPermission()
        }
        .alert(Text(DashboardConstant.Error.alertTitle),
               isPresented: $viewModel.shouldShowErrorAlert, actions: {
            Button(DashboardConstant.Error.singleButtonTitle) {
                viewModel.acknowledgeError()
            }
        }, message: {
            // TODO: - Introduce a error instead of error string
            Text(viewModel.errorMessage)
        })
        
    }
}

#Preview {
    DashboardView()
}


// MARK: - View Components
private extension DashboardView {
    
    var currentLocationWeatherView: some View {
        VStack {
            if let currentWeather = viewModel.currentPlaceWeather {
                CurrentLocationWeatherView(weather: currentWeather)
                Spacer()
            }
        }
    }
    
    var locationPermissionView: some View {
        VStack {
            if !viewModel.isLocationPermissionGiven {
                if viewModel.shouldAskForLocationPermission {
                    Button(DashboardConstant.enableLocationPermission,
                           systemImage: SharedConstant.SFSymbol.locationArrow) {
                        viewModel.askForLocationPermission()
                    }
                }
                else {
                    Label(DashboardConstant.locationPermissionDenied,
                          systemImage: SharedConstant.SFSymbol.locationPermissionDeniedArrow)
                }
            }
        }
    }
    
}
