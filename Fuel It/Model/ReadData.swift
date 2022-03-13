//
//  ReadData.swift
//  Fuel It
//
//  Created by Jakub Chojak on 12/03/2022.
//

import Foundation

var petrolStations: [PetrolStation] = readFromFile()

func readFromFile() -> [PetrolStation] {
    var tmpStations = [PetrolStation]()
    let filePath = Bundle.main.path(forResource: "data", ofType: "txt")
    let data = try! String(contentsOfFile: filePath!)
    var fileLines = data.components(separatedBy: .newlines)
    fileLines.popLast()
    for singleLine in fileLines {
        let lineContents = singleLine.components(separatedBy: ";")
        print(lineContents)
        let tmpStationObject: PetrolStation = PetrolStation(id: Int(lineContents[0]) ?? 0, brand: lineContents[1], description: "", availibleFuels: getFuels(lineContents[2]), cng: 0.0, electricity: 0.0, latitude: Double(lineContents[3]) ?? 0.0, longitude: Double(lineContents[4]) ?? 0.0, lpg: 0.0, oil: 0.0, pb95: 0.0, pb98: 0.0)
        tmpStations.append(tmpStationObject)
    }
    return tmpStations
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
