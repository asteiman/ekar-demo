//
//  VehicleAttributeView.swift
//  ekar
//
//  Created by Alan Steiman on 25/07/2021.
//

import SwiftUI

struct VehicleAttributeView: View {
    
    let imageName: String
    let label: String
        
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image(imageName)
                .resizable().frame(width: 40, height: 40).scaledToFill()
            Text(label)
                .nunitoFont(style: .caption1, weight: .regular)
        }
        .inExpandingRectangle()
        .padding(.top, 8)
        .padding(.bottom, 8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor(red: 0.89, green: 0.96, blue: 1.00, alpha: 1.00)))
        )
    }
}
