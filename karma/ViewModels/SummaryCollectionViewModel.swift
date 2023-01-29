//
//  SummaryCollectionViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 12/01/23.
//

import Foundation

class SummaryCollectionViewModel: ObservableObject {
    
    private let service : CollectionServiceProtocol
    @Published var collection: Collection

    
    private let paymentService = PaymentService()
    @Published var payments = [Payment]()
    
    init(collection: Collection, service: CollectionServiceProtocol) {
        self.collection = collection
        self.service = service
        
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
    
    func fetchCollection() {
        guard let cid = collection.id else { return }
        service.fetchSingleCollection(forCid: cid) { collection in
            self.collection = collection
        }
    }
    
}
