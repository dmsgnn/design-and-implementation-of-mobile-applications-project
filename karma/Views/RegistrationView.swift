//
//  RegistrationView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 06/12/22.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var fullname = ""
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var screenHeight = UIScreen.main.bounds.height
    @State private var screenWidth = UIScreen.main.bounds.width
    
    @State private var orientation = UIDevice.current.orientation
    private var ipad : Bool
    
    init(test : Bool){
        if test{
            ipad = true
        }
        else{
            ipad = UIDevice.isIPad
        }
    }
    
    var body: some View {
        if ipad{
            Group{
                ZStack {
                    Color.theme.custombackg
                    VStack(alignment: .center, spacing: getHeight() * 0.03) {
                        NavigationLink(destination: ImageUploaderView(),
                                       isActive: $viewModel.didAuthenticateUser,
                                       label: { })
                        
                        HStack {
                            Image("logo_bl-40")
                                .offset(x: 10, y: -3)
                            
                            Text("arma")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                        .offset(x: -getHeight()*0.01)
                        
                        if !orientation.isLandscape{
                            Spacer()
                                .frame(height: getHeight()*0.01)
                        }
                        
                        HStack() {
                            Text("Sign Up")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .id("titleipad")
                        }
                        
                        
                        if !orientation.isLandscape{
                            Spacer()
                                .frame(height: getHeight()*0.01)
                        }
                        
                        
                        VStack(spacing: getHeight()*0.05) {
                            
                            iPadCustomInputField(placeholderText: "Fullname", text: $fullname)
                            
                                .textCase(.lowercase)
                            
                            iPadCustomInputField(placeholderText: "Username", text: $username)
                            
                                .textCase(.lowercase)
                            
                            iPadCustomInputField(placeholderText: "Email", text: $email)
                            
                                .textCase(.lowercase)
                            
                            iPadCustomInputField(placeholderText: "Password", isSecureField: true, text: $password)
                                .textCase(.lowercase)
                            
                        }
                        Spacer().frame(height: 30)
                        
                        Button {
                            viewModel.register(withEmail: email,
                                               password: password,
                                               fullname: fullname,
                                               username: username)
                        } label: {
                            Text("Sign Up")
                                .font(.headline)
                                .frame(width: getWidth()*0.4, height: getHeight() * 0.05)
                                .foregroundColor(.white)
                                .background(.black)
                                .clipShape(RoundedRectangle(cornerRadius: getHeight()*0.02))
                            
                        }
                        
                        if !orientation.isLandscape{
                            Spacer()
                                .frame(height: getHeight()*0.03)
                        }
                        
                        Button {
                            dismiss()
                        } label: {
                            HStack {
                                Text("Already have an account ?")
                                    .font(.footnote)
                                Text("Sign In")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                            }
                        }
                        .foregroundColor(.black)
                        
                    }
                    .navigationBarBackButtonHidden(true)
                }
                .ignoresSafeArea()
            }.detectOrientation($orientation)
        }
        // MARK: iPhone
        else{
            ZStack {
                Color.theme.custombackg
                VStack {
                    NavigationLink(destination: ImageUploaderView(),
                                   isActive: $viewModel.didAuthenticateUser,
                                   label: { })
                    Spacer()
                        .frame(height: 40)
                    
                    HStack {
                        Image("logo_bl-40")
                            .offset(x: screenHeight * 0.01, y: -1)
                            .foregroundColor(.white)
                        
                        Text("arma")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    .offset(x: -screenHeight * 0.008)
                    
                    Spacer()
                        .frame(height: 40)
                    
                    Text("Sign Up")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .id("title")
                    
                    
                    
                    VStack(spacing: screenHeight*0.035) {
                        
                        CustomInputField(placeholderText: "Fullname", text: $fullname)
                            .shadow(
                                color: Color.gray.opacity(0.15),
                                radius: screenHeight * 0.02,
                                x: 0,
                                y: 0
                            )
                            .textCase(.lowercase)
                        
                        CustomInputField(placeholderText: "Username", text: $username)
                            .shadow(
                                color: Color.gray.opacity(0.15),
                                radius: screenHeight * 0.02,
                                x: 0,
                                y: 0
                            )
                            .textCase(.lowercase)
                        
                        CustomInputField(placeholderText: "Email", text: $email)
                            .shadow(
                                color: Color.gray.opacity(0.15),
                                radius: screenHeight * 0.02,
                                x: 0,
                                y: 0
                            )
                            .textCase(.lowercase)
                        
                        CustomInputField(placeholderText: "Password", isSecureField: true, text: $password)
                            .shadow(
                                color: Color.gray.opacity(0.15),
                                radius: screenHeight * 0.02,
                                x: 0,
                                y: 0
                            )
                            .textCase(.lowercase)
                        
                    }
                    
                    Spacer()
                        .frame(height: screenHeight * 0.07)
                    
                    Button {
                        viewModel.register(withEmail: email,
                                           password: password,
                                           fullname: fullname,
                                           username: username)
                    } label: {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: screenWidth*0.8, height: screenHeight * 0.06)
                            .background(.black)
                            .clipShape(RoundedRectangle(cornerRadius: screenHeight*0.02))
                        
                    }
                    
                    Spacer()
                        .frame(height: 40)
                    
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Text("Already have an account ?")
                                .font(.footnote)
                            Text("Sign In")
                                .font(.footnote)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding()
                    .foregroundColor(.black)
                    
                }
                .navigationBarBackButtonHidden(true)
            }
            .ignoresSafeArea()
        }
        
    }
    
    func getHeight() -> CGFloat {
        if orientation.isLandscape{
            return UIScreen.main.bounds.width
        }
        else{
            return UIScreen.main.bounds.height
        }
    }
    
    func getWidth() -> CGFloat {
        if orientation.isLandscape{
            return UIScreen.main.bounds.height
        }
        else{
            return UIScreen.main.bounds.width
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(test: false)
    }
}
