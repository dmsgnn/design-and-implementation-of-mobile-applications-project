//
//  CollectionServiceMock.swift
//  karmaTests
//
//  Created by Giovanni Demasi on 29/01/23.
//

import Foundation
import Combine
import FirebaseFirestore

class CollectionServiceMock : CollectionServiceProtocol {
    
    @Published private(set) var addToFavouriteIsCalled = false
    @Published private(set) var uploadCollectionIsCalled = false
    @Published private(set) var fetchCollectionsIsCalled = false
    @Published private(set) var fetchSingleCollectionsIsCalled = false
    @Published private(set) var fetchCollectionsUIDIsCalled = false
    @Published private(set) var fetchFavouritesCollectionsIsCalled = false
    @Published private(set) var checkIfUserLikedCollectionIsCalled = false
    @Published private(set) var removeFromFavouriteIsCalled = false
    @Published private(set) var deleteCollectionIsCalled = false
    @Published private(set) var updateCollectionIsCalled = false


    @Published private(set) var collections = [Collection] ()
    @Published private(set) var favourites = [Collection] ()

    
    func uploadCollection(title: String, caption: String, amount: Float, image: String, completion: @escaping(Bool) -> Void){
        uploadCollectionIsCalled = true
        var coll = Collection(id:"cc1", title: title, caption: caption, amount: amount, currentAmount: 0, favourites: 0, participants: 1, collectionImageUrl: image, timestamp: Timestamp(date: Date()), uid: "1")
        let user = User(id: "1", username: "User", fullname: "Name", profileImageUrl: "", email: "email@gmail.com")
        coll.user = user
        collections.append(coll)
        completion(true)
    }
    
    func fetchCollections(completion: @escaping([Collection]) -> Void){
        fetchCollectionsIsCalled = true
        completion(collections)
    }
    
    func fetchSingleCollection(forCid cid: String, completion: @escaping(Collection) -> Void){
        fetchSingleCollectionsIsCalled = true
        completion(collections.first(where: {$0.id == cid})!)
    }
    
    func fetchCollections(forUid uid: String, completion: @escaping([Collection]) -> Void){
        fetchCollectionsUIDIsCalled = true
        var c = [Collection] ()
        for i in collections{
            if i.uid == uid{
                c.append(i)
            }
        }
        completion(c)
    }
    
    func fetchFavouritesCollections(completion: @escaping([Collection]) -> Void){
        fetchFavouritesCollectionsIsCalled = true
        completion(favourites)
    }
    
    func addToFavourite(_ collection: Collection, completion: @escaping() -> Void){
        addToFavouriteIsCalled = true
        favourites.append(collection)
        completion()
        
    }
    
    func checkIfUserlikedCollection(_ collection: Collection, completion: @escaping(Bool) -> Void){
        checkIfUserLikedCollectionIsCalled = true
        if(collection.didLike == true){
            completion(true)
        }
        else{
            completion(false)
        }
    }
    
    func removeFromFavourite(_ collection: Collection, completion: @escaping() -> Void){
        removeFromFavouriteIsCalled = true
        var k = 0
        for i in favourites{
            if i.id == collection.id{
                favourites.remove(at: k)
                break
            }
            k+=1
        }
        completion()
    }
    
    func deleteCollection(_ collection: Collection, completion: @escaping(Bool) -> Void){
        deleteCollectionIsCalled  = true
        var k = 0
        var removed = false
        for i in collections{
            if i.id == collection.id{
                collections.remove(at: k)
                removed = true
                break
            }
            k+=1
        }
        if removed {
            completion(true)
        }
        else{
            completion(false)
        }
    }
    
    func updateCollectionData(_ collection: Collection, title: String, description: String, amount: Float, completion: @escaping(Bool) -> Void){
        uploadCollectionIsCalled = true
        var k = 0
        var updated = false
        for i in collections{
            if i.id == collection.id{
                let c = Collection(id: i.id ,title: title, caption: description, amount: amount, currentAmount: i.currentAmount, favourites: i.favourites, participants: i.participants, collectionImageUrl: i.collectionImageUrl, timestamp: i.timestamp, uid: i.uid)
                collections.remove(at: k)
                collections.append(c)
                updated = true
                break
            }
            k+=1
        }
        if updated {
            completion(true)
        }
        else{
            completion(false)
        }
    }
}
