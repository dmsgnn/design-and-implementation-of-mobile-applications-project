//
//  ActivityCollectionViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 13/01/23.
//

import Foundation

class ActivityCollectionViewModel: ObservableObject {
    
    private let service : PaymentServiceProtocol
    private let userService : UserServiceProtocol
    
    @Published var payment: Payment
    
    init(payment: Payment, service : PaymentServiceProtocol, userService : UserServiceProtocol) {
        self.service = service
        self.userService = userService
        
        self.payment = payment
        self.fetchSenderForPayment()
    }
    
    func fetchSenderForPayment() {
        let sid = payment.senderId
        userService.fetchUser(withUid: sid) { user in
            self.payment.sender = user
        }
    }
    
}


