//
//  ContentView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 09/03/2022.
//

import SwiftUI
import CoreData
import MapKit

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var notificationManager = LocalNotificationManager()
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {Label(NSLocalizedString("Home", comment: "Homepage"), systemImage: "house.fill")}
            NearbyView()
                .tabItem({Label(NSLocalizedString("Best fuel deals", comment: "Best fuel deals view button"), systemImage: "giftcard.fill")})
            SettingsView()
                .tabItem({Label(NSLocalizedString("Settings", comment: "Settings button view"), systemImage: "gear.circle.fill")})
            
                .onChange(of: scenePhase) { newPhase in
                    if newPhase == .background {
                        print("AAA")
                        let bestStationsInTheNearby = getBestPricesInNearby()
                        let chosenFuel = getFuelType()
                        print(chosenFuel, bestStationsInTheNearby)
                        notificationManager.sendNotification(title: "Station", subtitle: nil, body: getProperStationName(bestStationsInTheNearby[chosenFuel]), coords: bestStationsInTheNearby[chosenFuel].locationCords)
                    }
                }
            }
        
        }
    
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
