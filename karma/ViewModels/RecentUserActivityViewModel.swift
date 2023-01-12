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

    
    init(payment: Payment) {
        self.payment = payment
        fetchCollectionPayment()
    }
    
    func fetchCollectionPayment() {
        let cid = payment.collectionId
        collectionService.fetchSingleCollection(forCid: cid) { collection in
            self.payment.collection = collection
        }
    }
}
