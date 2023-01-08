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
}
