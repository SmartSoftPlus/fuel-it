//
//  NearbyView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 09/03/2022.
//

import SwiftUI
import MapKit

struct NearbyView: View {
    
    @State var bestDeals = [PetrolStation]()
    
    var body: some View {
        NavigationView {
            List {
                if bestDeals.count == 4 {
                    if bestDeals[0].pb95 > 0.0 {
                                        HStack {
                                            Label("", systemImage: "fuelpump.fill").accentColor(.green)
                                            Text(getProperStationName(bestDeals[0]))
                                            Text("PB95")
                                            Text(String(bestDeals[0].pb95))
                                            Text("PLN")
                                            Button {
                                                openAppleMaps(bestDeals[0])
                                            } label: {
                                                Text(">")
                                            }
                                        }
                                    }
                    if bestDeals[1].pb98 > 0.0 {
                                        HStack {
                                            Label("", systemImage: "fuelpump.fill").accentColor(.mint)
                                            Text(getProperStationName(bestDeals[1]))
                                            Text("PB98")
                                            Text(String(bestDeals[1].pb98))
                                            Text("PLN")
                                            Button {
                                                openAppleMaps(bestDeals[1])
                                            } label: {
                                                Text(">")
                                            }
                                        }
                                    }
                    if bestDeals[2].oil > 0.0 {
                                        HStack {
                                            Label("", systemImage: "fuelpump.fill").accentColor(.black)
                                            Text(getProperStationName(bestDeals[2]))
                                            Text("ON")
                                            Text(String(bestDeals[2].oil))
                                            Text("PLN")
                                            Button {
                                                openAppleMaps(bestDeals[2])
                                            } label: {
                                                Text(">")
                                            }
                                        }
                                    }
                    if bestDeals[3].lpg > 0.0 {
                                        HStack {
                                            Label("", systemImage: "fuelpump.fill").accentColor(.blue)
                                            Text(getProperStationName(bestDeals[3]))
                                            Text("LPG")
                                            Text(String(bestDeals[3].lpg))
                                            Text("PLN")
                                            Button {
                                                openAppleMaps(bestDeals[3])
                                            } label: {
                                                Text(">")
                                            }
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
        return "Lukoil"
    }
    if station.brand.contains("SHELL") {
        return "Shell"
    }
    if station.brand.contains("CIRCLE K") {
        return "Circle K"
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
