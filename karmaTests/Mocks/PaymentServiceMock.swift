//
//  PaymentServiceMock.swift
//  karmaTests
//
//  Created by Giovanni Demasi on 29/01/23.
//

import Foundation
import Firebase
import FirebaseFirestore

class PaymentServiceMock : PaymentServiceProtocol {
    
    @Published private(set) var makePaymentIsCalled = false
    @Published private(set) var fetchPaymentsForCollectionIsCalled = false
    @Published private(set) var fetchPaymentsForReceiverIsCalled = false
    @Published private(set) var fetchPaymentsForSenderIsCalled = false
    
    
    @Published private(set) var payments = [Payment] ()
    
    func makePayment(destinationId: String, collection: Collection, total: Float, completion: @escaping(Bool) -> Void){
        makePaymentIsCalled = true
        if collection.uid != "1"{
            var p = Payment(senderId: "1", destinationId: destinationId, collectionId: collection.id!, total: total, timestamp: Timestamp())
            p.receiver = User(id: "2", username: "User", fullname: "Name", profileImageUrl: "", email: "email@gmail.com")
            payments.append(p)
            
        }
        else{
            var p = Payment(senderId: "2", destinationId: destinationId, collectionId: collection.id!, total: total, timestamp: Timestamp())
            p.receiver = User(id: "1", username: "User", fullname: "Name", profileImageUrl: "", email: "email@gmail.com")
            payments.append(p)
        }
        completion(true)
    }
    
    func fetchPaymentsForCollection(forCid cid: String, completion:@escaping([Payment]) -> Void){
        fetchPaymentsForCollectionIsCalled = true
        var c = [Payment] ()
        for i in payments{
            if i.collectionId == cid{
                c.append(i)
            }
        }
        completion(c)
    }
    
    func fetchPaymentsForSender(forUid uid: String, completion: @escaping([Payment]) -> Void){
        fetchPaymentsForSenderIsCalled = true
        var c = [Payment] ()
        for i in payments{
            if i.senderId == uid{
                c.append(i)
            }
        }
        completion(c)
    }
    
    func fetchPaymentsForReceiver(forUid uid: String, completion: @escaping([Payment]) -> Void){
        fetchPaymentsForReceiverIsCalled = true
        var c = [Payment] ()
        for i in payments{
            if i.receiver?.id == uid{
                c.append(i)
            }
        }
        completion(c)
    }
    
}
