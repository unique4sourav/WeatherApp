//
//  MainTabView.swift
//  WeatherApp
//
//  Created by Sourav Santra on 05/12/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        
        TabView {
            Tab(MainTabConstant.TabName.dashboard,
                systemImage: SharedConstant.SFSymbol.currentAndPinnedLocation) {
                DashboardView()
            }
            
            
            Tab(MainTabConstant.TabName.bookmark,
                systemImage: SharedConstant.SFSymbol.bookmarkedPlaces) {
                EmptyView()
            }
        }
    }
}

#Preview {
    MainTabView()
}
