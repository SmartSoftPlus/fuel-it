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
    
    var body: some View {
        if !showNextView {
            Map(coordinateRegion: .constant(viewModel.region), interactionModes: .all, showsUserLocation: true, annotationItems: petrolStations) {
                        item in
                        MapAnnotation(coordinate: item.locationCords) {
                            Button(action: {
                                print(item.locationCords)
                                actualStation = item
                                showNextView = true
                                
                            }) {
                                Image(systemName: "mappin.and.ellipse")
                                    .scaleEffect(2.0)
                                    .foregroundColor(.red)
                                    .padding()
                            }
                            .background(Circle())
                            .foregroundColor(Color.clear)
                        }
                    }
                        .ignoresSafeArea(edges: .top)
                        .onAppear {
                            viewModel.checkIfLocationEnabled()
                        }
        }
        else {
            StationDetailView(station: actualStation!)
        }   
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
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
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            print(locationManager.location?.coordinate ?? "")
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }
    
}
