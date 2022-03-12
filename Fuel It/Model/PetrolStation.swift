//
//  PetrolStation.swift
//  Fuel It
//
//  Created by Jakub Chojak on 12/03/2022.
//

import Foundation
import MapKit


struct PetrolStation: Codable {
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
}
