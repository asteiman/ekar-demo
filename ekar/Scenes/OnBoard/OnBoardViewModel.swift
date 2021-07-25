//
//  OnBoardViewModel.swift
//  ekar
//
//  Created by Alan Steiman on 23/07/2021.
//

import UIKit

struct CarImage: Equatable {
    var image: UIImage?
    let placeHolderName: String
    let label: String
}

class OnBoardViewModel: ObservableObject {
    @Published var images = [CarImage]()
    @Published var comment = ""
    @Published var isValid = false
    @Published var showSubmissionToast = false
    
    init() {
        // Hardcoding for simplicity, this could be in external config or API
        images.append(CarImage(image: nil, placeHolderName: "example1", label: "FRONT/LEFT"))
        images.append(CarImage(image: nil, placeHolderName: "example2", label: "FRONT/RIGHT"))
        images.append(CarImage(image: nil, placeHolderName: "example3", label: "BACK/LEFT"))
        images.append(CarImage(image: nil, placeHolderName: "example4", label: "BACK/RIGHT"))
    }
    
    func validate() {
        // Simple validation, making sure the comment field is not empty, and all images in the array are not empty
        if images.filter({ $0.image == nil }).count > 0 || comment == "" {
            isValid = false
        } else {
            isValid = true
        }
        showSubmissionToast = true
    }
}

extension OnBoardViewModel: OnBoardCoordinatorDelegate {
    func didSelectImage(image: UIImage, index: Int) {
        guard images.count > index else { return }
        
        // Set the photo taken by the camera in the corresponding index
        images[index].image = image
    }
}
