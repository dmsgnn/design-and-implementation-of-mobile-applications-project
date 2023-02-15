//
//  PaymentService.swift
//  karma
//
//  Created by Tommaso Bucaioni on 03/01/23.
//

import Foundation
//import PassKit
import Firebase
import SwiftUI
import FirebaseDatabase
import FirebaseFirestore

protocol PaymentServiceProtocol {
    
    func makePayment(destinationId: String, collection: Collection, total: Float, completion: @escaping(Bool) -> Void)
    
    func fetchPaymentsForCollection(forCid cid: String, completion:@escaping([Payment]) -> Void)
    
    func fetchPaymentsForSender(forUid uid: String, completion: @escaping([Payment]) -> Void)
    
    func fetchPaymentsForReceiver(forUid uid: String, completion: @escaping([Payment]) -> Void)
    
}

struct PaymentService : PaymentServiceProtocol{
    
    
    
    func makePayment(destinationId: String, collection: Collection, total: Float, completion: @escaping(Bool) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let collId = collection.id else { return }
        let data = ["senderId": uid,
                    "destinationId": destinationId,
                    "collectionId": collId,
                    "total": total,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        Firestore.firestore().collection("payments").document().setData(data) { error in
            if let error = error {
                print("DEBUG: Failed to upload pay with error. \(error.localizedDescription)")
            }
            
            let ref = Firestore.firestore().collection("collections").document(collId).collection("Received-payments")
        
            Firestore.firestore().collection("collections").document(collId).updateData(["currentAmount": collection.currentAmount + total, "participants": collection.participants + 1]) { _ in
                ref.document(uid).setData([:]) { _ in
                    completion(true)
                }
                completion(false)
            }
        }
    }
        
//    func checkIfUserPayed(_ collection: Collection, completion:@escaping(Bool) -> Void) {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        guard let collId = collection.id else { return }
//        
//        Firestore.firestore().collection("collections").document(collId).collection("Received-payments").document(uid).getDocument { snapshot, _ in
//            guard let snapshot = snapshot else { return }
//            
//            completion(snapshot.exists)
//        }
//    }
        
    
    //function to retrieve payment related to collection cid
    func fetchPaymentsForCollection(forCid cid: String, completion:@escaping([Payment]) -> Void) {
        Firestore.firestore().collection("payments").whereField("collectionId", isEqualTo: cid).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let payments = documents.compactMap({try? $0.data(as: Payment.self) })
            completion(payments.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
        }
    }
    
    //function to retrieve payment related to sender uid
    func fetchPaymentsForSender(forUid uid: String, completion: @escaping([Payment]) -> Void) {
        Firestore.firestore().collection("payments").whereField("senderId", isEqualTo: uid).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let payments = documents.compactMap({try? $0.data(as: Payment.self) })
            completion(payments.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
        }
    }
    
    //function to retrieve payment related to receiver iuid
    func fetchPaymentsForReceiver(forUid uid: String, completion: @escaping([Payment]) -> Void) {
        Firestore.firestore().collection("payments").whereField("destinationId", isEqualTo: uid).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let payments = documents.compactMap({try? $0.data(as: Payment.self) })
            completion(payments.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
        }
    }
}


//typealias PaymentCompletionHandler = (Bool) -> Void
//
//class PaymentHandler:NSObject {
//    var paymentController: PKPaymentAuthorizationController?
//    var paymentSummaryItem = [PKPaymentSummaryItem]()
//    var paymentStatus = PKPaymentAuthorizationStatus.failure
//    var completionHandler: PaymentCompletionHandler?
//
//    static let supportedNetworks: [PKPaymentNetwork] = [
//        .visa,
//        .masterCard
//    ]
//
//    func startPayment(collection: Collection, total: Float, completion: @escaping PaymentCompletionHandler) {
//        completionHandler = completion
//
//        let item = PKPaymentSummaryItem(label: collection.title, amount: NSDecimalNumber(string: "\(total)"))
//
//        paymentSummaryItem.append(item)
//
//        let paymentRequest = PKPaymentRequest()
//        paymentRequest.paymentSummaryItems = paymentSummaryItem
//        //        paymentRequest.merchantIdentifier = ""
//        //        paymentRequest.merchantCapabilities = .capability3DS
//        paymentRequest.countryCode = "US"
//        paymentRequest.currencyCode = "USD"
//        paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks
//        //        paymentRequest.shippingMethods = .none
//        //        paymentRequest.shippingType = .shipping
//        //        paymentRequest.requiredShippingContactFields = [.name, .postalAddress]
//
//
//        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
//        paymentController?.delegate = self
//        paymentController?.present(completion: { (presented: Bool) in
//            if presented {
//                debugPrint("Present payment controller")
//            } else {
//                debugPrint("Failed to present payment controller")
//            }
//        })
//
//    }
//}
//
//
//
//extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {
//    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
//        let errors = [Error]()
//        let status = PKPaymentAuthorizationStatus.success
//
//        self.paymentStatus = status
//        completion(PKPaymentAuthorizationResult(status: status, errors: errors))
//    }
//
//    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
//        controller.dismiss {
//
//            if self.paymentStatus == .success {
//                if let completionHandler = self.completionHandler {
//                    completionHandler(true)
//                } else {
//                    if let completionHandler = self.completionHandler {
//                        completionHandler(false)
//                    }
//                }
//
//            }
//        }
//    }
//}
