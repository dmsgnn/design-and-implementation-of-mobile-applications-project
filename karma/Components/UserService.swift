//
//  UserService.swift
//  karma
//
//  Created by Tommaso Bucaioni on 27/12/22.
//
import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
    
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument{ snapshot, _ in
                guard let snapshot = snapshot else { return }
    
                guard let user = try? snapshot.data(as: User.self) else { return }
                completion(user)
                
                print("DEBUG Username is \(user.username)")
                print("DEBUG: Email is \(user.email)")
            
                
            }
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void) {
        Firestore.firestore().collection("users")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let users = documents.compactMap({try? $0.data(as: User.self)})
                completion(users)
            }
        
    }
    
    func updateUserData(fullname: String, username: String, completion: @escaping(Bool) -> Void) {
        guard let user = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(user).setData(["fullname" : fullname, "username" : username], merge: true)
        completion(true)
    }
}

//func register(withEmail email: String, password: String, fullname: String, username: String) {
//    Auth.auth().createUser(withEmail: email, password: password) { result, error in
//        //check if an error happens
//        if let error = error {
//            print("DEBUG: failed to register with error \(error.localizedDescription)")
//            return
//        }

//db.collection("cities").document("BJ").setData([ "capital": true ], merge: true)
