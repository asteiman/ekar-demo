//
//  OnBoardViewModelTests.swift
//  ekarTests
//
//  Created by Alan Steiman on 25/07/2021.
//

import Foundation

@testable import ekar
import XCTest
import MapKit

class OnBoardViewModelTests: XCTestCase {
    
    func testInit_Success() {
        let viewModel = OnBoardViewModel()

        var images = [CarImage]()
        images.append(CarImage(image: nil, placeHolderName: "example1", label: "FRONT/LEFT"))
        images.append(CarImage(image: nil, placeHolderName: "example2", label: "FRONT/RIGHT"))
        images.append(CarImage(image: nil, placeHolderName: "example3", label: "BACK/LEFT"))
        images.append(CarImage(image: nil, placeHolderName: "example4", label: "BACK/RIGHT"))
        let exp = expectValue(of: viewModel.$images.eraseToAnyPublisher(), equals: [images])

        wait(for: [exp.expectation], timeout: 1.0)
    }
    
    func testIsValidShouldStartInFalse() {
        let viewModel = OnBoardViewModel()

        let exp = expectValue(of: viewModel.$isValid.eraseToAnyPublisher(), equals: [false])

        wait(for: [exp.expectation], timeout: 1.0)
    }
    
    func testValidate_Failure() {
        let viewModel = OnBoardViewModel()

        let exp = expectValue(of: viewModel.$isValid.eraseToAnyPublisher(), count: 2, equals: [false])
        viewModel.validate()

        wait(for: [exp.expectation], timeout: 1.0)
    }
    
    func testValidate_Success() {
        let viewModel = OnBoardViewModel()

        let exp = expectValue(of: viewModel.$isValid.eraseToAnyPublisher(), equals: [true])
        viewModel.didSelectImage(image: UIImage(), index: 0)
        viewModel.didSelectImage(image: UIImage(), index: 1)
        viewModel.didSelectImage(image: UIImage(), index: 2)
        viewModel.didSelectImage(image: UIImage(), index: 3)
        viewModel.comment = "test"
        viewModel.validate()

        wait(for: [exp.expectation], timeout: 1.0)
    }
}
