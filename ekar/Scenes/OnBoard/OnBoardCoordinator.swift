//
//  OnBoardCoordinator.swift
//  ekar
//
//  Created by Alan Steiman on 24/07/2021.
//

import Foundation
import SwiftUI

protocol OnBoardCoordinatorDelegate: AnyObject {
    func didSelectImage(image: UIImage, index: Int)
}

class OnBoardCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var isCoordinatorShown: Bool
    private weak var delegate: OnBoardCoordinatorDelegate?
    private let imageIndex: Int
    
    init(isShown: Binding<Bool>, delegate: OnBoardCoordinatorDelegate, imageIndex: Int) {
        _isCoordinatorShown = isShown
        self.delegate = delegate
        self.imageIndex = imageIndex
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        delegate?.didSelectImage(image: unwrapImage, index: imageIndex)
        isCoordinatorShown = false
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isCoordinatorShown = false
    }
}
