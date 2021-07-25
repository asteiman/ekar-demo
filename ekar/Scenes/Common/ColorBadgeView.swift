//
//  ColorView.swift
//  ekar
//
//  Created by Alan Steiman on 25/07/2021.
//

import SwiftUI

struct ColorBadgeView: View {
    
    let colorName: String
    
    var body: some View {
        Circle()
            .fill(Color(colorName))
            .frame(width: 10, height: 10)
    }
}
