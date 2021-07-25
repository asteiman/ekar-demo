//
//  CarImageView.swift
//  ekar
//
//  Created by Alan Steiman on 25/07/2021.
//

import SwiftUI

struct CarImageView: View {
    private let image: UIImage?
    @Binding var showCaptureImageView: Bool
    private let placeHolderName: String
    private let label: String
    
    init(placeHolderName: String, label: String, showCaptureImageView: Binding<Bool>, image: UIImage?) {
        self.placeHolderName = placeHolderName
        self.label = label
        self._showCaptureImageView = showCaptureImageView
        self.image = image
    }

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
                .foregroundColor(Color.black)
        }
    }
}
