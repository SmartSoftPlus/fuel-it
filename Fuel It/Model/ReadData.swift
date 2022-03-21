//
//  ReadData.swift
//  Fuel It
//
//  Created by Jakub Chojak on 12/03/2022.
//

import Foundation
import SwiftUI
import MapKit

var petrolStations: [PetrolStation] = readFromFile()

func readFromFile() -> [PetrolStation] {
    var tmpStations = [PetrolStation]()
    let filePath = Bundle.main.path(forResource: "data", ofType: "txt")
    let data = try! String(contentsOfFile: filePath!)
    var fileLines = data.components(separatedBy: .newlines)
    fileLines.popLast()
    let currUserPosition = CLLocationManager().location?.coordinate
    for singleLine in fileLines {
        let lineContents = singleLine.components(separatedBy: ";")
        let fromUserLength = getHowFarFromUser(lng: Double(lineContents[4]) ?? 0.0, lat: Double(lineContents[3]) ?? 0.0, currUserPosition: currUserPosition)
        if fromUserLength >= 0.0 && fromUserLength < petrolStationsRange {
            var tmpStationObject: PetrolStation = PetrolStation(id: Int(lineContents[0]) ?? 0, brand: lineContents[1], description: "", availibleFuels: getFuels(lineContents[2]), cng: 0.0, electricity: 0.0, latitude: Double(lineContents[3]) ?? 0.0, longitude: Double(lineContents[4]) ?? 0.0, lpg: 0.0, oil: 0.0, pb95: 0.0, pb98: 0.0)
            let marks = getMarks(id: tmpStationObject.id)
            let marksLocal = getLocalMarks(id: tmpStationObject.id)
            tmpStationObject.markedAsUnavailible = marks
            if marksLocal < 3 {
                    tmpStations.append(tmpStationObject)
            }
        }
        
    }
    return tmpStations
}

func getLocalMarks(id: Int) -> Int {
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
            let lineContents = singleLine.components(separatedBy: ";")
            if Int(lineContents[0]) == id {
                return Int(lineContents[1])!
            }
        }
    }
    return 0
}

func getHowFarFromUser(lng: Double, lat: Double, currUserPosition: CLLocationCoordinate2D?) -> Double{
    
    var howFar = -1.0
    if let currUserPosition = currUserPosition {
        howFar = sqrt(((lat - currUserPosition.latitude) * (lat - currUserPosition.latitude)) + ((lng - currUserPosition.longitude) * (lng - currUserPosition.longitude)))
    }
    return howFar
}

func getFuels(_ nums: String) -> [Bool] {
    var boolArr = [Bool]()
    for sign in nums {
        if sign == "0" {
            boolArr.append(false)
        }
        else {
            boolArr.append(true)
        }
    }
    return boolArr
}
