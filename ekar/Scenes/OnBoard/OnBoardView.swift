//
//  OnBoardView.swift
//  ekar
//
//  Created by Alan Steiman on 23/07/2021.
//

import SwiftUI
import UIKit

struct OnBoardView: View {
    @State var imageIndex: Int = 0
    @State private var comment: String = ""
    @State var showCaptureImageView: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: OnBoardViewModel
    
    init(viewModel: OnBoardViewModel) {
        self.viewModel = viewModel
        UINavigationBar.appearance().barTintColor = .white
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
                        LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2)) {
                            ForEach((0...(viewModel.images.count - 1)), id: \.self) { index in
                                let object = viewModel.images[index]
                                
                                Button(action: {
                                    self.imageIndex = index
                                    self.showCaptureImageView.toggle()
                                }) {
                                    CarImageView(placeHolderName: object.placeHolderName, label: object.label, showCaptureImageView: $showCaptureImageView, image: object.image)
                                     }
                                }
                             }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1.00)), lineWidth: 1)
                        )
                        .padding(.bottom, 30)
                        HStack {
                            Text("Leave a comment:")
                                .foregroundColor(Color.black)
                            Spacer()
                        }
                        TextField("asds", text: $comment)
                        Button("Submit") {
                            //self.isModalPresented = true
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20))
                        .foregroundColor(.white)
                        .background(Color(UIColor(red: 0.45, green: 0.78, blue: 0.96, alpha: 1.00))).clipped()
                        .cornerRadius(8)
                    }
                    .padding(EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24))
                }
                .navigationBarTitle("", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("logo")
                            .resizable()
                            .frame(width: 80, height: 40, alignment: .center)
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

struct CarImageView: View {
    private let image: UIImage?
    @Binding var showCaptureImageView: Bool
    private let placeHolderName: String
    private let label: String
    
    init(placeHolderName: String, label: String, showCaptureImageView: Binding<Bool>, image: UIImage?) {
        self.placeHolderName = placeHolderName
        self.label = label
        self._showCaptureImageView = showCaptureImageView
        self.image = image
    }

    var body: some View {
        VStack {
            if let unwrappedImage = image {
                Image(uiImage: unwrappedImage)
                    .resizable()
                    .frame(width: 150, height: 100)
            } else {
                Image(placeHolderName)
                    .resizable()
                    .frame(width: 150, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            }
            Text(label)
                .foregroundColor(Color.black)
        }
    }
}
