//
//  EditProfileViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 21/01/23.
//

import Foundation
import SwiftUI
import Firebase

class EditProfileViewModel: ObservableObject {
    
    private let service = UserService()
    @Published var didEditProfile = false
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func updateUserData(fullname: String, username: String) {
        if fullname == "" && username != "" {
            service.updateUserData(fullname: user.fullname, username: username) { success in
                if success {
                    self.didEditProfile = true
                } else {
                    
                }
            }
        } else if username == "" && fullname != "" {
            service.updateUserData(fullname: fullname, username: user.username) { success in
                if success {
                    self.didEditProfile = true
                } else {
                    
                }
            }
        } else if username == "" && fullname == "" {
            service.updateUserData(fullname: user.fullname, username: user.username) { success in
                if success {
                    self.didEditProfile = true
                } else {
                    
                }
            }
        } else {
            service.updateUserData(fullname: fullname, username: username) { success in
                if success {
                    self.didEditProfile = true
                } else {
                }
            }
        }
    }
    
    func editImage(_ image: UIImage) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users").document(uid).updateData(["profileImageUrl": profileImageUrl]) { _ in
                print(profileImageUrl)
            }
        }
    }
}
