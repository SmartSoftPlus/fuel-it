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
    init() {
        //UITabBar.appearance().backgroundColor = UIColor(Color("launchScreenColorSet"))
    }
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var notificationManager = LocalNotificationManager()
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {Label(NSLocalizedString("Map", comment: "Map"), systemImage: "map.fill")}
            NearbyView()
                .tabItem({Label(NSLocalizedString("Best fuel deals", comment: "Best fuel deals view button"), systemImage: "giftcard.fill")})
            CarPanelView()
                .tabItem({Label(NSLocalizedString("My car", comment: "Car panel"), systemImage: "car.fill")})
            SettingsView()
                .tabItem({Label(NSLocalizedString("Settings", comment: "Settings button view"), systemImage: "gear.circle.fill")})
            
                .onChange(of: scenePhase) { newPhase in
                    if newPhase == .background {
                        let bestStationsInTheNearby = getBestPricesInNearby()
                        let chosenFuel = getFuelType()
                        let body = "\(getProperStationName(bestStationsInTheNearby[chosenFuel])): \(bestStationsInTheNearby[chosenFuel].getProperFuelPrice(fuelType: chosenFuel))zł"
                        notificationManager.sendNotification(title: "Station", subtitle: nil, body: body, coords: bestStationsInTheNearby[chosenFuel].locationCords)
                    }
                }
            }
        }
    
    }
