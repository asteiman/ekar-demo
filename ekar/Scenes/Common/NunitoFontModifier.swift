//
//  NunitoFontModifier.swift
//  ekar
//
//  Created by Alan Steiman on 25/07/2021.
//

import SwiftUI

struct NunitoFontModifier: ViewModifier {
    
    var style: UIFont.TextStyle = .body
    var weight: Font.Weight = .regular
    var textColor: UIColor?

    var defaultColor: Color {
        return Color(UIColor(red: 0.18, green: 0.27, blue: 0.29, alpha: 1.00))
    }

    func body(content: Content) -> some View {
        let foregroundColor = textColor != nil ? Color(textColor!) : defaultColor
        content
            .font(Font.custom(weight == .bold ? "Nunito-Bold" : "Nunito-Regular", size: UIFont.preferredFont(forTextStyle: style).pointSize))
        .foregroundColor(foregroundColor)
    }
    
}
