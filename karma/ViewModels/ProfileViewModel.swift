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
    @Published var sentPayments = [Payment]()
//    private var receivedPayments = [Payment]()
//    @Published var totalPayments = [Payment]()
//    @Published var balance: Float
    
    
    init(user: User) {
        self.user = user
        self.fetchUserCollections()
        self.fetchSenderPayments()
//        self.fetchReceiverPayments()
//        for i in 0 ..< self.sentPayments.count {
//            self.balance += self.sentPayments[i].total
//        }
//        print(self.balance)
        
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
    
    //fetch payment where user is the Sender
    func fetchSenderPayments() {
        guard let uid = user.id else { return }
        paymentService.fetchPaymentsForSender(forUid: uid) { payments in
            self.sentPayments = payments
            for i in 0 ..< payments.count {
                self.sentPayments[i].sender = self.user
                self.sentPayments[i].isPositive = false
            }
            
        }
    }
    
//    func fetchReceiverPayments() {
//        guard let uid = user.id else { return }
//        paymentService.fetchPaymentsForReceiver(forUid: uid) { payments in
//            self.receivedPayments = payments
//            for i in 0 ..< payments.count {
//                self.receivedPayments[i].receiver = self.user
//                self.receivedPayments[i].isPositive = true
//            }
//        }
//    }
    
}

