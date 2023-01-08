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
    
    func makePayment(forCollection collection: Collection, ofAmount euros: Float) {
        let destination = collection.uid
        
        service.makePayment(destinationId: destination, collection: collection, total: euros) {
            success in
            if success {
                self.didMakePayment = true
                
            } else {
                
            }
            
        }
        
    }
    
}

