//
//  SettingsView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 09/03/2022.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                Text(NSLocalizedString("Donate us 1$!", comment: "Asking for small donate"))
            }
            .navigationTitle(NSLocalizedString("Settings", comment: "Settings panel name"))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
