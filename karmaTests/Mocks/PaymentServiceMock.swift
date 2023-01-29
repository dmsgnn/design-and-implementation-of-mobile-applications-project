//
//  PaymentServiceMock.swift
//  karmaTests
//
//  Created by Giovanni Demasi on 29/01/23.
//

import Foundation

class PaymentServiceMock : PaymentServiceProtocol {
    
    
    func makePayment(destinationId: String, collection: Collection, total: Float, completion: @escaping(Bool) -> Void){
        
    }
    
    func fetchPaymentsForCollection(forCid cid: String, completion:@escaping([Payment]) -> Void){
        
    }
    
    func fetchPaymentsForSender(forUid uid: String, completion: @escaping([Payment]) -> Void){
        
    }
    
    func fetchPaymentsForReceiver(forUid uid: String, completion: @escaping([Payment]) -> Void){
        
    }
    
}
