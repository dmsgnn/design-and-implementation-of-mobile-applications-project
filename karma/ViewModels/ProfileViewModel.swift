//
//  ProfileViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 29/12/22.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var collections = [Collection]()
    private let service : CollectionServiceProtocol
    @Published var user: User
    private let paymentService : PaymentServiceProtocol
    @Published var sentPayments = [Payment]()
    @Published var receivedPayments = [Payment]()
    @Published var totalPayments = [Payment]()
    @Published var balance: Float = 0.0
    private let userService : UserServiceProtocol
    

    
    init(user: User, userService: UserServiceProtocol, service : CollectionServiceProtocol, paymentService : PaymentServiceProtocol) {
        self.paymentService = paymentService
        self.userService = userService
        self.service = service
        self.user = user
        self.fetchUserCollections()
        self.fetchPayments()
    }
    
    
    func fetchUserCollections() {
        guard let uid = user.id else { return }
        DispatchQueue.main.async {
            self.service.fetchCollections(forUid: uid) { collections in
                self.collections = collections
                for i in 0 ..< collections.count {
                    self.collections[i].user = self.user
                }
            }
        }
    }
    
    func fetchUser() {
        guard let uid = self.user.id else { return }
        userService.fetchUser(withUid: uid) { user in
            self.user = user
        }
    }
    
    
    func fetchPayments() {
        guard let uid = user.id else { return }
        paymentService.fetchPaymentsForReceiver(forUid: uid) { payments in
            
                self.receivedPayments = payments
                self.balance = 0
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
                    self.totalPayments = self.totalPayments.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
                
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
}
    
