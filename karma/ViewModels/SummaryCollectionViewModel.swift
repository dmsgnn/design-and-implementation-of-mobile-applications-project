//
//  SummaryCollectionViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 12/01/23.
//

import Foundation

class SummaryCollectionViewModel: ObservableObject {
    
    private let service = CollectionService()
    @Published var collection: Collection
    
    init(collection: Collection) {
        self.collection = collection
    }
    
}
