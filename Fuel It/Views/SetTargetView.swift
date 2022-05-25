//
//  SetTargetView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 24/05/2022.
//

import SwiftUI

struct SetTargetView: View {
    @State var targetMoney = getTargetMoney()
    @State var showPreviousView = false
    var body: some View {
        VStack(spacing: 15) {
            Text("Set your target for all car costs")
                .foregroundColor(.red)
            TextField(LocalizedStringKey("Target"), text: $targetMoney).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.decimalPad)
            Button {
                writeTargetMoneyToFile(targetMoney: targetMoney)
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
        
        .navigationTitle("Set target")
    }
}
