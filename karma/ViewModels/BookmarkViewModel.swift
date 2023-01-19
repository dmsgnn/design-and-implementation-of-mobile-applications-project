//
//  BookmarkViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 19/01/23.
//

import Foundation

class BookmarkViewModel: ObservableObject {
    
    private let service = CollectionService()
    @Published var collections = [Collection]()
    
    init() {
        fetchCollections()
    }
    
    func fetchCollections() {
        service.fetchFavouritesCollections { collections in
            self.collections = collections
        }
        
    }
}
