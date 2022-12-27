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
}
