//
//  ContractTenureSliderView.swift
//  ekar
//
//  Created by Alan Steiman on 25/07/2021.
//

import SwiftUI
import Sliders

struct ContractTenureSliderView: View {
    
    @ObservedObject var viewModel: VehicleViewModel

    var body: some View {
        VStack {
            ValueSlider(value: $viewModel.contractSliderValue, in: 0...Float(viewModel.getMaxMonths()), step: 3)
                .valueSliderStyle(
                    HorizontalValueSliderStyle(
                        track: Rectangle()
                            .foregroundColor(Color("spray"))
                            .frame(height: 10)
                            .cornerRadius(5),
                        thumb: Circle()
                            .strokeBorder(Color("spray"), lineWidth: 8)
                            .background(Circle().foregroundColor(Color.white)),             thumbSize: CGSize(width: 30, height: 30)
                    )
                )
                .cornerRadius(8)
                .padding(.leading, 5)
                .padding(.trailing, 5)
            HStack {
                ForEach(viewModel.prices.map ({$0.month}), id: \.self) { month in
                    Text(String(month))
                        .nunitoFont(style: .caption1, weight: .regular)
                    if month != viewModel.prices.last?.month {
                        Spacer()
                    }
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.bottom, 8)
        }
    }
}
