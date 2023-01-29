//
//  BookmarkViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 19/01/23.
//

import Foundation

class BookmarkViewModel: ObservableObject {
    
    private let service : CollectionServiceProtocol
    @Published var collections = [Collection]()
    
    init(service : CollectionServiceProtocol) {
        self.service = service
        
        fetchCollections()
    }
    
    func fetchCollections() {
        service.fetchFavouritesCollections { collections in
            self.collections = collections
        }
        
    }
}
