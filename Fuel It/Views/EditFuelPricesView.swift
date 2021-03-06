//
//  EditFuelPricesView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 12/03/2022.
//

import SwiftUI

struct EditFuelPricesView: View {
    
    @State var station: PetrolStation
    @State var isActive = false
    @State var pb95Price = 0.0
    @State var oilPrice = 0.0
    @State var pb98Price = 0.0
    @State var lpgPrice = 0.0
    @State var canSeeDismissButton = true
    @State var showAlert = false
    
    var body: some View {
        VStack(spacing: 15) {
                List {
                    HStack {
                                    Label("", systemImage: "fuelpump.fill").accentColor(.green)
                                    TextField(NSLocalizedString("PB95 price", comment: "PB95 fuel price"), value: $pb95Price, format: .number)
                                        .keyboardType(.decimalPad)
                                }
                    HStack {
                        Label("", systemImage: "fuelpump.fill").accentColor(.black)
                        TextField(NSLocalizedString("Diesel price", comment: "Oil fuel price"), value: $oilPrice, format: .number)
                                                        .keyboardType(.decimalPad)
                    }
                    HStack {
                        Label("", systemImage: "fuelpump.fill").accentColor(.mint)
                        TextField(NSLocalizedString("PB98 price", comment: "PB98 fuel price"), value: $pb98Price, format: .number)
                                                        .keyboardType(.decimalPad)
                    }
                    HStack {
                        Label("", systemImage: "fuelpump.fill").accentColor(.blue)
                        TextField(NSLocalizedString("LPG price", comment: "LPG fuel price"), value: $lpgPrice, format: .number)
                                                        .keyboardType(.decimalPad)
                    }
                }
                Button(NSLocalizedString("Submit", comment: "Submit an action")) {
                    var hasChanged = false
                    if pb95Price > 0.0 {
                        station.pb95 = pb95Price
                        hasChanged = true
                    }
                    if oilPrice > 0.0 {
                        station.oil = oilPrice
                        hasChanged = true
                    }
                    if pb98Price > 0.0 {
                        station.pb98 = pb98Price
                        hasChanged = true
                    }
                    if lpgPrice > 0.0 {
                        station.lpg = lpgPrice
                        hasChanged = true
                    }
                    if hasChanged {
                        isActive = station.updatePricesOnServer()
                    }
                    showAlert.toggle()
                }
                .alert("Thanks for contributing!", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {
                    }
                }
                if canSeeDismissButton {
                    Button {
                        canSeeDismissButton = false
                        station.markedAsUnavailible += 1
                        retrieveMarks(id: station.id)
                        isActive = true
                    } label: {
                        Text("Mark as closed")
                    }
                }
            }
            Spacer()
        .navigationBarHidden(!canSeeDismissButton)
        .onAppear() {
            getFuelPrice(id: station.id)
        }
    }
}
