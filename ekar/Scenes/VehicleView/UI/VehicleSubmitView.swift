//
//  VehicleSubmitView.swift
//  ekar
//
//  Created by Alan Steiman on 25/07/2021.
//

import SwiftUI

struct VehicleSubmitView: View {
    
    let model: Vehicle?
    @Binding var isModalPresented: Bool
    
    var body: some View {
        HStack {
            Spacer().frame(width: 24)
            VStack(alignment: .leading) {
                HStack {
                    Image(model?.data.make.lowercased() ?? "")
                        .resizable()
                        .frame(width: 40, height: 40)
                    VStack(alignment: .leading) {
                        HStack(spacing: 5) {
                            Text("\(model?.data.make ?? "")")
                                .nunitoFont(style: .body, weight: .bold)
                            Text("\(model?.data.model ?? "")")
                                .nunitoFont(style: .body, weight: .regular)
                        }
                        Text(model?.data.type ?? "")
                            .nunitoFont(style: .callout, weight: .regular)
                    }
                }
                Spacer().frame(height: 20)
                MainButton(label: "Proceed with your selection", action: {
                    self.isModalPresented = true
                })
                .fullScreenCover(isPresented: $isModalPresented) {
                    OnBoardView(viewModel: OnBoardViewModel())
                }
            }
            .padding(.top, 32)
            .padding(.bottom, 32)
            Spacer().frame(width: 24)
        }.background(
            Rectangle()
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.2), radius: 1, x: 0, y: -2))
    }
}
