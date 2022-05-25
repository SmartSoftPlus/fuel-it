//
//  CarPanelView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 22/05/2022.
//

import SwiftUI

struct CarPanelView: View {
    @State var sliderValue = checkSlider()
    @State var userCashTarget = Double(getTargetMoney()) ?? 100.0
    @State var sliderColor: Color?
    @State var fuelConsumption = 0.0
    @State var avgCostPer100KM = 0.0
    @State var yearOfProduction = getProperYear()
    @State var carDistance = "-"
    @State var carName = getProperCarName()
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    EditCarNameView()
                } label: {
                    Text("\(carName)")
                        .fontWeight(.bold)
                        .font(.system(size: 20.0))
                        Text(" \(yearOfProduction)")
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
                NavigationLink {
                    SetTargetView()
                } label: {
                    Text("Set target")
                        .foregroundColor(.red)
                }
                Text("See history")
                    .foregroundColor(.red)
                NavigationLink {
                    AddSpendingView()
                } label: {
                    Text("Add spending")
                        .foregroundColor(.red)
                }
                Button {
                    writeSpendingsLimiter()
                    sliderValue = checkSlider()
                    checkColor()
                } label: {
                    Text("Clear spendings")
                }

            }
            .navigationTitle(NSLocalizedString("My car", comment: "Car panel"))
            
        }
        .navigationBarHidden(true)
        .onAppear {
            checkColor()
            carName = getProperCarName()
            yearOfProduction = getProperYear()
            userCashTarget = Double(getTargetMoney()) ?? 100.0
            let retTab = getCarHistory()
            if retTab.count >= 3 {
                carDistance = retTab[retTab.count - 3]
                sliderValue = checkSlider()
            }
            if retTab.count >= 6 {
                let upDist = Int(retTab[retTab.count - 3]) ?? 0
                let downDist = Int(retTab[0]) ?? 0
                let distanceDiff = upDist - downDist
                var i = 4
                var refuelementSum = 0.0
                while i < retTab.count {
                    refuelementSum += Double(retTab[i]) ?? 0.0
                    i += 3
                }
                fuelConsumption = Double(refuelementSum / Double(distanceDiff / 100))
                i = 5
                var costsSum = 0.0
                while i < retTab.count {
                    let litres = Double(retTab[i - 1]) ?? 0.0
                    let litrePrice = Double(retTab[i]) ?? 0.0
                    costsSum += (litres * litrePrice)
                    i += 3
                }
                avgCostPer100KM = Double(costsSum / Double(distanceDiff / 100))
                sliderValue = checkSlider()
            }
        }
    }
    func checkColor() {
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

func checkSlider() -> Double {
    let retTab = getCarHistory()
    let startingPoint = getSpendingsLimiter()
    var i = startingPoint
    var costsSum = 0.0
    while i < retTab.count {
        let litres = Double(retTab[i - 1]) ?? 0.0
        let litrePrice = Double(retTab[i]) ?? 0.0
        costsSum += (litres * litrePrice)
        i += 3
    }
    return costsSum
}
