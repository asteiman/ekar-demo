//
//  CarImagesGridView.swift
//  ekar
//
//  Created by Alan Steiman on 25/07/2021.
//

import SwiftUI

struct CarImagesGridView: View {
    @ObservedObject var viewModel: OnBoardViewModel
    @Binding var showCaptureImageView: Bool
    @Binding var imageIndex: Int
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2)) {
            ForEach((0...(viewModel.images.count - 1)), id: \.self) { index in
                let object = viewModel.images[index]
                
                Button(action: {
                    self.imageIndex = index
                    self.showCaptureImageView.toggle()
                }) {
                    CarImageView(placeHolderName: object.placeHolderName, label: object.label, showCaptureImageView: $showCaptureImageView, image: object.image)
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1.00)), lineWidth: 1)
        )
        .padding(.bottom, 30)
    }
}
