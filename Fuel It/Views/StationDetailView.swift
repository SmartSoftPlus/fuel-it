//
//  StationDetailView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 12/03/2022.
//

import SwiftUI

struct StationDetailView: View {
    
    var station: PetrolStation
    
    var body: some View {
        VStack {
            Text(station.brand)
                .bold()
                .font(.system(size: 36))
            Text(station.description)
            if station.availibleFuels[0] {
                HStack {
                    Text(String(station.pb95))
                }
            }
            if station.availibleFuels[1] {
                HStack {
                    Text(String(station.oil))
                }
            }
        }
    }
}

struct StationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StationDetailView(station: <#T##PetrolStation#>)
    }
}
