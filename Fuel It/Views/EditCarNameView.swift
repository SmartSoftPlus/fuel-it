//
//  EditCarNameView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 24/05/2022.
//

import SwiftUI

struct EditCarNameView: View {
    @State var carName = getProperCarName()
    @State var carProductionYear = getProperYear()
    @State var showPreviousView = false
    var body: some View {
            VStack(spacing: 15) {
                TextField(LocalizedStringKey("Car name"), text: $carName).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField(LocalizedStringKey("Production year"), text: $carProductionYear).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.decimalPad)
                Button {
                    writeCarNameToFile(carName: carName, carProductionYear: carProductionYear)
                    showPreviousView.toggle()
                } label: {
                    Text(LocalizedStringKey("Submit"))
                        .fontWeight(.bold)
                }
                NavigationLink(isActive: $showPreviousView) {
                    CarPanelView()
                } label: {
                    Text("")
                }

            }
            .padding()
            
            .navigationTitle(LocalizedStringKey("Edit car properties"))
    }
}
