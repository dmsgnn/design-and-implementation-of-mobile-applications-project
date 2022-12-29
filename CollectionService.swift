//
//  CollectionService.swift
//  karma
//
//  Created by Tommaso Bucaioni on 29/12/22.
//

import Firebase

struct CollectionService {
    
    func uploadCollection(title: String, caption: String, amount: Float, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data  = ["uid": uid,
                     "title": title,
                     "caption": caption,
                     "amount": amount,
                     "currentAmount": 0,
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
    
    //fetching collections for DashboardView
    func fetchCollections(completion: @escaping([Collection]) -> Void) {
        Firestore.firestore().collection("collections")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let collections = documents.compactMap({try? $0.data(as: Collection.self) })
                completion(collections)
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
}

