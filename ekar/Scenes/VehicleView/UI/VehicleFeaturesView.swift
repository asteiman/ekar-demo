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
                        .fill(Color(UIColor(red: 0.89, green: 0.96, blue: 1.00, alpha: 1.00)))
                )
            
        }
    }
}
