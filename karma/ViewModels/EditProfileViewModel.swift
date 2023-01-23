//
//  EditProfileViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 21/01/23.
//

import Foundation

class EditProfileViewModel: ObservableObject {
    
    private let service = UserService()
    @Published var didEditProfile = false
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func updateUserData(fullname: String, username: String) {
        service.updateUserData(fullname: fullname, username: username) { success in
            if success {
                self.didEditProfile = true
            } else {
            }
        }
    }
}
