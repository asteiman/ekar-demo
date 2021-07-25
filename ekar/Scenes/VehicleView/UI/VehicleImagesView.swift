//
//  VehicleImagesView.swift
//  ekar
//
//  Created by Alan Steiman on 25/07/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct VehicleImagesView: View {
    @Binding var imageIndex: Int
    let images: [String]
    
    var body: some View {
        PagingView(index: $imageIndex.animation(), maxIndex: max(0, images.count - 1)) {
            ForEach(images, id: \.self) { imageName in
                WebImage(url: URL(string: imageName))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFill()
            }
        }
        .aspectRatio(4/3, contentMode: .fill)
        .frame(width: UIScreen.main.bounds.width, height: 300, alignment: .center)
    }
}
