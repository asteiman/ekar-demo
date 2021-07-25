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
    
    init(viewModel: VehicleViewModel) {
        self.viewModel = viewModel
    }
    
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
                            PagingView(index: $imageIndex.animation(), maxIndex: max(0, viewModel.images.count - 1)) {
                                ForEach(viewModel.images, id: \.self) { imageName in
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
                                ContractTenureSliderView(viewModel: _viewModel)
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
                                VStack(alignment: .center, spacing: 0) {
                                    Image("attribute-type")
                                        .resizable().frame(width: 40, height: 40).scaledToFill()
                                    Text(viewModel.vehicle?.data.cylinders ?? "")
                                }.inExpandingRectangle()
                                .padding(.top, 8)
                                .padding(.bottom, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(UIColor(red: 0.89, green: 0.96, blue: 1.00, alpha: 1.00)))
                                )
                                VStack(alignment: .center, spacing: 0) {
                                    Image("attribute-seats")
                                        .resizable().frame(width: 40, height: 40).scaledToFill()
                                    Text(viewModel.vehicle?.data.doors ?? "")
                                }
                                .inExpandingRectangle()
                                .padding(.top, 8)
                                .padding(.bottom, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(UIColor(red: 0.89, green: 0.96, blue: 1.00, alpha: 1.00)))
                                )
                                VStack(alignment: .center, spacing: 0) {
                                    Image("attribute-gear")
                                        .resizable().frame(width: 40, height: 40).scaledToFill()
                                    Text(viewModel.vehicle?.data.type ?? "")
                                }
                                .inExpandingRectangle()
                                .padding(.top, 8)
                                .padding(.bottom, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(UIColor(red: 0.89, green: 0.96, blue: 1.00, alpha: 1.00)))
                                )
                                VStack(alignment: .center, spacing: 0) {
                                    Image("attribute-fuel")
                                        .resizable().frame(width: 40, height: 40).scaledToFill()
                                    Text(viewModel.vehicle?.data.fuelType ?? "")
                                }
                                .inExpandingRectangle()
                                .padding(.top, 8)
                                .padding(.bottom, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(UIColor(red: 0.89, green: 0.96, blue: 1.00, alpha: 1.00)))
                                )
                            }
                            Text("Key features")
                            FlexibleView(
                                data: viewModel.vehicle?.data.features ?? [],
                                spacing: 8,
                                alignment: .leading
                            ) { item in
                                Text(verbatim: item)
                                    .padding(8)
                                    .font(.system(size: 8))
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color(UIColor(red: 0.89, green: 0.96, blue: 1.00, alpha: 1.00)))
                                    )
                                
                            }
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

extension View {
    func inExpandingRectangle() -> some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
            self
        }
    }
}
