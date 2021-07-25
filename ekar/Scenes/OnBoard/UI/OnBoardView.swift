//
//  OnBoardView.swift
//  ekar
//
//  Created by Alan Steiman on 23/07/2021.
//

import SwiftUI
import UIKit
import ToastUI

struct OnBoardView: View {
    @State var imageIndex: Int = 0
    @State var showCaptureImageView: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: OnBoardViewModel
    
    init(viewModel: OnBoardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(alignment: .center) {
                        Text("Please upload clear photos of the vehicle to avoid liability of any damages caused before starting your reservation")
                            .foregroundColor(Color.black)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, 20)
                        CarImagesGridView(viewModel: _viewModel, showCaptureImageView: $showCaptureImageView, imageIndex: $imageIndex)
                        HStack {
                            Text("Leave a comment:")
                                .foregroundColor(Color.black)
                            Spacer()
                        }
                        TextField("", text: $viewModel.comment)
                            .foregroundColor(Color.black)
                        Rectangle().foregroundColor(Color(UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1.00))).frame(height: 1)
                        MainButton(label: "Submit", action: {
                            viewModel.validate()
                        })
                        .toast(isPresented: $viewModel.showSubmissionToast, dismissAfter: 2.0) {
                            //
                        } content: {
                            ToastView(viewModel.isValid ? "Thank you for choosing Ekar" : "Validation Failure")
                        }
                    }
                    .padding(EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24))
                }
                .navigationBarTitle("", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        NavigationLogo()
                    }
                }
                .navigationBarItems(
                    
                    leading: HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image("close")
                        }
                    }
                )
                .navigationBarBackButtonHidden(true)
            }
        }
        .sheet(isPresented: $showCaptureImageView, content: {
            CaptureImageView(isShown: $showCaptureImageView, delegate: viewModel, imageIndex: $imageIndex)
        })
    }
}

struct OnBoardView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardView(viewModel: OnBoardViewModel())
    }
}
