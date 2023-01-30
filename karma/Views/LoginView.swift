//
//  LoginView.swift
//  karma
//
//  Created by Giovanni Demasi on 06/12/22.
//

import SwiftUI

struct OrientationDetector: ViewModifier {
  @Binding var orientation: UIDeviceOrientation

  func body(content: Content) -> some View {
    content
      .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
        orientation = UIDevice.current.orientation
      }
  }
}

extension View {
  func detectOrientation(_ binding: Binding<UIDeviceOrientation>) -> some View {
    self.modifier(OrientationDetector(orientation: binding))
  }
}


struct LoginView: View {
    //    @StateObject var vm = ViewModel()
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var screenHeight = UIScreen.main.bounds.height
    @State private var screenWidth = UIScreen.main.bounds.width
    
    @State private var orientation = UIDevice.current.orientation
    
    
    var body: some View {
        // MARK: iPad
        if UIDevice.isIPad{
            // Login page must be shown
            Group{
                ZStack {
                    VStack(alignment: .center, spacing: getHeight() * 0.05) {
                        Spacer()
                            .frame(height: getHeight() * 0.15)
                        
                        // App name and login text
                        HStack {
                            Image("kLogo-40")
                                .offset(x: getHeight() * 0.01, y: -getHeight() * 0.009)
                                .padding(.trailing, getWidth()*0.01)
                            
                            Text("arma")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.theme.dark)
                        }
                        .offset(x: -getHeight() * 0.008)
                        
                        if !orientation.isLandscape{
                            Spacer()
                        }
                        
                        HStack() {
                            Text("Login")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.theme.dark)
                                .padding(.horizontal)
                                .padding(.top, -getHeight()*0.04)
                                .padding(.bottom, getHeight()*0.04)
                                .id("titlelogipad")
                        }
                        
                        
                        VStack(spacing: getHeight()*0.05){
                            iPadCustomInputField(placeholderText: "Email", text: $email)
                                .shadow(
                                    color: Color.gray.opacity(0.15),
                                    radius: getHeight() * 0.02,
                                    x: 0,
                                    y: 0
                                )
                                .textCase(.lowercase)
                            iPadCustomInputField(placeholderText: "Password", text: $password)
                                .shadow(
                                    color: Color.gray.opacity(0.15),
                                    radius: getHeight() * 0.02,
                                    x: 0,
                                    y: 0
                                )
                                .textCase(.lowercase)
                        }
                        
                        Spacer()
                        
                        Button {
                            viewModel.login(withEmail: email, password: password)
                        } label: {
                            Text("Login")
                                .font(.headline)
                                .frame(width: getWidth()*0.4, height: getHeight() * 0.05)
                                .foregroundColor(.white)
                                .background(.blue)
                                .cornerRadius(getHeight()*0.02)
                        }
                        
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
                            .frame(height: getHeight() * 0.1)
                        
                    }
                    .frame(width: getWidth() * 0.8)
                    .padding()
                }
            }
            .detectOrientation($orientation)
        }
        // MARK: iPhone
        else {
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
                            .id("titlelog")
                    }
                    
                    
                    VStack(spacing: screenHeight*0.05){
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
                        .frame(height: screenHeight * 0.01)
                    
                    // Login and signup buttons
                    Button {
                        viewModel.login(withEmail: email, password: password)
                    } label: {
                        Text("Login")
                            .font(.headline)
                            .frame(width: screenWidth*0.8, height: screenHeight * 0.06)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(screenHeight*0.02)
                    }
                    
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
    
    func isPortrait() -> Bool{
        if UIDevice.current.orientation.isPortrait{
            return true
        }
        else{
            return false
        }
    }
    
    
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
}
