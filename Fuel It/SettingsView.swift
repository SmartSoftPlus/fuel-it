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
                Text("Donate us 1$!")
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
