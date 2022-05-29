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
    @State var iconSize = 50.0
    
    var body: some View {
            VStack(spacing: 15) {
                Text("Best deals")
                    .fontWeight(.bold)
                    .font(.system(size: 36))
                    .multilineTextAlignment(.leading)
                if bestDeals.count == 4 {
                    HStack {
                        if bestDeals[0].pb95 > 0.0 {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .foregroundColor(Color("launchScreenColorSet"))
                                VStack(spacing: 10) {
                                                Label("", systemImage: "fuelpump.fill")
                                                    .foregroundColor(.green)
                                                    .font(.system(size: iconSize))
                                                    .padding(.trailing, -19)
                                                Text("PB95").fontWeight(.bold)
                                                Text(getProperStationName(bestDeals[0]))
                                                Text(String(bestDeals[0].pb95) + "zł")
                                                Button {
                                                    openAppleMaps(bestDeals[0])
                                                } label: {
                                                    Label("", systemImage: "forward.fill")
                                                        .padding(.trailing, -10)
                                                }
                                            }
                            }
                                        }
                        if bestDeals[1].pb98 > 0.0 {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .foregroundColor(Color("launchScreenColorSet"))
                                            VStack(spacing: 10) {
                                                Label("", systemImage: "fuelpump.fill")
                                                    .foregroundColor(.mint)
                                                    .font(.system(size: iconSize))
                                                    .padding(.trailing, -19)
                                                Text("PB98").fontWeight(.bold)
                                                Text(getProperStationName(bestDeals[1]))
                                                Text(String(bestDeals[1].pb98) + "zł")
                                                Button {
                                                    openAppleMaps(bestDeals[1])
                                                } label: {
                                                    Label("", systemImage: "forward.fill")
                                                        .padding(.trailing, -10)
                                                }
                                            }
                                        }
                        }
                    }
                    HStack {
                        if bestDeals[2].oil > 0.0 {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .foregroundColor(Color("launchScreenColorSet"))
                                            VStack(spacing: 10) {
                                                Label("", systemImage: "fuelpump.fill")
                                                    .foregroundColor(.black)
                                                    .font(.system(size: iconSize))
                                                    .padding(.trailing, -19)
                                                Text("Diesel").fontWeight(.bold)
                                                Text(getProperStationName(bestDeals[2]))
                                                Text(String(bestDeals[2].oil) + "zł")
                                                Button {
                                                    openAppleMaps(bestDeals[2])
                                                } label: {
                                                    Label("", systemImage: "forward.fill")
                                                        .padding(.trailing, -10)
                                                }
                                            }
                            }
                                        }
                        if bestDeals[3].lpg > 0.0 {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .foregroundColor(Color("launchScreenColorSet"))
                                            VStack(spacing: 10) {
                                                Label("", systemImage: "fuelpump.fill")
                                                    .foregroundColor(.blue)
                                                    .font(.system(size: iconSize))
                                                    .padding(.trailing, -19)
                                                Text("LPG").fontWeight(.bold)
                                                Text(getProperStationName(bestDeals[3]))
                                                Text(String(bestDeals[3].lpg) + "zł")
                                                Button {
                                                    openAppleMaps(bestDeals[3])
                                                } label: {
                                                    Label("", systemImage: "forward.fill")
                                                        .padding(.trailing, -10)
                                                }
                                            }
                                        }
                        }
                    }
                    
                }
                
            }
            .padding()
        .onAppear(perform: {
            bestDeals = getBestPricesInNearby()
        })
    }

    
}
