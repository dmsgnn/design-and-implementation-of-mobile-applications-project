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
    private let service = UserService()
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUser() 
        
    }
    
    /*func login(withEmail email: String, password: String) {
        print("DEBUG: login with email \(email)")
    }*/
    
    func register(withEmail email: String, password: String, fullname: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            //check if an error happens
            if let error = error {
                print("DEBUG: failed to register with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
            
            print("DEBUG: register user successfully")
            print("DEBUG: User is \(String(describing: self.userSession))")
            
            //dictionary for backend infos
            let data = ["email": email,
                        "username": username.lowercased(),
                        "fullname": fullname,
                        "uid": user.uid]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    print("DEBUG: Did upload user data..")
                }
        }
    
    }
    
    func signOut() {
        // sets user session to nil and shows login view
        userSession = nil
        
        //signs user out on backend
        try? Auth.auth().signOut()
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        
        service.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }
}
