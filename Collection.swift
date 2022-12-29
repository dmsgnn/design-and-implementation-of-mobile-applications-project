//
//  Collection.swift
//  karma
//
//  Created by Tommaso Bucaioni on 29/12/22.
//

import FirebaseFirestoreSwift
import Firebase

struct Collection: Identifiable, Decodable {
    @DocumentID var id: String?
    let title: String
    let caption: String
    let amount: Float
    var currentAmount: Float
    var participants: Int
    let timestamp: Timestamp
    let uid: String
    
    var user: User?
}

