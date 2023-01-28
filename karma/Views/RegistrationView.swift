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
    
    @State private var orientation = UIDevice.current.orientation

    
    var body: some View {
        if UIDevice.isIPad{
            Group{
                ZStack {
                    VStack(alignment: .center, spacing: getHeight() * 0.03) {
                        NavigationLink(destination: ImageUploaderView(),
                                       isActive: $viewModel.didAuthenticateUser,
                                       label: { })
                        
                        HStack {
                            Image("kLogo-40")
                                .offset(x: getHeight() * 0.01, y: -getHeight() * 0.009)
                                .padding(.trailing, getWidth()*0.01)
                            
                            Text("arma")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.theme.dark)
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
                                .foregroundColor(Color.theme.dark)
                        }
                        
                        if !orientation.isLandscape{
                            Spacer()
                                .frame(height: getHeight()*0.01)
                        }
                        
                        
                        VStack(spacing: getHeight()*0.05) {
                            
                            iPadCustomInputField(placeholderText: "Fullname", text: $fullname)
                                .shadow(
                                    color: Color.gray.opacity(0.15),
                                    radius: getHeight() * 0.02,
                                    x: 0,
                                    y: 0
                                )
                                .textCase(.lowercase)
                            
                            iPadCustomInputField(placeholderText: "Username", text: $username)
                                .shadow(
                                    color: Color.gray.opacity(0.15),
                                    radius: getHeight() * 0.02,
                                    x: 0,
                                    y: 0
                                )
                                .textCase(.lowercase)
                            
                            iPadCustomInputField(placeholderText: "Email", text: $email)
                                .shadow(
                                    color: Color.gray.opacity(0.15),
                                    radius: getHeight() * 0.02,
                                    x: 0,
                                    y: 0
                                )
                                .textCase(.lowercase)
                            
                            iPadCustomInputField(placeholderText: "Password", isSecureField: true, text: $password)
                                .shadow(
                                    color: Color.gray.opacity(0.15),
                                    radius: getHeight() * 0.02,
                                    x: 0,
                                    y: 0
                                )
                                .textCase(.lowercase)
                            
                        }
                        
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
                                .background(.blue)
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
                }
            }.detectOrientation($orientation)
        }
        else{
            ZStack {
                Color.theme.custombackg
                
                VStack {
                    NavigationLink(destination: ImageUploaderView(),
                                   isActive: $viewModel.didAuthenticateUser,
                                   label: { })
                    Spacer()
                    
                    HStack {
                        Image("kLogo-40")
                            .offset(x: 10, y: -7)
                        
                        Text("arma")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.dark)
                    }
                    .offset(x: -5)
                    
                    Spacer()
                    
                    HStack() {
                        Text("Sign Up")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.dark)
                            .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding(.leading, 18)
                    .padding(.bottom, 36)
                    
                    
                    VStack(spacing: 30) {
                        
                        CustomInputField(placeholderText: "Fullname", text: $fullname)
                        
                        CustomInputField(placeholderText: "Username", text: $username)
                        
                        CustomInputField(placeholderText: "Email", text: $email)
                        
                        CustomInputField(placeholderText: "Password", isSecureField: true, text: $password)
                        
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.register(withEmail: email,
                                           password: password,
                                           fullname: fullname,
                                           username: username)
                    } label: {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.size.width*0.8, height: 50)
                            .background(Color.theme.dark)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                    }
                    
                    Spacer()
                    
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
        RegistrationView()
    }
}
