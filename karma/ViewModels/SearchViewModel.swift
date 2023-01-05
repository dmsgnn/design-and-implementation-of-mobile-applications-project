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
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        service.fetchUsers { users in
            self.users = users
            
            print("DEBUG: Users \(users)")
        }
    }
        
}
