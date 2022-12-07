//
//  AuthViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 07/12/22.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    
    //to store the user session
    @Published var userSession: FirebaseAuth.User? 
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        print("DEBUG: User session is \(String(describing: self.userSession))")
        
    }
    
    func login(withEmail email: String, password: String) {
        print("DEBUG: login with email \(email)")
    }
    
    func register(withEmail email: String, password: String, fullname: String, username: String) {
        print("DEBUG: register with email \(email)")
        
    }
}
