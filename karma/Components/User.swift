//
//  User.swift
//  karma
//
//  Created by Tommaso Bucaioni on 27/12/22.
//

import FirebaseFirestoreSwift
struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let email: String
}
