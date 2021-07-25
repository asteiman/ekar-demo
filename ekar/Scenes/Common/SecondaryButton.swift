//
//  SecondaryButton.swift
//  ekar
//
//  Created by Alan Steiman on 25/07/2021.
//

import SwiftUI

struct SecondaryButton: View {
    
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button(label, action: action)
        .padding(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10))
        .foregroundColor(Color(UIColor(red: 0.37, green: 0.80, blue: 0.98, alpha: 1.00)))
        .background(Color.white)
        .clipped()
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(UIColor(red: 0.37, green: 0.80, blue: 0.98, alpha: 1.00)), lineWidth: 1))
    }
}
