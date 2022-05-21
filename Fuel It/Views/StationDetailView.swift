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
            VStack {
                Text(getProperStationName(station))
                    .bold()
                    .font(.system(size: 20))
                Text(station.description)
                List {
                    HStack {
                        Label(LocalizedStringKey(String(station.pb95) + " PLN"), systemImage: "fuelpump.fill").accentColor(.green)
                    }
                    HStack {
                        Label(LocalizedStringKey(String(station.oil) + " PLN"), systemImage: "fuelpump.fill").accentColor(.black)
                    }
                    HStack {
                        Label(LocalizedStringKey(String(station.pb98) + " PLN"), systemImage: "fuelpump.fill").accentColor(.mint)
                    }
                    HStack {
                        Label(LocalizedStringKey(String(station.lpg) + " PLN"), systemImage: "fuelpump.fill").accentColor(.blue)
                    }
                }
                .padding()
                
            }
            .padding()
            
        }
        .toolbar {
            NavigationLink(destination: EditFuelPricesView(station: station)) {
                Text(NSLocalizedString("Update fuel prices", comment: "Update fuel prices button"))
            }
        }
        Spacer()
        
    }
    
}
