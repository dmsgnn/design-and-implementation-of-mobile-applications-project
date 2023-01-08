//
//  SearchViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 05/01/23.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var searchText = ""
    @Published var collections = [Collection]()
    
    
    var searchableCollections: [Collection] {
        if searchText.isEmpty {
            return collections
        } else {
            
            let lowercasedQuery = searchText.lowercased()
            return collections.filter({
                
                $0.title.lowercased().contains(lowercasedQuery) ||
                $0.caption.lowercased().contains(lowercasedQuery)
            })
        }
        
    }
    
    var searchableUsers: [User] {
        if searchText.isEmpty {
            return users
        } else {
            let lowercasedQUery = searchText.lowercased()
            
            return users.filter({
                $0.username.contains(lowercasedQUery) ||
                $0.fullname.lowercased().contains(lowercasedQUery)
            })
        }
    }
        
    let service = UserService()
    let collectionService = CollectionService()
    
    init() {
        fetchUsers()
        fetchCollections()
    }
    
    func fetchUsers() {
        service.fetchUsers { users in
            self.users = users
        }
    }
    func fetchCollections() {
        collectionService.fetchCollections { collections in
            self.collections = collections
        }
    }
        
}
