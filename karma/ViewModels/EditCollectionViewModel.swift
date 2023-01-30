//
//  EditCollectionViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 24/01/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class EditCollectionViewModel: ObservableObject {
    
    private let service : CollectionServiceProtocol
    @Published var didEditCollection = false
    let collection: Collection
    let uploader : ImageUploaderProtocol
    
    init(collection: Collection, service: CollectionServiceProtocol, uploader : ImageUploaderProtocol) {
        self.uploader = uploader
        self.service = service
        self.collection = collection
    }
    
    func updateCollectionData(title: String, description: String, amount: Float) {
        service.updateCollectionData(collection, title: title, description: description, amount: amount) { success in
            if success {
                self.didEditCollection = true
            } else {
                
            }
        }
    }
    
    func editImage(_ image: UIImage) {
        guard let cid = collection.id else { return }
        uploader.uploadImage(image: image) { collectionImageUrl in
            Firestore.firestore().collection("collections").document(cid).updateData(["collectionImageUrl": collectionImageUrl]) { _ in
                print(collectionImageUrl)
            }
        }
    }
    
    
    
}
