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
    var uniqueID = UUID()
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
    
    var markedAsUnavailible: Int = 0
    
    var howFarFromUser: Double = 0.0
    
    func getProperFuelPrice(fuelType: Int) -> Double{
        switch fuelType {
        case 0:
            return pb95
        case 1:
            return pb98
        case 2:
            return oil
        case 3:
            return lpg
        default:
            return pb95
        }
    }
    
    func updatePricesOnServer() -> Bool {
        let docRef = Firestore.firestore().collection("stations").document(String(id))
        docRef.getDocument { document, err in
            if let document = document, document.exists {
                let data = document.data()
                var mkrs = 0
                if var marks = data!["notExistMarks"] as? Int {
                    if marks > 0 {
                        mkrs = marks
                    }
                    else {
                        marks = 0
                    }
                        
                    }
                Firestore.firestore().collection("stations").document(String(id)).setData([
                    "pb95": pb95,
                    "pb98": pb98,
                    "oil": oil,
                    "lpg": lpg,
                    "notExistMarks": mkrs,
                ]) { err in
                    if let err = err {
                        print(err)
                    }
                
                }
            
            }
            else {
                Firestore.firestore().collection("stations").document(String(id)).setData([
                    "pb95": pb95,
                    "pb98": pb98,
                    "oil": oil,
                    "lpg": lpg,
                    "notExistMarks": 0,
                ]) { err in
                    if let err = err {
                        print(err)
                    }
            }
            
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
                    petrolStations[findArrayItem(petrolStationID: id)].pb95 = price
                }
            }
            if let price = data!["pb98"] as? Double {
                if price > 0.0 {
//                    pb98Price = price
                    petrolStations[findArrayItem(petrolStationID: id)].pb98 = price
                }
            }
            if let price = data!["oil"] as? Double {
                if price > 0.0 {
//                    motorOilPrice = price
                    petrolStations[findArrayItem(petrolStationID: id)].oil = price
                }
            }
            if let price = data!["lpg"] as? Double {
                if price > 0.0 {
//                    lpgPrice = price
                    petrolStations[findArrayItem(petrolStationID: id)].lpg = price
                }
            }
            if let marks = data!["notExistMarks"] as? Int {
                if marks > 0 {
//                    lpgPrice = price
                    petrolStations[findArrayItem(petrolStationID: id)].markedAsUnavailible = marks
                }
                else {
                    petrolStations[findArrayItem(petrolStationID: id)].markedAsUnavailible = 0
                }
                writeMarksLocally(id: id)
            }
        }
    }
}

func getMarks(id: Int) -> Int {
    var retVal = 0
    let docRef = Firestore.firestore().collection("stations").document(String(id))
    docRef.getDocument { document, err in
        if let document = document, document.exists {
            let data = document.data()
            if let marks = data!["notExistMarks"] as? Int {
                if marks > 0 {
                    retVal = marks
                }
            }
        }
    }
    return retVal
}


func retrieveMarks(id: Int) {
    let docRef = Firestore.firestore().collection("stations").document(String(id))
    docRef.getDocument { document, err in
        if let document = document, document.exists {
            let data = document.data()
            if let marks = data!["notExistMarks"] as? Int {
                updateMarks(amount: marks + 1, id: id)
                petrolStations[findArrayItem(petrolStationID: id)].markedAsUnavailible = marks + 1
            }
            else {
                updateMarks(amount: 1, id: id)
                petrolStations[findArrayItem(petrolStationID: id)].markedAsUnavailible = 1
            }
            writeMarksLocally(id: id)
        }
    }
}

func writeMarksLocally(id: Int) {
    var itemToWrite = ""
    let filePath = getDocumentsDirectory().appendingPathComponent("marks.txt")
    var data: String?
    do {
        data = try String(contentsOf: filePath)
    }
    catch {
        
    }
    if let docData = data {
        let fileLines = docData.components(separatedBy: .newlines)
        for singleLine in fileLines {
            var lineContents = singleLine.components(separatedBy: ";")
            if Int(lineContents[0]) == id {
                lineContents[1] = String(petrolStations[findArrayItem(petrolStationID: id)].markedAsUnavailible)
            }
            print(lineContents)
            if lineContents.count >= 2 {
                itemToWrite += "\(lineContents[0]);\(lineContents[1])\n"
            }
        }
    }
    
        do {
            try itemToWrite.write(to: filePath, atomically: true, encoding: .utf8)
        }
        catch {
            
        }
}

func updateMarks(amount: Int, id: Int) {
    Firestore.firestore().collection("stations").document(String(id)).updateData([
        "notExistMarks": amount
    ]) { err in
        if let err = err {
            print(err)
        }
    }
}
