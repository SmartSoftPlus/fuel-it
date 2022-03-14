//
//  ObserveStationViewModel.swift
//  Fuel It
//
//  Created by Jakub Chojak on 13/03/2022.
//

import Foundation

class ObserverStationViewModel: ObservableObject {
    @Published var stations = [PetrolStation]()
}
