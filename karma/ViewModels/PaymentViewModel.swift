//
//  PaymentViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 03/01/23.
//

import Foundation
import SwiftUI
import Firebase

class PaymentViewModel: ObservableObject {
    
    @Published var didMakePayment = false
    let service = PaymentService()
    
    let paymentHandler = PaymentHandler()
    @Published private(set) var paymentSuccess = false
    
    func makePayment(forCollection collection: Collection, ofAmount euros: Float) {
        paymentHandler.startPayment(total: euros) { success in
            self.paymentSuccess = success
            let destination = collection.uid
            self.service.makePayment(destinationId: destination, collection: collection, total: euros) {
                success in
                if success {
                    self.didMakePayment = true
                    
                } else {
                    
                }
            }
            
        }
        
    }
    
}

