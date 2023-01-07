//
//  CollectionViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 30/12/22.
//

import Foundation
import Firebase
import SwiftUI

class CollectionViewModel: ObservableObject {
    
    private let service = CollectionService()
    @Published var collection: Collection
    @Published private var total: Float = 0.0
    
//    let paymentHandler = PaymentHandler()
//    @Published var paymentSuccess = false
    
    
    init(collection: Collection) {
        self.collection = collection
        checkIfUserLikedCollection()
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
    
//    func makePayment() {
//        paymentHandler.startPayment(collection: collection, total: total) { success in
//            self.paymentSuccess = success
//        }
//        
//        let destinationId = collection.uid
//        service.makePayment(destinationId: destinationId, collection, total: total)
//    }
}
