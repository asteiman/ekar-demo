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

extension View {
    func nunitoFont(style: UIFont.TextStyle, weight: Font.Weight, color: UIColor? = nil) -> some View {
        self.modifier(NunitoFontModifier(style: style, weight: weight, textColor: color))
    }
}
