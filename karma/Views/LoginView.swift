//
//  LoginView.swift
//  karma
//
//  Created by Giovanni Demasi on 06/12/22.
//

import SwiftUI

struct LoginView: View {
    @StateObject var vm = ViewModel()
    
    var body: some View {
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
                VStack(alignment: .center, spacing: UIScreen.main.bounds.height * 0.05) {
                    Spacer()
                        .frame(height: UIScreen.main.bounds.height * 0.1)
                    
                    // App name and login text
                    Text("karma")
                        .foregroundColor(.black)
                        .font(.system(size: 50, weight: .bold))
                    Text("Log in")
                        .foregroundColor(.black)
                        .font(.system(size: 40, weight: .medium))
                    
                    
                    // Textfields for email and password
                    TextField("Email", text: $vm.username)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $vm.password)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .privacySensitive()
                    
                    Spacer()
                        .frame(height: UIScreen.main.bounds.height * 0.01)
                    
                    // Login and signup buttons
                    Button("Login", action: vm.authenticate)
                        .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.05)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(16)

                        
                    Spacer()
                        .frame(height: UIScreen.main.bounds.height * 0.1)
                    Button("Don't have an account? SignUp", action: vm.logPressed)
                        .tint(.black)
                    
                    Spacer()
                        .frame(height: UIScreen.main.bounds.height * 0.1)
                }
                .alert("Access denied!", isPresented: $vm.invalid) {
                    Button("Dismiss", action: vm.logPressed)
                }
                .frame(width: UIScreen.main.bounds.width * 0.8)
                .padding()
            }
            .transition(.offset(x: 0, y: 850))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
