//
//  VehicleView.swift
//  ekar
//
//  Created by Alan Steiman on 17/07/2021.
//

import SwiftUI
import Sliders
import ToastUI

struct VehicleView: View {
    var images = ["car", "car", "car"]
    @State private var imageIndex = 0
    @State private var presentingToast: Bool = false
    
    @ObservedObject var viewModel: VehicleViewModel
    
    init(viewModel: VehicleViewModel) {
        self.viewModel = viewModel
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().isTranslucent = false
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ScrollView {
                    VStack {
                        PagingView(index: $imageIndex.animation(), maxIndex: images.count - 1) {
                            ForEach(self.images, id: \.self) { imageName in
                                Image(imageName)
                                    .resizable()
                                    .scaledToFill()
                            }
                        }
                        .aspectRatio(4/3, contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .frame(width: UIScreen.main.bounds.width, height: 300, alignment: .center)
                        Group {
                            HStack {
                                Text("Year - \(viewModel.vehicle?.data.year ?? "")")
                                Spacer()
                                Text("Available colors")
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 10, height: 10)
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
                                ValueSlider(value: $viewModel.contractSliderValue, in: 0...Float(viewModel.getMaxMonths()), step: 3)
                                    .valueSliderStyle(
                                        HorizontalValueSliderStyle(
                                            track: Rectangle()
                                                .foregroundColor(Color(UIColor(red: 0.43, green: 0.87, blue: 0.98, alpha: 1.00)))
                                                .frame(height: 10)
                                                .cornerRadius(5),
                                            thumb: Circle()
                                            .strokeBorder(Color(UIColor(red: 0.43, green: 0.87, blue: 0.98, alpha: 1.00)), lineWidth: 8)
                                            .background(Circle().foregroundColor(Color.white)),             thumbSize: CGSize(width: 30, height: 30)
                                        )
                                    )
                                    .cornerRadius(8)
                                    .padding(.leading, 5)
                                    .padding(.trailing, 5)
                                HStack {
                                    Text("1")
                                    Spacer()
                                    Text("3")
                                    Spacer()
                                    Text("6")
                                    Spacer()
                                    Text("9")
                                }.padding(.leading, 16)
                                .padding(.trailing, 16)
                                .padding(.bottom, 8)
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("BOOKING FEE")
                                        Text("AED 120")
                                    }
                                    Spacer()
                                    Button("How contract works?") {
                                        presentingToast = true
                                    }
                                    .padding(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10))
                                    .foregroundColor(Color(UIColor(red: 0.37, green: 0.80, blue: 0.98, alpha: 1.00)))
                                    .background(Color.white)
                                    .clipped()
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color(UIColor(red: 0.37, green: 0.80, blue: 0.98, alpha: 1.00)), lineWidth: 1))
                                    .toast(isPresented: $presentingToast, dismissAfter: 2.0) {
                                          print("Toast dismissed")
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
                        }.padding(EdgeInsets(top: 10, leading: 16, bottom: 4, trailing: 16))
                    }
                }
                HStack {
                    Spacer()
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "ellipsis.circle")
                            VStack(alignment: .leading) {
                                Text("\(viewModel.vehicle?.data.make ?? "") \(viewModel.vehicle?.data.model ?? "")")
                                Text(viewModel.vehicle?.data.type ?? "")
                            }
                        }
                        Spacer().frame(height: 20)
                        Button("Proceed with your selection") {
                            print("tapped!")
                        }
                        .frame(width: 280)
                        .padding(EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20))
                        .foregroundColor(.white)
                        .background(Color(UIColor(red: 0.45, green: 0.78, blue: 0.96, alpha: 1.00))).clipped()
                        .cornerRadius(8)
                    }
                    .padding(.top, 32)
                    .padding(.bottom, 32)
                    Spacer()
                }.background(
                    Rectangle()
                        .fill(Color.white)
                        .shadow(color: .gray.opacity(0.2), radius: 1, x: 0, y: -2))
            }
        }.toolbar {
            ToolbarItem(placement: .principal) {
                Image("logo")
                    .resizable()
                    .frame(width: 80, height: 40, alignment: .center)
            }
        }
    }
}

struct VehicleView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleView(viewModel: VehicleViewModel(vehicleRepository: PreviewVehicleRepository(), contractRepository: ContractRepository(), vin: "1"))
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
