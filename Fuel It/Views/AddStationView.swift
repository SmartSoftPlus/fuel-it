//
//  AddStationView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 24/03/2022.
//

import SwiftUI
import Firebase
import MapKit

struct AddStationView: View {
    @State var stationBrand = ""
    @State var stationDescription = ""
    @State var isActive = false
    @State var showAlert = false
    @State var showErrorAlert = false
    var body: some View {
        VStack {
            VStack {
                TextField(LocalizedStringKey("Brand"), text: $stationBrand)
                TextField(LocalizedStringKey("Description"), text: $stationDescription)
            }
            .padding()            
            NavigationLink(isActive: $isActive) {
                SettingsView(showNavBar: true)
            } label: {
                Text("")
            }
            .navigationBarBackButtonHidden(showAlert)
            Button {
                if stationBrand != "", stationDescription != "" {
                    addStation(brand: stationBrand, description: stationDescription)
                    showAlert = true
                }
                else {
                    showErrorAlert = true
                }
                
            } label: {
                Text("Add station")
            }
            .alert("Successfully added station! Thank you for contributing", isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    isActive = true
                }
            }
            .alert("Something is missing in form", isPresented: $showErrorAlert) {
                Button("Let me check that", role: .cancel) {}
            }
            
            .navigationTitle("Add station")
            
        }
        .padding()
    }
}
