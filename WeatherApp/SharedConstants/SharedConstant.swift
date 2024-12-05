//
//  SharedConstant.swift
//  WeatherApp
//
//  Created by Sourav Santra on 05/12/24.
//

import Foundation

struct SharedConstant {
    private init () { }
    
    static let defaultMeasurement: MeasurementUnit = .metric
    
    struct SFSymbol {
        private init () { }
        
        static let currentAndPinnedLocation = "cloud.sun"
        static let bookmarkedPlaces = "bookmark.square.fill"
        static let locationArrow = "location.fill"
        static let locationPermissionDeniedArrow = "location.slash.fill"
        static let locationPermissionGiven = "location.fill"
        static let locationPermissionNotGiven = "location.slash.fill"
    }
    
}
