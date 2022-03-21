//
//  SettingsView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 09/03/2022.
//

import SwiftUI

var petrolStationsRange = 0.3
var maxRange = 1.0

struct SettingsView: View {
    @State var sliderValue = 0.3
    var body: some View {
        NavigationView {
            List {
                Text(NSLocalizedString("Buy us a gallon of petrol", comment: "Asking for small donate"))
                VStack {
                    Text("Station view radius")
                                    Slider(value: $sliderValue, in: 0.0...maxRange) {
                                        Text("Station view radius")
                                    } onEditingChanged: { editing in
                                        petrolStationsRange = sliderValue
                                    }
                    Text("\(String(format: "%.0f", sliderValue * 111.2)) km")
                }
                Text("Add station")
                Text("Default fuel type")
            }
            .navigationTitle(NSLocalizedString("Settings", comment: "Settings panel name"))
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
