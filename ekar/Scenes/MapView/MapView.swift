//
//  mapView.swift
//  ekar
//
//  Created by Alan Steiman on 16/07/2021.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @ObservedObject var viewModel: MapViewModel
    
    @State var isActive: Bool = false
    @State var selectedAnnotation: MapAnnotation?
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        UINavigationBar.appearance().barTintColor = .white
    }
    
    var body: some View {
        if viewModel.isLoading {
            Text("Loading")
        } else {
            NavigationView {
                VStack {
                    NavigationLink(destination: VehicleView(viewModel: VehicleViewModel(vehicleRepository: viewModel.repository, contractRepository: ContractRepository(), imagesRepository: ImagesRepository(session: .shared, baseURL: "https://api.carsxe.com"), vin: selectedAnnotation?.id)), isActive: self.$isActive) {
                        EmptyView()
                    }
                    MapViewRepresentable(annotations: viewModel.mapAnnotations, isActive: self.$isActive, selectedAnnotation: self.$selectedAnnotation)
                }
                .navigationBarTitle("", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("logo")
                            .resizable()
                            .frame(width: 80, height: 40, alignment: .center)
                    }
                }
            }
        }
    }
}

struct MapViewRepresentable: UIViewRepresentable {
    
    var annotations: [MapAnnotation]
    @Binding var isActive: Bool
    @Binding var selectedAnnotation: MapAnnotation?
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let view = MKMapView(frame: .zero)
        
        let coordinate = CLLocationCoordinate2D(
            latitude: 25.0709248, longitude: 55.1429923)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region =
            MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
        
        return view
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.delegate = context.coordinator
        view.removeAnnotations(annotations)
        view.addAnnotations(annotations)
    }
}

struct mapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(viewModel: MapViewModel(repository: PreviewVehicleRepository()))
    }
}
