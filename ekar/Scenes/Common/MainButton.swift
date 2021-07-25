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
                .background(Color("maya"))
                .cornerRadius(8)
        }
    }
}
