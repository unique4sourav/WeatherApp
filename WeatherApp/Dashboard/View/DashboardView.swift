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
                if viewModel.locationPermissionRestricted {
                    Label(DashboardConstant.locationPermissionRestricted,
                          systemImage: SharedConstant.SFSymbol.locationPermissionDeniedArrow)
                }
                
                if viewModel.locationPermissionDenied {
                    Label(DashboardConstant.locationPermissionDenied,
                          systemImage: SharedConstant.SFSymbol.locationPermissionDeniedArrow)
                }
                
                if let currentWeather = viewModel.currentPlaceWeather {
                    CurrentLocationWeatherView(weather: currentWeather)
                    Spacer()
                }
            }
            .padding()
        }
        .searchable(
            text: $viewModel.searchLocation,
            prompt: Text(DashboardConstant.SearchBar.prompt)
        )
        .onAppear {
            viewModel.checkLocationPermission()
        }
        .alert(Text(DashboardConstant.Error.alertTitle),
               isPresented: $viewModel.shouldShowErrorAlert, actions: {
            Button(DashboardConstant.Error.singleButtonTitle) {
                viewModel.acknowledgeError()
            }
        }, message: {
            Text(viewModel.errorMessage)
        })
        
    }
}

#Preview {
    DashboardView()
}


