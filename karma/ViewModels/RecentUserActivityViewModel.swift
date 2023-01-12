//
//  RecentUserActivityViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 12/01/23.
//

import Foundation

class RecentUserActivityViewModel: ObservableObject {
    
    private let service = PaymentService()
    @Published var payment: Payment
    
    init(payment: Payment) {
        self.payment = payment
    }
    
//    func fetchCollectionPayment() {
//        service.fetchPaymentForCollection(forCid: <#T##String#>, completion: <#T##([Payment]) -> Void#>)
//    }
}
