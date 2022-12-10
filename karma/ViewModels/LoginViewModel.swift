//
//  LoginViewModel.swift
//  karma
//
//  Created by Giovanni Demasi on 06/12/22.
//

import Foundation
import SwiftUI

extension LoginView {
    class ViewModel: ObservableObject {
        // In this way the application will remember if the user is authenticated
        @AppStorage("AUTH_KEY") var authenticated = false{
            willSet { objectWillChange.send() }
        }
        // AppStorage because in this way the app will remember the username
        @AppStorage("USER_KEY") var username = ""
        @Published var password = ""
        @Published var invalid: Bool = false
        
        // Debugging notifictions
        init() {
            print("Currently logged on: \(authenticated)")
            print("Current user: \(username)")
        }
        
        func toggleAuthentication() {
            self.password = ""
            
            withAnimation{
                authenticated.toggle()
            }
        }
        
        // authentication function which allow the user to login only if the user is fount in db
        // Lowercased because in this way the application will be case insensitive
        func authenticate() {
            // Username validation
            guard self.username.lowercased() == "testusername"
            else {
                self.invalid = true
                return
            }
            
            // Password validation
            guard self.password.lowercased() == "testpassword"
            else {
                self.invalid = true
                return
            }
            
            // If the user validation is successful the authentication is toggled
            toggleAuthentication()
        }
        
        // Log out function
        func logOut() {
            toggleAuthentication()
        }
        
        func logPressed() {
            print("Login button pressed.")
        }
        
    }
}
