//
//  RecentUserActivityViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 12/01/23.
//

import Foundation

class RecentUserActivityViewModel: ObservableObject {
    
    private let service = PaymentService()
    private let collectionService = CollectionService()
    @Published var payment: Payment
    private let userService = UserService()
    

    
    init(payment: Payment) {
        self.payment = payment
        fetchCollectionPayment()
        fetchReceiver()
        fetchSender()
        
    }
    
    func fetchCollectionPayment() {
        let cid = payment.collectionId
        collectionService.fetchSingleCollection(forCid: cid) { collection in
            self.payment.collection = collection
        }
    }
    
    func fetchReceiver() {
        let rid = payment.destinationId
        userService.fetchUser(withUid: rid) { user in
            self.payment.receiver = user
        }
    }
    
    func fetchSender() {
        let rid = payment.senderId
        userService.fetchUser(withUid: rid) { user in
            self.payment.sender = user
        }
    }
}
