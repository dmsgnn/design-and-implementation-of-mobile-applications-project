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
    }
    
    func addToFavourite() {
        service.addToFavourite(collection) {
            self.collection.didLike = true 
            
        }
    }
}
