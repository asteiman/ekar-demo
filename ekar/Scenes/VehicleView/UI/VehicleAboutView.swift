//
//  VehicleAboutView.swift
//  ekar
//
//  Created by Alan Steiman on 25/07/2021.
//

import SwiftUI

struct VehicleAboutView: View {
    
    let attributes: [VehicleViewModel.VehicleAttribute]
    let features: [String]
    
    var body: some View {
        Group {
            VStack(alignment: .leading) {
                Text("About the vehicle")
                    .nunitoFont(style: .callout, weight: .bold)
                HStack {
                    ForEach(attributes, id: \.imageName) { attribute in
                        VehicleAttributeView(imageName: attribute.imageName, label: attribute.label)
                    }
                }
                .padding(.bottom, 10)
                Text("Key features")
                    .nunitoFont(style: .caption1, weight: .bold)
                VehicleFeaturesView(features: features)
            }.padding(EdgeInsets(top: 10, leading: 16, bottom: 16, trailing: 16))
        }
    }
}
