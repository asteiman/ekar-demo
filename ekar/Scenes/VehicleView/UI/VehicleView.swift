//
//  VehicleView.swift
//  ekar
//
//  Created by Alan Steiman on 17/07/2021.
//

import SwiftUI
import Sliders
import ToastUI
import SDWebImageSwiftUI

struct VehicleView: View {
    @State private var isModalPresented = false
    @State private var imageIndex = 0
    @State private var presentingToast: Bool = false
    
    @ObservedObject var viewModel: VehicleViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ScrollView {
                    VStack {
                        if viewModel.imagesLoading {
                            ActivityIndicator($viewModel.imagesLoading)
                                .aspectRatio(4/3, contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width, height: 300, alignment: .center)
                        } else {
                            VehicleImagesView(imageIndex: $imageIndex, images: viewModel.images)
                        }
                        Spacer().frame(height: 30)
                        Group {
                            HStack {
                                Text("Year - \(viewModel.vehicle?.data.year ?? "")")
                                Spacer()
                                Text("Available colors")
                                ForEach(viewModel.vehicle?.data.colors ?? [], id: \.self) { colorName in
                                    ColorBadgeView(colorName: colorName)
                                }
                            }
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Base Price")
                                    Text(String(self.viewModel.getMonthlyFee()) + " AED / month")
                                }
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text("Contract length")
                                    Text(String(viewModel.getSelectedMonth()) + " Months")
                                }
                            }
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("TENURE")
                                    HStack(spacing: 5) {
                                        Text(String(viewModel.getMinMonths()))
                                        Text("to")
                                        Text(String(viewModel.getMaxMonths()))
                                        Text("Months")
                                    }
                                }
                                Spacer()
                                if viewModel.getSavingsAmount() != 0 {
                                    Text("SAVINGS OF AED " + String(viewModel.getSavingsAmount()))
                                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                        .background(Color(UIColor(red: 0.93, green: 0.32, blue: 0.44, alpha: 1.00)))
                                        .clipShape(Capsule())
                                }
                            }
                            VStack {
                                ContractTenureSliderView(viewModel: viewModel)
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("BOOKING FEE")
                                        Text("AED 120")
                                    }
                                    Spacer()
                                    SecondaryButton(label: "How contract works?") {
                                        presentingToast = true
                                    }
                                    .toast(isPresented: $presentingToast, dismissAfter: 2.0) {
                                        //
                                    } content: {
                                        ToastView("How contract works?")
                                    }
                                }
                            }
                            Spacer()
                        }.padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
                    }.background(Color(UIColor(red: 0.89, green: 0.96, blue: 1.00, alpha: 1.00)))
                    Group {
                        VStack(alignment: .leading) {
                            Text("About the vehicle")
                            HStack {
                                ForEach(viewModel.vehicleAttributes, id: \.imageName) { attribute in
                                    VehicleAttributeView(imageName: attribute.imageName, label: attribute.label)
                                }
                            }
                            .padding(.bottom, 10)
                            Text("Key features")
                            VehicleFeaturesView(features: viewModel.vehicle?.data.features ?? [])
                        }.padding(EdgeInsets(top: 10, leading: 16, bottom: 16, trailing: 16))
                    }
                }
                VehicleSubmitView(model: viewModel.vehicle, isModalPresented: $isModalPresented)
            }
        }.toolbar {
            ToolbarItem(placement: .principal) {
                NavigationLogo()
            }
        }
    }
}

struct VehicleView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleView(viewModel: VehicleViewModel(vehicleRepository: PreviewVehicleRepository(), contractRepository: ContractRepository(), imagesRepository: PreviewImagesRepository(), vin: "1"))
    }
}
