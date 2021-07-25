//
//  VehicleViewModelTests.swift
//  ekarTests
//
//  Created by Alan Steiman on 25/07/2021.
//

@testable import ekar
import XCTest
import MapKit

class VehicleViewModelTests: XCTestCase {
    
    func testInit_ShouldPopulateVehicleModel() {
        let viewModel = VehicleViewModel(vehicleRepository: PreviewVehicleRepository(), contractRepository: ContractRepository(), imagesRepository: PreviewImagesRepository(), vin: "123")
        
        let model = Vehicle.dummy
        let exp = expectValue(of: viewModel.$vehicle, equals: [model])
        
        wait(for: [exp.expectation], timeout: 1.0)
    }
    
    func testInit_ShouldPopulateAttributes() {
        let viewModel = VehicleViewModel(vehicleRepository: PreviewVehicleRepository(), contractRepository: ContractRepository(), imagesRepository: PreviewImagesRepository(), vin: "123")
        
        let expectedResult = [
            VehicleViewModel.VehicleAttribute(imageName: "attribute-type", label: "4 cylinders"),
            VehicleViewModel.VehicleAttribute(imageName: "attribute-seats", label: "5 doors"),
            VehicleViewModel.VehicleAttribute(imageName: "attribute-gear", label: "Wagon"),
            VehicleViewModel.VehicleAttribute(imageName: "attribute-fuel", label: "Petrol")
        ]
        let exp = expectValue(of: viewModel.$vehicleAttributes, equals: [expectedResult])
        
        wait(for: [exp.expectation], timeout: 1.0)
    }
    
    func testInit_ShouldFetchVehicleImages() {
        let viewModel = VehicleViewModel(vehicleRepository: PreviewVehicleRepository(), contractRepository: ContractRepository(), imagesRepository: PreviewImagesRepository(), vin: "123")
        
        let expectedResult = ["https://www.leasetechs.com/wp-content/uploads/2018/04/Civic-Sedan-1279x719.jpg", "https://wallpapercave.com/wp/wp7301270.jpg"]
        let exp = expectValue(of: viewModel.$images, equals: [expectedResult])
        
        wait(for: [exp.expectation], timeout: 1.0)
    }
    
    func testInit_ShouldLoadPrices() {
        let viewModel = VehicleViewModel(vehicleRepository: PreviewVehicleRepository(), contractRepository: ContractRepository(), imagesRepository: PreviewImagesRepository(), vin: "123")
        
        let expectedResult = [
            VehicleContract(month: 1, price: 1500),
            VehicleContract(month: 3, price: 1400),
            VehicleContract(month: 6, price: 1300),
            VehicleContract(month: 9, price: 1200)
        ]
        let exp = expectValue(of: viewModel.$prices, equals: [expectedResult])
                
        wait(for: [exp.expectation], timeout: 1.0)
    }
    
    func testGetMinMonths_Success() {
        let viewModel = VehicleViewModel(vehicleRepository: PreviewVehicleRepository(), contractRepository: ContractRepository(), imagesRepository: PreviewImagesRepository(), vin: "123")
        
        XCTAssertEqual(viewModel.getMinMonths(), 1)
    }
    
    func testGetMaxMonths_Success() {
        let viewModel = VehicleViewModel(vehicleRepository: PreviewVehicleRepository(), contractRepository: ContractRepository(), imagesRepository: PreviewImagesRepository(), vin: "123")
        
        XCTAssertEqual(viewModel.getMaxMonths(), 9)
    }
    
    func testGetMonthlyFee_Success() {
        let viewModel = VehicleViewModel(vehicleRepository: PreviewVehicleRepository(), contractRepository: ContractRepository(), imagesRepository: PreviewImagesRepository(), vin: "123")
        
        XCTAssertEqual(viewModel.getMonthlyFee(), 1500)
    }
    
    func testGetSavingsAmount_Success() {
        let viewModel = VehicleViewModel(vehicleRepository: PreviewVehicleRepository(), contractRepository: ContractRepository(), imagesRepository: PreviewImagesRepository(), vin: "123")
        
        XCTAssertEqual(viewModel.getSavingsAmount(), 0)
        viewModel.contractSliderValue = 3
        XCTAssertEqual(viewModel.getSavingsAmount(), 300)
        viewModel.contractSliderValue = 6
        XCTAssertEqual(viewModel.getSavingsAmount(), 1200)
        viewModel.contractSliderValue = 9
        XCTAssertEqual(viewModel.getSavingsAmount(), 2700)
    }
}
