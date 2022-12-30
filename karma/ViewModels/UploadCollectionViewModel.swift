//
//  UploadCollectionViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 29/12/22.
//

import Foundation

class UploadCollectionViewModel: ObservableObject {
    
    @Published var didUploadCollection = false
    let service = CollectionService()
    
    func uploadCollection(withTitle title: String, withCaption caption: String, withAmount amount: Float) {
        service.uploadCollection(title: title, caption: caption, amount: amount) {
            success in
            if success {
                self.didUploadCollection = true
                //dismiss screen somehow
            } else {
                // show error message to user
            }
        }
    }
}

