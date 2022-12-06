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
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1))
            
            VStack {
                
                Spacer()
                
                Text("Karma")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor(red: 51/255, green: 47/255, blue: 47/255, alpha: 1)))
                
                Spacer()
                
                HStack() {
                    Text("Sign Up")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor(red: 51/255, green: 47/255, blue: 47/255, alpha: 1)))
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
                    dismiss()
                } label: {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 310, height: 50)
                        .background(
                            Color(UIColor(red: 51/255, green: 47/255, blue: 47/255, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                
                Spacer()
                
                HStack {
                    
                    Text("Already have an account ?")
                        .font(.footnote)
                
                    Button {
                        print("Go to SignIn View")
                    } label: {
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
