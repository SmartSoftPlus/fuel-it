//
//  PetrolStation.swift
//  Fuel It
//
//  Created by Jakub Chojak on 12/03/2022.
//

import Foundation
import MapKit
import Firebase
import simd


struct PetrolStation: Identifiable, Codable  {
    let uniqueID = UUID()
    var id: Int
    var brand: String
    var description: String
    var availibleFuels: [Bool]
    var cng: Double
    var electricity: Double
    var locationCords: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    var latitude: Double
    var longitude: Double
    var lpg: Double
    var oil: Double
    var pb95: Double
    var pb98: Double
    
    func updatePricesOnServer() -> Bool {
        Firestore.firestore().collection("stations").document(String(id)).setData([
            "pb95": pb95,
            "pb98": pb98,
            "oil": oil,
            "lpg": lpg
        ]) { err in
            if let err = err {
                print(err)
            }
        }
        return true
    }
}


func getFuelPrice(id: Int) {
    let docRef = Firestore.firestore().collection("stations").document(String(id))
    docRef.getDocument { document, err in
        if let document = document, document.exists {
            let data = document.data()
            if let price = data!["pb95"] as? Double {
                if price > 0.0 {
                    print(price)
                    petrolStations[id - 1].pb95 = price
                }
            }
            if let price = data!["pb98"] as? Double {
                if price > 0.0 {
//                    pb98Price = price
                    petrolStations[id - 1].pb98 = price
                }
            }
            if let price = data!["oil"] as? Double {
                if price > 0.0 {
//                    motorOilPrice = price
                    petrolStations[id - 1].oil = price
                }
            }
            if let price = data!["lpg"] as? Double {
                if price > 0.0 {
//                    lpgPrice = price
                    petrolStations[id - 1].lpg = price
                }
            }
        }
    }
}
