//
//  VehicleSavingsBadgeView.swift
//  ekar
//
//  Created by Alan Steiman on 25/07/2021.
//

import SwiftUI

struct VehicleSavingsBadgeView: View {
    
    let amount: String
    
    var body: some View {
        Text("SAVINGS OF AED " + amount)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .background(Color(UIColor(red: 0.93, green: 0.32, blue: 0.44, alpha: 1.00)))
            .clipShape(Capsule())
    }
}
