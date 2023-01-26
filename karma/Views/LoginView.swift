//
//  LoginView.swift
//  karma
//
//  Created by Giovanni Demasi on 06/12/22.
//

import SwiftUI

struct LoginView: View {
    @StateObject var vm = ViewModel()
    @EnvironmentObject var viewModel: AuthViewModel
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    @Environment(\.horizontalSizeClass) var widthSizeClass: UserInterfaceSizeClass?

    
    var body: some View {
        if widthSizeClass != .compact{
                if vm.authenticated {
                    // Dashboard page must be shown
                    VStack {
                        Text("Dashboard")
                        Button("LogOut", action: vm.logOut)
                    }
                }

                else {
                    // Login page must be shown
                    ZStack {
                        VStack(alignment: .center, spacing: screenHeight * 0.05) {
                            Spacer()
                                .frame(height: screenHeight * 0.15)

                            // App name and login text
                            HStack {
                                Image("kLogo-40")
                                    .offset(x: screenHeight * 0.01, y: -screenHeight * 0.009)
                                    .padding(.trailing, screenWidth*0.01)

                                Text("arma")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.theme.dark)
                            }
                            .offset(x: -screenHeight * 0.008)

                            Spacer()

                            HStack() {
                                Text("Login")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.theme.dark)
                                    .padding(.horizontal)
                                    .padding(.top, -screenHeight*0.04)
                                    .padding(.bottom, screenHeight*0.04)
                            }


                            VStack(spacing: screenHeight*0.05){
                                iPadCustomInputField(placeholderText: "Email", text: $vm.email)
                                    .shadow(
                                        color: Color.gray.opacity(0.15),
                                        radius: screenHeight * 0.02,
                                        x: 0,
                                        y: 0
                                    )
                                iPadCustomInputField(placeholderText: "Password", text: $vm.password)
                                    .shadow(
                                        color: Color.gray.opacity(0.15),
                                        radius: screenHeight * 0.02,
                                        x: 0,
                                        y: 0
                                    )
                            }

                            Spacer()
                                .frame(height: screenHeight * 0.01)

                            // Login and signup buttons
                            Button("Login", action: vm.authenticate)
                                .font(.headline)
                                .frame(width: screenWidth*0.4, height: screenHeight * 0.05)
                                .foregroundColor(.white)
                                .background(.blue)
                                .cornerRadius(screenHeight*0.02)

                            if(screenHeight >= screenWidth){
                                Spacer()
                                    .frame(height: UIScreen.main.bounds.height * 0.02)
                            }
                            else{
                                Spacer()
                                    .frame(height: -UIScreen.main.bounds.height * 0.2)
                            }


                            NavigationLink {
                                RegistrationView()
                            } label: {
                                HStack {
                                    Text("Don't have an account ?")
                                        .font(.footnote)
                                    Text("Sign Up")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                }
                                .foregroundColor(.black)
                            }

                            Spacer()
                                .frame(height: screenHeight * 0.1)

                        }
                        .frame(width: screenWidth * 0.8)
                        .padding()
                    }
                }


        }
        else{
            if vm.authenticated {
                // Dashboard page must be shown
                VStack {
                    Text("Dashboard")
                    Button("LogOut", action: vm.logOut)
                }
            }
            
            else {
                // Login page must be shown
                ZStack {
                    VStack(alignment: .center, spacing: screenHeight * 0.05) {
                        Spacer()
                            .frame(height: screenHeight * 0.15)
                        
                        // App name and login text
                        HStack {
                            Image("kLogo-40")
                                .offset(x: screenHeight * 0.01, y: -screenHeight * 0.009)
                                .padding(.trailing, screenWidth*0.01)
                            
                            Text("arma")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.theme.dark)
                        }
                        .offset(x: -screenHeight * 0.008)
                        
                        Spacer()
                        
                        HStack() {
                            Text("Login")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.theme.dark)
                                .padding(.horizontal)
                                .padding(.top, -screenHeight*0.04)
                                .padding(.bottom, screenHeight*0.04)
                        }
                        
                        
                        VStack(spacing: screenHeight*0.05){
                            CustomInputField(placeholderText: "Email", text: $vm.email)
                                .shadow(
                                    color: Color.gray.opacity(0.15),
                                    radius: screenHeight * 0.02,
                                    x: 0,
                                    y: 0
                                )
                            CustomInputField(placeholderText: "Password", text: $vm.password)
                                .shadow(
                                    color: Color.gray.opacity(0.15),
                                    radius: screenHeight * 0.02,
                                    x: 0,
                                    y: 0
                                )
                        }
                        
                        Spacer()
                            .frame(height: screenHeight * 0.01)
                        
                        // Login and signup buttons
                        Button("Login", action: vm.authenticate)
                            .font(.headline)
                            .frame(width: screenWidth*0.8, height: screenHeight * 0.06)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(screenHeight*0.02)
                        
                        
                        Spacer()
                            .frame(height: UIScreen.main.bounds.height * 0.02)
                        
                        
                        NavigationLink {
                            RegistrationView()
                        } label: {
                            HStack {
                                Text("Don't have an account ?")
                                    .font(.footnote)
                                Text("Sign Up")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.black)
                        }
                        
                        Spacer()
                            .frame(height: screenHeight * 0.1)
                        
                    }
                    .frame(width: screenWidth * 0.8)
                    .padding()
                }
            }
        }
    }
//}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("iPhone 14 Pro")
        
        LoginView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (6th generation)"))
            .previewDisplayName("iPad Pro 12.9")
        
        LoginView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (6th generation)"))
            .previewInterfaceOrientation(.landscapeLeft)
            .previewDisplayName("iPad Pro 12.9 landscape")
    }
}
