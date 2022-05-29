//
//  CarHistoryView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 29/05/2022.
//

import SwiftUI

struct CarHistoryView: View {
    var body: some View {
        
        let carHistory = getCarHistory()
        let formattedCarHistory: [CarHistory] = formatCarHistory(history: carHistory)
        VStack {
            List(formattedCarHistory) { item in
                HStack {
                    Text(String(item.distance) + "km")
                    Text(String(item.litresRefilled) + "l")
                    Text(String(item.litreCost) + "zł")
                    Text(String(format: "%.2f", item.getRefuelementTotalPrice()) + "zł")
                }
            }
            HStack {
                Text("Total spendings:")
                    .fontWeight(.bold)
                Text(String(format: "%.2f", getTotalSpendings()) + "zł")
            }
        }
        
        
        .navigationTitle("Car history")
        
    }
}

func getTotalSpendings() -> Double {
    let retTab = getCarHistory()
    var i = 2
    var costsSum = 0.0
    while i < retTab.count {
        let litres = Double(retTab[i - 1]) ?? 0.0
        let litrePrice = Double(retTab[i]) ?? 0.0
        costsSum += (litres * litrePrice)
        i += 3
    }
    return costsSum
}
