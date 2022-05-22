//
//  PetrolStationController.swift
//  Fuel It
//
//  Created by Jakub Chojak on 29/03/2022.
//

import Foundation
import MapKit
import Firebase

func findArrayItem(petrolStationID: Int) -> Int{
    var i = 0
    for station in petrolStations {
        if station.id == petrolStationID {
            return i
        }
        i += 1
    }
    return 3000
}


func addStation(brand: String, description: String) {
    let uniqueID = UUID()
    let userLocation = CLLocationManager().location?.coordinate
    let longitude = userLocation?.longitude ?? 0.0
    let latitude = userLocation?.latitude ?? 0.0
    if longitude == 0.0, latitude == 0.0 {
        return
    }
    Firestore.firestore().collection("newStations").document(uniqueID.description).setData([
        "brand": brand,
        "description": description,
        "longitude": longitude,
        "latitude": latitude,
    ]) { err in
        if let err = err {
            print(err)
        }
    
    }
}

func getFuelType() -> Int {
    let filePath = getDocumentsDirectory().appendingPathComponent("fuelPicker.txt")
    var data: String?
    do {
        data = try String(contentsOf: filePath)
    }
    catch {
        
    }
    var retVal = 0
    if let fileData = data {
        retVal = Int(fileData) ?? 0
    }
    return retVal
}

func getRange() -> Double {
    let filePath = getDocumentsDirectory().appendingPathComponent("slider.txt")
    var data: String?
    do {
        data = try String(contentsOf: filePath)
    }
    catch {
        
    }
    var retVal = 0.15
    if let fileData = data {
        retVal = Double(fileData) ?? 0.15
    }
    return retVal
}

func openAppleMaps(_ station: PetrolStation) {
    let placemark = MKPlacemark(coordinate: station.locationCords)
    let mapItemToOpen = MKMapItem(placemark: placemark)
    mapItemToOpen.name = station.brand
    mapItemToOpen.openInMaps()
}

func getProperStationName(_ station: PetrolStation) -> String {
    if station.brand.contains("ORLEN") {
        return "Orlen"
    }
    if station.brand.contains("LUKOIL") {
        return "Amic"
    }
    if station.brand.contains("SHELL") {
        return "Shell"
    }
    if station.brand.contains("CIRCLE K") {
        return "Circle K"
    }
    if station.brand.contains("INTERMARCHE") {
        return "Intermarche"
    }
    if station.brand.contains("BP ") {
        return "BP"
    }
    return station.brand
}

func getBestPricesInNearby() -> [PetrolStation] {
    var bestPrices = [Double]()
    var ids = [Int]()
    for _ in 0...3 {
        bestPrices.append(2147)
        ids.append(1)
    }
    for station in petrolStations {
        if station.pb95 > 0.0 && station.pb95 < bestPrices[0] {
            bestPrices[0] = station.pb95
            ids[0] = station.id
        }
        if station.pb98 > 0.0 && station.pb98 < bestPrices[1] {
            bestPrices[1] = station.pb98
            ids[1] = station.id
        }
        if station.oil > 0.0 && station.oil < bestPrices[2] {
            bestPrices[2] = station.oil
            ids[2] = station.id
        }
        if station.lpg > 0.0 && station.lpg < bestPrices[3] {
            bestPrices[3] = station.lpg
            ids[3] = station.id
        }
    }
    var fuelStations = [PetrolStation]()
    for i in 0...3 {
        if findArrayItem(petrolStationID: ids[i]) != 3000 {
            fuelStations.append(petrolStations[findArrayItem(petrolStationID: ids[i])])

        }
        else {
            if petrolStations.count > 0 {
                fuelStations.append(petrolStations[0])
            }
        }
    }
    return fuelStations
}
