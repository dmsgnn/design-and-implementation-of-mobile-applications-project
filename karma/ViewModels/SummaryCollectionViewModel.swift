//
//  SummaryCollectionViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 12/01/23.
//

import Foundation

class SummaryCollectionViewModel: ObservableObject {
    
    private let service = CollectionService()
    private let userService = UserService()
    @Published var collection: Collection

    
    private let paymentService = PaymentService()
    @Published var payments = [Payment]()
    
    init(collection: Collection) {
        self.collection = collection
        self.fetchPaymentsForCollection()
        self.checkIfUserLikedCollection()
    }
    
    func fetchPaymentsForCollection() {
        guard let cid = collection.id else { return }
        paymentService.fetchPaymentsForCollection(forCid: cid) { payments in
            self.payments = payments
        }
    }
    
    func addToFavourite() {
        service.addToFavourite(collection) {
            self.collection.didLike = true
        }
    }
       
    func removeFromFavourite() {
        service.removeFromFavourite(collection) {
            self.collection.didLike = false
        }
    }
    
    func checkIfUserLikedCollection() {
        service.checkIfUserlikedCollection(collection) { didLike in
            if didLike {
                self.collection.didLike = true
            }
        }
    }
    
    func deleteCollection() {
        service.deleteCollection(collection) { success in
                if success {
                    print("collection deleted")
                }
        }
    }
    
    func fetchCollection() {
        guard let cid = collection.id else { return }
        service.fetchSingleCollection(forCid: cid) { collection in
            self.collection = collection
        }
        
//        let ownerID = collection.uid
//        userService.fetchUser(withUid: ownerID) { owner in
//            self.collection.user = owner
//        }
    }
    
//    func fetchUserCollections() {
//        guard let uid = user.id else { return }
//        DispatchQueue.main.async {
//            self.service.fetchCollections(forUid: uid) { collections in
//                self.collections = collections
//                for i in 0 ..< collections.count {
//                    self.collections[i].user = self.user
//                }
//            }
//        }
//    }
    
}
