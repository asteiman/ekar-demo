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
    @Published var comment = ""
    @Published var isValid = false
    @Published var showSubmissionToast = false
    
    init() {
        images.append(CarImage(image: nil, placeHolderName: "example1", label: "FRONT/LEFT"))
        images.append(CarImage(image: nil, placeHolderName: "example2", label: "FRONT/RIGHT"))
        images.append(CarImage(image: nil, placeHolderName: "example3", label: "BACK/LEFT"))
        images.append(CarImage(image: nil, placeHolderName: "example4", label: "BACK/RIGHT"))
    }
    
    func validate() {
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
        images[index].image = image
    }
}
