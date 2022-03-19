//
//  NearbyView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 09/03/2022.
//

import SwiftUI

struct NearbyView: View {
    
    @State var bestDeals = [PetrolStation]()
    
    var body: some View {
        NavigationView {
            List {
                if bestDeals.count == 4 {
                    if bestDeals[0].pb95 > 0.0 {
                                        HStack {
                                            Label("", systemImage: "fuelpump.fill").accentColor(.green)
                                            Text(bestDeals[0].brand)
                                            Text("PB95")
                                            Text(String(bestDeals[0].pb95))
                                            Text("PLN")
                                        }
                                    }
                    if bestDeals[1].pb98 > 0.0 {
                                        HStack {
                                            Label("", systemImage: "fuelpump.fill").accentColor(.mint)
                                            Text(bestDeals[1].brand)
                                            Text("PB98")
                                            Text(String(bestDeals[1].pb98))
                                            Text("PLN")
                                        }
                                    }
                    if bestDeals[2].oil > 0.0 {
                                        HStack {
                                            Label("", systemImage: "fuelpump.fill").accentColor(.black)
                                            Text(bestDeals[2].brand)
                                            Text("ON")
                                            Text(String(bestDeals[2].oil))
                                            Text("PLN")
                                        }
                                    }
                    if bestDeals[3].lpg > 0.0 {
                                        HStack {
                                            Label("", systemImage: "fuelpump.fill").accentColor(.blue)
                                            Text(bestDeals[3].brand)
                                            Text("LPG")
                                            Text(String(bestDeals[3].lpg))
                                            Text("PLN")
                                        }
                                    }
                }
                
                
            }
            .onAppear(perform: {
                bestDeals = getBestPricesInNearby()
            })
            .navigationTitle(NSLocalizedString("Best deals", comment: "The best deals for fuel in the nearby"))
        }
    }

    
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
            fuelStations.append(petrolStations[0])
        }
    }
    return fuelStations
}

struct NearbyView_Previews: PreviewProvider {
    static var previews: some View {
        NearbyView()
    }
}
