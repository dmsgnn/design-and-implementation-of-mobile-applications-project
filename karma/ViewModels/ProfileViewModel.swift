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
    @Published var receivedPayments = [Payment]()
    @Published var totalPayments = [Payment]()
    @Published var balance: Float = 0.0
    
    
    init(user: User) {
        self.user = user
        self.fetchUserCollections()
        self.fetchPayments()
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
    //    func fetchSenderPayments() {
    //        guard let uid = user.id else { return }
    //        paymentService.fetchPaymentsForSender(forUid: uid) { payments in
    //            self.sentPayments = payments
    //            for i in 0 ..< payments.count {
    //                self.sentPayments[i].sender = self.user
    //                self.sentPayments[i].isPositive = false
    //            }
    //        }
    //    }
    
    func fetchPayments() {
        guard let uid = user.id else { return }
        paymentService.fetchPaymentsForReceiver(forUid: uid) { payments in
            self.receivedPayments = payments
            for i in 0 ..< payments.count {
                self.receivedPayments[i].receiver = self.user
                self.receivedPayments[i].isPositive = true
                self.balance -= self.receivedPayments[i].total
            }
            self.paymentService.fetchPaymentsForSender(forUid: uid) { payments in
                self.sentPayments = payments
                for i in 0 ..< payments.count {
                    self.sentPayments[i].sender = self.user
                    self.sentPayments[i].isPositive = false
                    self.balance += self.sentPayments[i].total
                }
                self.totalPayments = self.receivedPayments + self.sentPayments
                print("total payments" + "\(self.totalPayments.count)")
                self.totalPayments = self.totalPayments.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
            }
        }
    }
}
    
