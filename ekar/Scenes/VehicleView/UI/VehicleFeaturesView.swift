//
//  VehicleFeaturesView.swift
//  ekar
//
//  Created by Alan Steiman on 25/07/2021.
//

import SwiftUI

struct VehicleFeaturesView: View {
    
    let features: [String]
    
    var body: some View {
        FlexibleView(
            data: features,
            spacing: 8,
            alignment: .leading
        ) { item in
            Text(verbatim: item)
                .padding(8)
                .font(.system(size: 8))
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("patterns"))
                )
            
        }
    }
}
