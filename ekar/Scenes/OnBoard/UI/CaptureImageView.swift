//
//  CaptureImageView.swift
//  ekar
//
//  Created by Alan Steiman on 24/07/2021.
//

import SwiftUI

struct CaptureImageView {
    @Binding var isShown: Bool
    var delegate: OnBoardCoordinatorDelegate
    @Binding var imageIndex: Int
    
    func makeCoordinator() -> OnBoardCoordinator {
        return OnBoardCoordinator(isShown: $isShown, delegate: delegate, imageIndex: imageIndex)
    }
}

extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}
