//
//  VehicleView.swift
//  ekar
//
//  Created by Alan Steiman on 17/07/2021.
//

import SwiftUI

struct VehicleView: View {
    @State var sliderValue: Float = 0
    @State var index = 0
    var images = ["car", "car", "car"]
    
    @ObservedObject var viewModel: VehicleViewModel
    
    init(viewModel: VehicleViewModel) {
        self.viewModel = viewModel
        UINavigationBar.appearance().barTintColor = .white
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ScrollView {
                    VStack {
                        PagingView(index: $index.animation(), maxIndex: images.count - 1) {
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
                                Text("Year - 2020")
                                Spacer()
                                Text("Available colors")
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 10, height: 10)
                            }
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Base Price")
                                    Text("1500 AED / month")
                                }
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text("Contract length")
                                    Text("3 Months")
                                }
                            }
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("TENURE")
                                    Text("1 to 9 Months")
                                }
                                Spacer()
                                Text("SAVINGS OF AED 1,500")
                                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                    .background(Color(UIColor(red: 0.93, green: 0.32, blue: 0.44, alpha: 1.00)))
                                    .clipShape(Capsule())
                            }
                            VStack {
                                Slider(value: $sliderValue, in: 0...9, step: 3)
                                    .accentColor(Color.green).padding(.leading, 5)
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
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("BOOKING FEE")
                                        Text("AED 120")
                                    }
                                    Spacer()
                                    Button("How contract works?") {
                                        //
                                    }
                                    .padding(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10))
                                    .foregroundColor(Color(UIColor(red: 0.37, green: 0.80, blue: 0.98, alpha: 1.00)))
                                    .background(Color.white)
                                    .clipped()
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color(UIColor(red: 0.37, green: 0.80, blue: 0.98, alpha: 1.00)), lineWidth: 1))
                                }
                            }
                            Spacer()
                        }.padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
                    }.background(Color(UIColor(red: 0.89, green: 0.96, blue: 1.00, alpha: 1.00)))
                    Group {
                        VStack(alignment: .leading) {
                            Text("About the vehicle")
                            HStack {
                                Rectangle()
                                Rectangle()
                                Rectangle()
                                Rectangle()
                            }
                            Text("Key features")
                            FlexibleView(
                                data: [
                                    "Keyless Entry", "Bluetooth", "Power Windows", "ABS Breakes with EDB", "AUX / USB Jack", "AM / FM"
                                ],
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
                            VStack {
                                Text("Nissan Micra")
                                Text("HATCHBACK")
                            }
                        }
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
        VehicleView(viewModel: VehicleViewModel(repository: PreviewVehicleRepository(), vin: "1"))
    }
}
