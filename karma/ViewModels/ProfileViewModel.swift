//
//  ProfileViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 29/12/22.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var collections = [Collection]()
    private let service = CollectionService()
    let user: User
    
    init(user: User) {
        self.user = user
        self.fetchUserCollections()
    }
    
    
    func fetchUserCollections() {
        guard let uid = user.id else { return }
        service.fetchCollections(forUid: uid) { collections in
            self.collections = collections
            for i in 0 ..< collections.count {
                self.collections[i].user = self.user
            }
        }
    }
}

