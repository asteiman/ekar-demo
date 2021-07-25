//
//  MainButton.swift
//  ekar
//
//  Created by Alan Steiman on 25/07/2021.
//

import SwiftUI

struct MainButton: View {
    
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .nunitoFont(style: .footnote, weight: .bold, color: .white)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color(UIColor(red: 0.45, green: 0.78, blue: 0.96, alpha: 1.00)))
                .cornerRadius(8)
        }
    }
}
