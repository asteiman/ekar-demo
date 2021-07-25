//
//  MainButton.swift
//  ekar
//
//  Created by Alan Steiman on 25/07/2021.
//

import SwiftUI

struct MainButton: View {
    
    private let label: String
    private let action: () -> Void
    
    init(label: String, action: @escaping () -> Void) {
        self.label = label
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .frame(maxWidth: .infinity, minHeight: 60)
                .foregroundColor(Color.white)
                .background(Color(UIColor(red: 0.45, green: 0.78, blue: 0.96, alpha: 1.00)))
                .cornerRadius(8)
        }
    }
}
