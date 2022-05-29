//
//  CarHistory.swift
//  Fuel It
//
//  Created by Jakub Chojak on 29/05/2022.
//

import Foundation

class CarHistory : Identifiable {
    var id: UUID = UUID()
    var distance = 0
    var litresRefilled = 0.0
    var litreCost = 0.0
    
    func getRefuelementTotalPrice() -> Double {
        return litresRefilled * litreCost
    }
}

func formatCarHistory(history: [String]) -> [CarHistory] {
    var retVal: [CarHistory] = []
    var i = 0
    while i < history.count {
        let item = CarHistory()
        item.distance = Int(history[i]) ?? 0
        item.litresRefilled = Double(history[i + 1]) ?? 0.0
        item.litreCost = Double(history[i + 2]) ?? 0.0
        retVal.append(item)
        i += 3
    }
    return retVal
}
