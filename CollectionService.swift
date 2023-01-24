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
                DispatchQueue.main.async {
                    let collections = documents.compactMap({try? $0.data(as: Collection.self)})
                    completion(collections)
                }
            }
    }
    

    
    
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
                DispatchQueue.main.async {
                    let collections = documents.compactMap({try? $0.data(as: Collection.self) })
                    completion(collections.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
                }
            }
    }
    
    func fetchFavouritesCollections(completion: @escaping([Collection]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var collections = [Collection]()
        Firestore.firestore().collection("users").document(uid).collection("user-favs").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            documents.forEach { doc in
                let collId = doc.documentID
                Firestore.firestore().collection("collections").document(collId).getDocument { snapshot, _ in
                    guard let collection = try? snapshot?.data(as: Collection.self) else { return }
                    collections.append(collection)
                    completion(collections)
                }
            }

        }
    }
    
    func addToFavourite(_ collection: Collection, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let collId = collection.id else { return }
        let userFavRef = Firestore.firestore().collection("users").document(uid).collection("user-favs")
        Firestore.firestore().collection("collections").document(collId)
            .updateData(["favourites": collection.favourites + 1]) { _ in
                userFavRef.document(collId).setData([:]) { _ in
                    print("DEBUG: \(uid) \(collId)")
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
    
    func deleteCollection(_ collection: Collection, completion: @escaping(Bool) -> Void) {
        guard let id = collection.id else { return }
        Firestore.firestore().collection("collections").document(id).delete { error in
            if let error = error {
                print("DEBUG: failed with error: \(error.localizedDescription)")
            }
            completion(true)
        }
    }
    
    func updateCollectionData(_ collection: Collection, title: String, description: String, amount: Float, completion: @escaping(Bool) -> Void) {
        guard let id = collection.id else { return }
        Firestore.firestore().collection("collections").document(id).setData(["title" : title, "description" : description, "amount" : amount], merge: true)
        completion(true)
    }
    
    
}
