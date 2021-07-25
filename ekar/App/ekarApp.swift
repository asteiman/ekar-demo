//
//  ekarApp.swift
//  ekar
//
//  Created by Alan Steiman on 16/07/2021.
//

import SwiftUI

@main
struct ekarApp: App {
    
    init() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().isTranslucent = false
    }
    
    var body: some Scene {
        WindowGroup {
            MapView(viewModel: MapViewModel(repository: VehicleRepository(session: .shared, baseURL: Config.baseUrl)))
        }
    }
}
