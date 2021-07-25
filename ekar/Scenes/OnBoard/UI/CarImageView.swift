//
//  CarImageView.swift
//  ekar
//
//  Created by Alan Steiman on 25/07/2021.
//

import SwiftUI

struct CarImageView: View {
    
    let placeHolderName: String
    let label: String
    @Binding var showCaptureImageView: Bool
    let image: UIImage?

    var body: some View {
        VStack {
            if let unwrappedImage = image {
                Image(uiImage: unwrappedImage)
                    .resizable()
                    .frame(width: 150, height: 100)
            } else {
                Image(placeHolderName)
                    .resizable()
                    .frame(width: 150, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            }
            Text(label)
                .nunitoFont(style: .body, weight: .regular)
        }
    }
}
