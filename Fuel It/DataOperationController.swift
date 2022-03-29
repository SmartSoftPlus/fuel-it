//
//  DataOperationController.swift
//  Fuel It
//
//  Created by Jakub Chojak on 29/03/2022.
//

import Foundation

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func checkIfFileExist() -> Bool {
    return true
}
