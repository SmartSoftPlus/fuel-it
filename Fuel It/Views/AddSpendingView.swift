//
//  AddSpendingView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 24/05/2022.
//

import SwiftUI

struct AddSpendingView: View {
    @State var distance = ""
    @State var fuelFilled = ""
    @State var fuelCostPerLitre = ""
    @State var showPreviousView = false
    var body: some View {
        VStack(spacing: 15) {
            TextField("Distance on meter", text: $distance).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.decimalPad)
            TextField("Litres you refueled", text: $fuelFilled).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.decimalPad)
            TextField("Litre cost", text: $fuelCostPerLitre).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.decimalPad)
            Button {
                writeCarHistory(distance: distance, fuelFilled: fuelFilled, fuelLitreCost: fuelCostPerLitre)
                showPreviousView.toggle()
            } label: {
                Text("Submit")
                    .fontWeight(.bold)
            }
            NavigationLink(isActive: $showPreviousView) {
                CarPanelView()
            } label: {
                Text("")
            }

        }
        .padding()
        
        .navigationTitle("Add spending")
    }
}
