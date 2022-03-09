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
                .tabItem {Label("Home", systemImage: "house.fill")}
            NearbyView()
                .tabItem({Label("Best fuel deals", systemImage: "giftcard.fill")})
            SettingsView()
                .tabItem({Label("Settings", systemImage: "gear.circle.fill")})
            }
        }
    
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
