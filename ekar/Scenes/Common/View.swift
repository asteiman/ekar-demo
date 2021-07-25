//
//  View.swift
//  ekar
//
//  Created by Alan Steiman on 25/07/2021.
//

import SwiftUI

extension View {
    func inExpandingRectangle() -> some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
            self
        }
    }
}
