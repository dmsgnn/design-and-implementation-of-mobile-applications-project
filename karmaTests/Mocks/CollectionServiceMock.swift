//
//  CollectionServiceMock.swift
//  karmaTests
//
//  Created by Giovanni Demasi on 29/01/23.
//

import Foundation
import Combine

class CollectionServiceMock : CollectionServiceProtocol {
    
    @Published private(set) var addToFavouriteIsCalled = false
    
    func uploadCollection(title: String, caption: String, amount: Float, image: String, completion: @escaping(Bool) -> Void){
        
    }
    
    func fetchCollections(completion: @escaping([Collection]) -> Void){
        
    }
    
    func fetchSingleCollection(forCid cid: String, completion: @escaping(Collection) -> Void){
        
    }
    
    func fetchCollections(forUid uid: String, completion: @escaping([Collection]) -> Void){
        
    }
    
    func fetchFavouritesCollections(completion: @escaping([Collection]) -> Void){
        
    }
    
    func addToFavourite(_ collection: Collection, completion: @escaping() -> Void){
        addToFavouriteIsCalled = true
        completion()
        
    }
    
    func checkIfUserlikedCollection(_ collection: Collection, completion: @escaping(Bool) -> Void){
        
    }
    
    func removeFromFavourite(_ collection: Collection, completion: @escaping() -> Void){
        
    }
    
    func deleteCollection(_ collection: Collection, completion: @escaping(Bool) -> Void){
        
    }
    
    func updateCollectionData(_ collection: Collection, title: String, description: String, amount: Float, completion: @escaping(Bool) -> Void){
        
    }
}
