//
//  CampaignRepository.swift
//  karma
//
//  Created by Giovanni Demasi on 26/12/22.
//
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
import Foundation
import Firebase
import UIKit


final class CampaignRepository: ObservableObject {
    private let path = "collections"
    private let store = Firestore.firestore()
    @Published var campaigns: [Collection] = []
    @Published var didUploadCollection = false
    let service = CollectionService()
    
    init() {
        get()
    }
    
    func get() {
        store.collection(path).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            self.campaigns = snapshot?.documents.compactMap{
                try? $0.data(as: Collection.self)
            } ?? []
        }
    }
    
    func add(withTitle title: String, withCaption caption: String, withAmount amount: Float, withImage image: UIImage) {
        
        ImageUploader.uploadCollectionImage(image: image) { collectionImageUrl in
            self.service.uploadCollection(title: title, caption: caption, amount: amount, image: collectionImageUrl) {
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
    
    
    
}
