//
//  ProfileViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 29/12/22.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var collections = [Collection]()
    private let service = CollectionService()
    let user: User
    private let paymentService = PaymentService()
    @Published var payments = [Payment]()
    
    init(user: User) {
        self.user = user
        self.fetchUserCollections()
        self.fetchUserPayments()
    }
    
    
    func fetchUserCollections() {
        guard let uid = user.id else { return }
        service.fetchCollections(forUid: uid) { collections in
            self.collections = collections
            for i in 0 ..< collections.count {
                self.collections[i].user = self.user
            }
        }
    }
    
    func fetchUserPayments() {
        guard let uid = user.id else { return }
        paymentService.fetchPaymentsForSender(forUid: uid) { payments in
            self.payments = payments
            for i in 0 ..< payments.count {
                self.payments[i].sender = self.user
            }
        }
    }
}

