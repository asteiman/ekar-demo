//
//  OnBoardViewModel.swift
//  ekar
//
//  Created by Alan Steiman on 23/07/2021.
//

import UIKit

struct CarImage {
    var image: UIImage?
    let placeHolderName: String
    let label: String
}

class OnBoardViewModel: ObservableObject {
    @Published var images = [CarImage]()
    
    init() {
        images.append(CarImage(image: nil, placeHolderName: "example1", label: "FRONT/LEFT"))
        images.append(CarImage(image: nil, placeHolderName: "example2", label: "FRONT/RIGHT"))
        images.append(CarImage(image: nil, placeHolderName: "example3", label: "BACK/LEFT"))
        images.append(CarImage(image: nil, placeHolderName: "example4", label: "BACK/RIGHT"))
    }
}

extension OnBoardViewModel: OnBoardCoordinatorDelegate {
    func didSelectImage(image: UIImage, index: Int) {
        guard images.count > index else { return }
        images[index].image = image
    }
}
