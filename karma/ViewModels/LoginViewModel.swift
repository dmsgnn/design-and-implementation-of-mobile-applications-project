//
//  LoginViewModel.swift
//  karma
//
//  Created by Giovanni Demasi on 06/12/22.
//

import Foundation
import SwiftUI
import Firebase

extension LoginView {
    class ViewModel: ObservableObject {
        // In this way the application will remember if the user is authenticated
        @AppStorage("AUTH_KEY") var authenticated = false{
            willSet { objectWillChange.send() }
        }
        // AppStorage because in this way the app will remember the username
        @AppStorage("USER_KEY") var email = ""
        @Published var password = ""
        @Published var invalid: Bool = false
        
        // Debugging notifictions
        init() {
            print("Currently logged on: \(authenticated)")
            print("Current user: \(email)")
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
            // User authentication
            Auth.auth().signIn(withEmail: email, password: password) { [self] (result, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                } else {
                    // If the user validation is successful the authentication is toggled
                    self.toggleAuthentication()
                }
            }
        }
        
        // Log out function
        func logOut() {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                toggleAuthentication()
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }
        
        func logPressed() {
            print("Login button pressed.")
        }
        
    }
}
