//
//  StationDetailView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 12/03/2022.
//

import SwiftUI

struct StationDetailView: View {
    
    @State var station: PetrolStation
    @State var showHome = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text(getProperStationName(station))
                        .bold()
                        .font(.system(size: 20))
                    
                            VStack(spacing: 15) {
                                List {
                                    Label(LocalizedStringKey(String(station.pb95) + " PLN"), systemImage: "fuelpump.fill").accentColor(.green)
                                    Label(LocalizedStringKey(String(station.oil) + " PLN"), systemImage: "fuelpump.fill").accentColor(.black)
                                    Label(LocalizedStringKey(String(station.pb98) + " PLN"), systemImage: "fuelpump.fill").accentColor(.mint)
                                    Label(LocalizedStringKey(String(station.lpg) + " PLN"), systemImage: "fuelpump.fill").accentColor(.blue)
                                }
                            NavigationLink(destination: EditFuelPricesView(station: station)) {
                                Text(NSLocalizedString("Update fuel prices", comment: "Update fuel prices button"))
                            }
                            }
                }
                .padding(.top, -30)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        
    }
    
    
}
