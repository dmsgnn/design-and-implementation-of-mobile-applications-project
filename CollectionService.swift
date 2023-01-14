//
//  CollectionService.swift
//  karma
//
//  Created by Tommaso Bucaioni on 29/12/22.
//

import Firebase
import SwiftUI
import FirebaseDatabase

struct CollectionService {
    
    func uploadCollection(title: String, caption: String, amount: Float, image: String, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let data  = ["uid": uid,
                     "title": title,
                     "caption": caption,
                     "collectionImageUrl": image,
                     "amount": amount,
                     "currentAmount": 0,
                     "favourites": 0,
                     "participants": 0,
                     "timestamp": Timestamp(date: Date())] as [String : Any]
        
        Firestore.firestore().collection("collections").document()
            .setData(data) { error in
                if let error = error {
                    print("DEBUG: Failed to upload collection with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }
    
    
    //fetching collections for DashboardView and exploreView
    func fetchCollections(completion: @escaping([Collection]) -> Void) {
        Firestore.firestore().collection("collections")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let collections = documents.compactMap({try? $0.data(as: Collection.self)})
                
                completion(collections)
            }
    }
    
    //    func fetchUserCollection(collections: [Collection], completion: @escaping([String]) -> Void) {
    //        var users = [String]()
    //        let ref = Database.database().reference()
    //        for i in 0 ..< collections.count {
    //            ref.child("users/\(collections[i].uid)/username").getData { error, snapshot in
    //                if let error = error {
    //                    print("DEBUG: Failed to upload usernames with error: \(error.localizedDescription)")
    //                    return
    //                }
    //                let username = snapshot?.value as? String ?? ""
    //                users.append(username)
    //
    //            }
    //            completion(users)
    //        }
    //
    //    }
    
    
    func fetchSingleCollection(forCid cid: String, completion: @escaping(Collection) -> Void) {
        Firestore.firestore().collection("collections").document(cid).getDocument{ snapshot, _ in
            guard let snapshot = snapshot else { return }
            
            guard let collection = try? snapshot.data(as: Collection.self) else { return }
            completion(collection)
        }
    }
    
    
    //fetching collections for personal User
    func fetchCollections(forUid uid: String, completion: @escaping([Collection]) -> Void) {
        Firestore.firestore().collection("collections")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let collections = documents.compactMap({try? $0.data(as: Collection.self) })
                completion(collections.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            }
    }
    
    func addToFavourite(_ collection: Collection, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let collId = collection.id else { return }
        let userFavRef = Firestore.firestore().collection("users").document(uid).collection("user-favs")
        
        Firestore.firestore().collection("collections").document(collId)
            .updateData(["favourites": collection.favourites + 1]) { _ in
                userFavRef.document(collId).setData([:]) { _ in
                    completion()
                }
            }
    }
    

    
    
    
    func checkIfUserlikedCollection(_ collection: Collection, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let collId = collection.id else { return }
        
        Firestore.firestore().collection("users").document(uid).collection("user-favs").document(collId).getDocument { snapshot, _ in
            guard let snapshot = snapshot else { return }
            
            completion(snapshot.exists)
        }
    }
    
    func removeFromFavourite(_ collection: Collection, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let collId = collection.id else { return }
        guard collection.favourites > 0 else { return }
        
        let userFavRef = Firestore.firestore().collection("users").document(uid).collection("user-favs")
        
        Firestore.firestore().collection("collections").document(collId)
            .updateData(["favourites": collection.favourites - 1]) { _ in
                userFavRef.document(collId).delete() { _ in
                    completion()
                }
            }
        
    }
}
