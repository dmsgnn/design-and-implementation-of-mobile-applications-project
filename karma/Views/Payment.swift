//
//  Payment.swift
//  karma
//
//  Created by Tommaso Bucaioni on 03/01/23.
//



import FirebaseFirestoreSwift
import Firebase

struct Payment: Identifiable, Decodable {
    @DocumentID var id: String?
    let senderId: String
    let destinationId: String
    let collectionId: String
    let total: Float
    let timestamp: Timestamp
    
    //to retrieve data of the related collection
    var collection: Collection?
    var sender: User?
    
}

