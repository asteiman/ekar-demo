//
//  OnBoardView.swift
//  ekar
//
//  Created by Alan Steiman on 23/07/2021.
//

import SwiftUI

struct OnBoardView: View {
    @State private var showModal = true
    @State private var comment: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    init() {
        UINavigationBar.appearance().barTintColor = .white
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center) {
                    Text("Please upload clear photos of the vehicle to avoid liability of any damages caused before starting your reservation")
                        .foregroundColor(Color.black)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 20)
                    VStack(spacing: 30) {
                        HStack(spacing: 30) {
                            VStack {
                                Image("example1")
                                    .resizable()
                                    .frame(width: 150, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                Text("FRONT/LEFT")
                                    .foregroundColor(Color.black)
                            }
                            VStack {
                                Image("example2")
                                    .resizable()
                                    .frame(width: 150, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                Text("FRONT/RIGHT")
                                    .foregroundColor(Color.black)
                            }
                        }
                        HStack(spacing: 30) {
                            VStack {
                                Image("example3")
                                    .resizable()
                                    .frame(width: 150, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                Text("BACK/LEFT")
                                    .foregroundColor(Color.black)
                            }
                            VStack {
                                Image("example4")
                                    .resizable()
                                    .frame(width: 150, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                Text("BACK/RIGHT")
                                    .foregroundColor(Color.black)
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
}

struct OnBoardView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardView()
    }
}
