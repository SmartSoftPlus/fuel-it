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
            Text(NSLocalizedString("Station will be added based on place you are currently in", comment: "Warn user about getting it's location")).foregroundColor(Color.red).multilineTextAlignment(.center)
            VStack(spacing: 15) {
                TextField(LocalizedStringKey("Brand"), text: $stationBrand).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField(LocalizedStringKey("Description"), text: $stationDescription).textFieldStyle(RoundedBorderTextFieldStyle())
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
                Text("Add station").fontWeight(.bold)
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
