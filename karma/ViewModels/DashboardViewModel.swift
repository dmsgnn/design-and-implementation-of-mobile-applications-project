//
//  DashboardViewModel.swift
//  karma
//
//  Created by Giovanni Demasi on 26/12/22.
//
import Foundation

class DashboardViewModel: ObservableObject {
    
    @Published var collections = [Collection]()
    @Published var users = [User]()
    private let service = CollectionService()
    let userService = UserService()
    
    
    init() {
        self.updateHome()
    }
    
    func updateHome() {
        collections.removeAll()
        service.fetchCollections() { collections in
            self.collections = collections
            for i in 0 ..< collections.count {
                let uid = collections[i].uid
                self.userService.fetchUser(withUid: uid) { user in
                    self.collections[i].user = user
                }
            }
        }
    }
    
}
