//
//  RecentUserActivityViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 12/01/23.
//

import Foundation

class RecentUserActivityViewModel: ObservableObject {

    @Published var payment: Payment
    
    private let userService : UserServiceProtocol
    private let service : PaymentServiceProtocol
    private let collectionService : CollectionServiceProtocol

    
    init(payment: Payment, userService : UserServiceProtocol, service : PaymentServiceProtocol, collectionService : CollectionServiceProtocol) {
        self.payment = payment
        self.userService = userService
        self.service = service
        self.collectionService = collectionService
        
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
