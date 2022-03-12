//
//  NearbyView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 09/03/2022.
//

import SwiftUI

struct NearbyView: View {
    var body: some View {
        NavigationView {
            List {
                        HStack {
                            Label("", systemImage: "bolt.car.circle.fill")
                            Text("Orlen")
                            Text("PB95")
                            Text("6.80 PLN")
                        }
            }
            .navigationTitle(NSLocalizedString("Best deals", comment: "The best deals for fuel in the nearby"))
        }
        
        
    }
}

struct NearbyView_Previews: PreviewProvider {
    static var previews: some View {
        NearbyView()
    }
}
