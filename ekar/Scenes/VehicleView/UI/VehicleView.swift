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
                                    .nunitoFont(style: .caption1, weight: .regular)
                                Spacer()
                                Text("Available colors")
                                    .nunitoFont(style: .caption1, weight: .regular)
                                ForEach(viewModel.vehicle?.data.colors ?? [], id: \.self) { colorName in
                                    ColorBadgeView(colorName: colorName)
                                }
                            }
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Base Price")
                                        .nunitoFont(style: .callout, weight: .bold)
                                    HStack(alignment: .firstTextBaseline, spacing: 5) {
                                        Text(String(self.viewModel.getMonthlyFee()))
                                            .nunitoFont(style: .title1, weight: .bold)
                                        Text("AED / month")
                                            .nunitoFont(style: .caption1, weight: .regular)
                                    }
                                }
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text("Contract length")
                                        .nunitoFont(style: .callout, weight: .regular)
                                    HStack(alignment: .firstTextBaseline, spacing: 5) {
                                        Text(String(viewModel.getSelectedMonth()))
                                            .nunitoFont(style: .title1, weight: .bold)
                                        Text("Months")
                                            .nunitoFont(style: .caption1, weight: .regular)
                                    }
                                }
                            }
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("TENURE")
                                        .nunitoFont(style: .caption1, weight: .regular)
                                    HStack(spacing: 5) {
                                        Text(String(viewModel.getMinMonths()))
                                        Text("to")
                                        Text(String(viewModel.getMaxMonths()))
                                        Text("Months")
                                    }
                                    .nunitoFont(style: .callout, weight: .bold)
                                }
                                Spacer()
                                if viewModel.getSavingsAmount() != 0 {
                                    VehicleSavingsBadgeView(amount: String(viewModel.getSavingsAmount()))
                                }
                            }
                            VStack {
                                ContractTenureSliderView(viewModel: viewModel)
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("BOOKING FEE")
                                            .nunitoFont(style: .caption2, weight: .bold)
                                        HStack(alignment: .firstTextBaseline, spacing: 5) {
                                            Text("AED")
                                                .nunitoFont(style: .caption1, weight: .regular)
                                            Text("120")
                                                .nunitoFont(style: .title1, weight: .bold)
                                        }
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
                    }.background(Color("patterns"))
                    VehicleAboutView(attributes: viewModel.vehicleAttributes, features: viewModel.vehicle?.data.features ?? [])
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
