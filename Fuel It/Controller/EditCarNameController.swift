//
//  EditCarNameController.swift
//  Fuel It
//
//  Created by Jakub Chojak on 24/05/2022.
//

import Foundation
import SwiftUI

func getProperCarName() -> String {
    let filePath = getDocumentsDirectory().appendingPathComponent("carProperties.txt")
    var data: String?
    do {
        data = try String(contentsOf: filePath)
    }
    catch {
        
    }
    if let docData = data {
        let fileLines = docData.components(separatedBy: ";")
        return String(fileLines[0])
    }
    return "No car provided"
}

func getProperYear() -> String {
    let filePath = getDocumentsDirectory().appendingPathComponent("carProperties.txt")
    var data: String?
    do {
        data = try String(contentsOf: filePath)
    }
    catch {
        
    }
    if let docData = data {
        let fileLines = docData.components(separatedBy: ";")
        return String(fileLines[1])
    }
    return ""
}

func writeCarNameToFile(carName: String, carProductionYear: String) {
    let filePath = getDocumentsDirectory().appendingPathComponent("carProperties.txt")
    let itemToWrite = carName + ";" + carProductionYear
    do {
        try itemToWrite.write(to: filePath, atomically: true, encoding: .utf8)
    }
    catch {
        
    }
}

func getTargetMoney() -> String {
    let filePath = getDocumentsDirectory().appendingPathComponent("carMoney.txt")
    var data: String?
    do {
        data = try String(contentsOf: filePath)
    }
    catch {
        
    }
    if let docData = data {
        let fileLines = docData.components(separatedBy: ";")
        return String(fileLines[0])
    }
    return ""
}

func writeTargetMoneyToFile(targetMoney: String) {
    let filePath = getDocumentsDirectory().appendingPathComponent("carMoney.txt")
    let itemToWrite = targetMoney
    do {
        try itemToWrite.write(to: filePath, atomically: true, encoding: .utf8)
    }
    catch {
        
    }
}

func getCarHistory() -> [String] {
    let filePath = getDocumentsDirectory().appendingPathComponent("carHistory.txt")
    var data: String?
    do {
        data = try String(contentsOf: filePath)
    }
    catch {
        
    }
    var retArray:[String] = []
    if let docData = data {
        let fileLines = docData.components(separatedBy: .newlines)
        for singleLine in fileLines {
            let lineContents = singleLine.components(separatedBy: ";")
            for lineItem in lineContents {
                retArray.append(lineItem.replacingOccurrences(of: ",", with: "."))
            }
        }
    }
    if retArray.count > 1 {
        retArray.remove(at: 0)
    }
    return retArray
}

func getCarHistoryToFileWrite() -> String {
    let filePath = getDocumentsDirectory().appendingPathComponent("carHistory.txt")
    var data: String?
    do {
        data = try String(contentsOf: filePath)
    }
    catch {
        
    }
    if let docData = data {
        return docData
    }
    return ""
}

func writeCarHistory(distance: String, fuelFilled: String, fuelLitreCost: String) {
    let carHistory = getCarHistoryToFileWrite()
    let stringToWrite = carHistory + "\n" + distance + ";" + fuelFilled + ";" + fuelLitreCost
    let filePath = getDocumentsDirectory().appendingPathComponent("carHistory.txt")
    let itemToWrite = stringToWrite
    do {
        try itemToWrite.write(to: filePath, atomically: true, encoding: .utf8)
    }
    catch {
        
    }
}

func getSpendingsLimiter() -> Int {
    let filePath = getDocumentsDirectory().appendingPathComponent("carLimit.txt")
    var data: String?
    do {
        data = try String(contentsOf: filePath)
    }
    catch {
        
    }
    if let docData = data {
        return Int(docData) ?? 2
    }
    return 2
}

func writeSpendingsLimiter() {
    let limit = String(getCarHistory().count + 2)
    let filePath = getDocumentsDirectory().appendingPathComponent("carLimit.txt")
    let itemToWrite = limit
    do {
        try itemToWrite.write(to: filePath, atomically: true, encoding: .utf8)
    }
    catch {
        
    }
}
