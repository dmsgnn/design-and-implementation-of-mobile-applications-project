//
//  PaymentViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 03/01/23.
//

//import Foundation
//import SwiftUI
//import Firebase
//
//class PaymentViewModel: ObservableObject {
//    
//    @Published var didMakePayment = false
//    let service = PaymentService()
//    
//    func makePayment(forCollection collection: Collection, ofEuros euros: Float) {
//        let destination = collection.uid
//        guard let collectionId = collection.id else { return }
//        
//        
//        service.makePayment(destinationId: destination, collectionId: collectionId, total: euros) {
//            success in
//            if success {
//                self.didMakePayment = true
//                
//            } else {
//                
//            }
//            
//        }
//        
//    }
//    
//}

