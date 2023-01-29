//
//  UserServiceMock.swift
//  karmaTests
//
//  Created by Giovanni Demasi on 29/01/23.
//

import Foundation

class UserServiceMock : UserServiceProtocol {
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void){
        
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void){
        
    }
    
    func updateUserData(fullname: String, username: String, completion: @escaping(Bool) -> Void){
        
    }
}
