//
//  PaymentService.swift
//  karma
//
//  Created by Tommaso Bucaioni on 03/01/23.
//

import Foundation
import PassKit


typealias PaymentCompletionHandler = (Bool) -> Void
    
class PaymentHandler:NSObject {
    var paymentController: PKPaymentAuthorizationController?
    var paymentSummaryItem = [PKPaymentSummaryItem]()
    var paymentStatus = PKPaymentAuthorizationStatus.failure
    var completionHandler: PaymentCompletionHandler?
    
    static let supportedNetworks: [PKPaymentNetwork] = [
        .visa,
        .masterCard
    ]
    
    func startPayment(collection: Collection, total: Float, completion: @escaping PaymentCompletionHandler) {
        completionHandler = completion
        
        let item = PKPaymentSummaryItem(label: collection.title, amount: NSDecimalNumber(string: "\(total)"))
        
        paymentSummaryItem.append(item)
        
        let paymentRequest = PKPaymentRequest()
        paymentRequest.paymentSummaryItems = paymentSummaryItem
//        paymentRequest.merchantIdentifier = ""
//        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.countryCode = "US"
        paymentRequest.currencyCode = "USD"
        paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks
//        paymentRequest.shippingMethods = .none
//        paymentRequest.shippingType = .shipping
//        paymentRequest.requiredShippingContactFields = [.name, .postalAddress]
        
        
        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController?.delegate = self
        paymentController?.present(completion: { (presented: Bool) in
            if presented {
                debugPrint("Present payment controller")
            } else {
                debugPrint("Failed to present payment controller")
            }
        })

    }
}
        
                                    

extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        let errors = [Error]()
        let status = PKPaymentAuthorizationStatus.success
        
        self.paymentStatus = status
        completion(PKPaymentAuthorizationResult(status: status, errors: errors))
    }
    
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss {
            DispatchQueue.main.async {
                if self.paymentStatus == .success {
                    if let completionHandler = self.completionHandler {
                        completionHandler(true)
                    } else {
                        if let completionHandler = self.completionHandler {
                            completionHandler(false)
                        }
                    }
                }
            }
        }
    }
}
