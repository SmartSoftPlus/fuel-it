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
                                            Text("Diesel")
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
