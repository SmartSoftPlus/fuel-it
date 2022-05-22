//
//  CarPanelView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 22/05/2022.
//

import SwiftUI

struct CarPanelView: View {
    @State var sliderValue = 50.0
    @State var userCashTarget = 120.0
    @State var sliderColor: Color?
    @State var fuelConsumption = 7.1
    @State var avgCostPer100KM = 49.26
    @State var yearOfProduction = 2014
    @State var carDistance = 108409
    var body: some View {
        NavigationView {
            List {
                Text("Ford Ka")
                    .fontWeight(.bold)
                    .font(.system(size: 20.0))
                HStack {
                    Text("Production year: ")
                        .fontWeight(.bold)
                    Text("\(yearOfProduction)")
                }
                HStack {
                    Text("Distance: ")
                        .fontWeight(.bold)
                    Text("\(carDistance)km")
                }
                HStack {
                    Text("Avg. fuel consumption: ")
                        .fontWeight(.bold)
                    Text("\(String(format: "%.1f", fuelConsumption))l/100km")
                }
                HStack {
                    Text("Avg. 100km cost: ")
                        .fontWeight(.bold)
                    Text("\(String(format: "%.2f", avgCostPer100KM))PLN")
                }
                VStack {
                    Text("Total amount spend")
                        .fontWeight(.bold)
                    Slider(value: $sliderValue, in: 0...userCashTarget, label: {
                        Text("0PLN")
                    }, minimumValueLabel: {
                        Text("0PLN")
                    }, maximumValueLabel: {
                        Text("\(Int(userCashTarget))PLN")
                    })
                    .accentColor(sliderColor ?? .red)
                    HStack {
                        Text("\(Int(sliderValue))PLN")
                        Label("", systemImage: "dollarsign.circle.fill")
                            .foregroundColor(sliderColor ?? .red)
                    }
                    
                }
                Text("Set target")
                    .foregroundColor(.red)
                Text("See history")
                    .foregroundColor(.red)
                Text("Add spending")
                    .foregroundColor(.red)
            }
            .navigationTitle(NSLocalizedString("My car", comment: "Car panel"))
            
        }
        .onAppear {
            if sliderValue < 0.8 * userCashTarget {
                sliderColor = .green
            }
            else if sliderValue < userCashTarget {
                sliderColor = .yellow
            }
            else {
                sliderColor = .red
            }
        }
    }
        
}
