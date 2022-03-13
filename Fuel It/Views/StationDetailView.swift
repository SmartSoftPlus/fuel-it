//
//  StationDetailView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 12/03/2022.
//

import SwiftUI

struct StationDetailView: View {
    
    var station: PetrolStation
    @State var showHome = false
    
    var body: some View {
        if !showHome {
            NavigationView {
                VStack {
                    Text(station.brand)
                        .bold()
                        .font(.system(size: 36))
                    Text(station.description)
                    if station.checkFuelPricesOnServer() {
                        if station.availibleFuels[0] {
                            HStack {
                                Text(String(station.pb95))
                            }
                        }
                        if station.availibleFuels[2] {
                            HStack {
                                Text(String(station.oil))
                            }
                        }
                    }
                    NavigationView {
                        NavigationLink(destination: EditFuelPricesView(station: station)) {
                            Text(NSLocalizedString("Update fuel prices", comment: "Update fuel prices button"))
                        }
                    }
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            showHome = true
                        } label: {
                            Text("Back")
                                .multilineTextAlignment(.leading)
                        }
                    }
                    
                }
            }
            
        }
        else {
            HomeView()
        }
        
    }
}

//struct StationDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        StationDetailView(station: <#T##PetrolStation#>)
//    }
//}
