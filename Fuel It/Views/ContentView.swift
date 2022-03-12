//
//  ContentView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 09/03/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        TabView {
            HomeView()
                .tabItem {Label(NSLocalizedString("Home", comment: "Homepage"), systemImage: "house.fill")}
            NearbyView()
                .tabItem({Label(NSLocalizedString("Best fuel deals", comment: "Best fuel deals view button"), systemImage: "giftcard.fill")})
            SettingsView()
                .tabItem({Label(NSLocalizedString("Settings", comment: "Settings button view"), systemImage: "gear.circle.fill")})
            }
        
        }
    
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
