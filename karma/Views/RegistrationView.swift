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
    
    var body: some View {
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

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
