//
//  CollectionViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 30/12/22.
//

import Foundation

class CollectionViewModel: ObservableObject {
    private let service = CollectionService()
    @Published var collection: Collection
    
    init(collection: Collection) {
        self.collection = collection
        checkIfUserLikedCollection()
    }
    
    func addToFavourite() {
        service.addToFavourite(collection) {
            self.collection.didLike = true 
            
        }
    }
    
    func removeFromFavourite() {
        service.removeFromFavourite(collection) {
            self.collection.didLike = false
        }
    }
    
    func checkIfUserLikedCollection() {
        service.checkIfUserlikedCollection(collection) { didLike in
            if didLike {
                self.collection.didLike = true
            }
        }
    }
}
