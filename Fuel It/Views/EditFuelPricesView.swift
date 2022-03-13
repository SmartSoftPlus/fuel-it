//
//  EditFuelPricesView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 12/03/2022.
//

import SwiftUI

struct EditFuelPricesView: View {
    
    @State var station: PetrolStation
    @State var pb95Price = 0.0
    @State var oilPrice = 0.0
    
    var body: some View {
        VStack {
            TextField(NSLocalizedString("PB95 price", comment: "PB95 fuel price"), value: $pb95Price, format: .number)
            TextField(NSLocalizedString("Oil price", comment: "Oil fuel price"), value: $oilPrice, format: .number)
            Button(NSLocalizedString("Submit", comment: "Submit an action")) {
                var hasChanged = false
                if pb95Price > 0.0 {
                    station.pb95 = pb95Price
                    hasChanged = true
                }
                if oilPrice > 0.0 {
                    station.oil = oilPrice
                    hasChanged = true
                }
                if hasChanged {
                    station.updatePricesOnServer()
                }
                NavigationLink(destination: StationDetailView(station: station)) {EmptyView()}
            }
        }
        
    }
}

//struct EditFuelPricesView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditFuelPricesView(station: <#PetrolStation#>)
//    }
//}

