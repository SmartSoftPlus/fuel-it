//
//  SettingsView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 09/03/2022.
//

import SwiftUI

var petrolStationsRange = getRange()
var maxRange = 1.0

struct SettingsView: View {
    @State var sliderValue = petrolStationsRange
    @State var defaultFuel = getFuelType()
    @State var showNavBar = true
    var body: some View {
        ZStack {
        NavigationView {
            List {
                Text(NSLocalizedString("Buy us a gallon of petrol", comment: "Asking for small donate"))
                VStack {
                    Text("Station view radius")
                                    Slider(value: $sliderValue, in: 0.0...maxRange) {
                                        Text("Station view radius")
                                    } onEditingChanged: { editing in
                                        petrolStationsRange = sliderValue
                                        //save to file
                                        let filePath = getDocumentsDirectory().appendingPathComponent("slider.txt")
                                        let itemToWrite = String(petrolStationsRange)
                                        do {
                                            try itemToWrite.write(to: filePath, atomically: true, encoding: .utf8)
                                        }
                                        catch {
                                            
                                        }
                                    }
                    Text("\(String(format: "%.0f", sliderValue * 111.2)) km")
                }
                NavigationLink(destination: {
                    AddStationView()
                }) {
                    Text("Add station")
                }
                
                Picker("Default fuel type", selection: $defaultFuel) {
                    Text("PB95").tag(0)
                    Text("PB98").tag(1)
                    Text("Diesel").tag(2)
                    Text("LPG").tag(3)
                }
            }
                    
            .navigationTitle(NSLocalizedString("Settings", comment: "Settings panel name"))
        }
        .navigationBarHidden(true)
        .onDisappear() {
            //save fuel type to file
            let filePath = getDocumentsDirectory().appendingPathComponent("fuelPicker.txt")
            let itemToWrite = String(defaultFuel)
            do {
                try itemToWrite.write(to: filePath, atomically: true, encoding: .utf8)
            }
            catch {
                
            }
        }
        }
    }
}
