//
//  TabView.swift
//  Fuel It
//
//  Created by Jakub Chojak on 09/03/2022.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State var showNextView = false
    @State var actualStation: PetrolStation?
    @State var stationID = 0
    
    var body: some View {
            NavigationView {
            Map(coordinateRegion: .constant(viewModel.region), interactionModes: .all, showsUserLocation: true, annotationItems: petrolStations) {
                        item in
                        MapAnnotation(coordinate: item.locationCords) {
                            NavigationLink(destination: StationDetailView(station: petrolStations[findArrayItem(petrolStationID: item.id)])){
                                
                                if item.brand.contains("ORLEN") {
                                    Image("orlen")
                                        .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 35)
                                        .padding()
                                }
                                else if item.brand.contains("AMIC") {
                                    Image("amic")
                                        .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 45)
                                        .padding()
                                    
                                }
                                else if item.brand.contains("SHELL") {
                                    Image("shell")
                                        .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 35)
                                        .padding()

                                }
                                else if item.brand.contains("BP") {
                                    Image("bp")
                                        .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 25)
                                        .padding()

                                }
                                else if item.brand.contains("CIRCLE K") {
                                    Image("circleK")
                                        .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50)
                                        .padding()

                                }
                                else if item.brand.contains("LOTOS") {
                                    Image("lotos")
                                        .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 35)
                                        .padding()

                                }
                                else if item.brand.contains("AVIA") {
                                    Image("avia")
                                        .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30)
                                        .padding()

                                }
                                else if item.brand.contains("INTERMARCHE") {
                                    Image("intermarche")
                                        .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60)
                                        .padding()

                                }
                                else{
                                    Image(systemName: "fuelpump.fill")
                                        .scaleEffect(1.0)
                                        .foregroundColor(Color("fuelPumpColour"))
                                        .padding()
                                }
                            }
                        }
                    }
                        .ignoresSafeArea(edges: .top)
                        .onAppear(perform: {
                            viewModel.checkIfLocationEnabled()
                            for petrolStation in petrolStations {
                                getFuelPrice(id: petrolStation.id)
                            }
                        })
            }
            .navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

func findArrayItem(petrolStationID: Int) -> Int{
    var i = 0
    for station in petrolStations {
        if station.id == petrolStationID {
            return i
        }
        i += 1
    }
    return 3000
}

final class HomeViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.94, longitude: 15.52), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    func checkIfLocationEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        }
    }
    
    private func checkLocationAuth() {
        guard let locationManager = locationManager else {
            return
        }
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("restricted or denied")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            print(locationManager.location?.coordinate ?? "")
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }
}
    func placeImage(value: Double, name: String) -> Image{
        return Image(name)
                .scaleEffect(value)
                .padding() as! Image
    }
