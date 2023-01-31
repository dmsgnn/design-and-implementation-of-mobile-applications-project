//
//  UserServiceMock.swift
//  karmaTests
//
//  Created by Giovanni Demasi on 29/01/23.
//

import Foundation

class UserServiceMock : UserServiceProtocol {
    
    @Published private(set) var fetchUserIsCalled = false
    @Published private(set) var fetchUsersIsCalled = false
    @Published private(set) var updateUserDataIsCalled = false

    @Published private(set) var users = [User] ()

    // Return the user for the ProfileViewModel
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void){
        fetchUserIsCalled = true
        if uid == "2"{
            let u = User(id: "2", username: "Sec", fullname: "Nam", profileImageUrl: "", email: "lem@gmail.com")
            completion(u)
        }
        else{
            let u = User(id: "1", username: "User", fullname: "Name", profileImageUrl: "", email: "email@gmail.com")
            users.append(u)
            completion(u)
        }
    }
    
    // Return all the registered users for the Search View Model
    func fetchUsers(completion: @escaping([User]) -> Void){
        fetchUsersIsCalled = true
        completion(users)
    }
    
    // Update the user data in the ProfileViewModel
    func updateUserData(fullname: String, username: String, completion: @escaping(Bool) -> Void){
        updateUserDataIsCalled = true
        completion(true)
    }
}
