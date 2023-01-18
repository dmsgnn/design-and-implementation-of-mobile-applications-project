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
    }
    
    func fetchPaymentsForCollection() {
        guard let cid = collection.id else { return }
        paymentService.fetchPaymentsForCollection(forCid: cid) { payments in
            self.payments = payments
        }
    }
    
}
