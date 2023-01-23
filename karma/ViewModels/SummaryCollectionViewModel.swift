//
//  SummaryCollectionViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 12/01/23.
//

import Foundation

class SummaryCollectionViewModel: ObservableObject {
    
    private let service = CollectionService()
    @Published var collection: Collection

    
    private let paymentService = PaymentService()
    @Published var payments = [Payment]()
    
    init(collection: Collection) {
        self.collection = collection
        self.fetchPaymentsForCollection()
        checkIfUserLikedCollection()
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
    
}
