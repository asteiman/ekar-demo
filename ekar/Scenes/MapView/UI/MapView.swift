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
    }
    
    var body: some View {
        if viewModel.isLoading {
            LoadingView()
        } else {
            NavigationView {
                VStack {
                    NavigationLink(destination: VehicleView(viewModel: VehicleViewModel(vehicleRepository: viewModel.repository, contractRepository: ContractRepository(), imagesRepository: ImagesRepository(session: .shared, baseURL: Config.baseUrl), vin: selectedAnnotation?.id)), isActive: self.$isActive) {
                        EmptyView()
                    }
                    MapViewRepresentable(annotations: viewModel.mapAnnotations, isActive: self.$isActive, selectedAnnotation: self.$selectedAnnotation)
                }
                .navigationBarTitle("", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        NavigationLogo()
                    }
                }
            }
        }
    }
}

struct mapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(viewModel: MapViewModel(repository: PreviewVehicleRepository()))
    }
}
