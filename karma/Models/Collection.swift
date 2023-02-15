//
//  Collection.swift
//  karma
//
//  Created by Tommaso Bucaioni on 29/12/22.
//

import FirebaseFirestoreSwift
import Firebase
import FirebaseFirestore


struct Collection: Identifiable, Decodable {
    @DocumentID var id: String?
    let title: String
    let caption: String
    let amount: Float
    var currentAmount: Float
    var favourites: Int
    var participants: Int
    let collectionImageUrl: String
    let timestamp: Timestamp
    let uid: String

    var user: User? //contains owner of collection 
//    var didMakePayment: Bool? = false
    var didLike: Bool? = false
}

