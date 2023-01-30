//
//  karmaTests.swift
//  karmaTests
//
//  Created by Giovanni Demasi on 05/12/22.
//

import XCTest
@testable import karma
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import Combine

final class karmaTests: XCTestCase {
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
//        print("Setting up Firebase emulator localhost:8080")
//        FirebaseApp.configure()
//        Auth.auth().useEmulator(withHost: "127.0.0.1", port: 9099)
//        Storage.storage().useEmulator(withHost: "127.0.0.1", port: 9199)
//        //Firestore.firestore().useEmulator(withHost: "127.0.0.1", port: 8080)
//        let settings = Firestore.firestore().settings
//        settings.host = "127.0.0.1:8080"
//        settings.isPersistenceEnabled = false
//        settings.isSSLEnabled = false
//        Firestore.firestore().settings = settings
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAddCollectionToFavourites() throws {
        let collection = Collection(title: "Title", caption: "Caption", amount: 20000, currentAmount: 0, favourites: 0, participants: 1, collectionImageUrl: "", timestamp: Timestamp(), uid: "")
        let collectionService = CollectionServiceMock()
        let collectionVM = CollectionViewModel(collection: collection, service: collectionService)
        
        XCTAssertEqual(collectionService.favourites.count, 0)
        collectionVM.addToFavourite()
        XCTAssertEqual(collectionVM.collection.didLike, true)
        XCTAssertEqual(collectionService.addToFavouriteIsCalled, true)
        XCTAssertEqual(collectionService.favourites.count, 1)
    }
    
    func testRemoveCollectionFromFavourites(){
        let collection = Collection(title: "Title", caption: "Caption", amount: 20000, currentAmount: 0, favourites: 0, participants: 1, collectionImageUrl: "", timestamp: Timestamp(), uid: "")
        let collectionService = CollectionServiceMock()
        let collectionVM = CollectionViewModel(collection: collection, service: collectionService)
        
        // Collection is added to favourites
        XCTAssertEqual(collectionService.favourites.count, 0)
        collectionVM.addToFavourite()
        XCTAssertEqual(collectionVM.collection.didLike, true)
        XCTAssertEqual(collectionService.addToFavouriteIsCalled, true)
        XCTAssertEqual(collectionService.favourites.count, 1)
        
        // collection is removed from favourites and like is deleted
        collectionVM.removeFromFavourite()
        XCTAssertEqual(collectionVM.collection.didLike, false)
        XCTAssertEqual(collectionService.removeFromFavouriteIsCalled, true)
        XCTAssertEqual(collectionService.favourites.count, 0)
    }
    
    func testCheckLikedCollection(){
        let collection = Collection(title: "Title", caption: "Caption", amount: 20000, currentAmount: 0, favourites: 0, participants: 1, collectionImageUrl: "", timestamp: Timestamp(), uid: "")
        let collectionService = CollectionServiceMock()
        let collectionVM = CollectionViewModel(collection: collection, service: collectionService)
        
        // Collection is added to favourites
        XCTAssertEqual(collectionService.favourites.count, 0)
        collectionVM.addToFavourite()
        XCTAssertEqual(collectionVM.collection.didLike, true)
        XCTAssertEqual(collectionService.addToFavouriteIsCalled, true)
        XCTAssertEqual(collectionService.favourites.count, 1)
        
        // Collection like is checked
        collectionVM.checkIfUserLikedCollection()
        XCTAssertEqual(collectionService.checkIfUserLikedCollectionIsCalled, true)
        XCTAssertEqual(collectionVM.collection.didLike, true)
        XCTAssertEqual(collectionService.favourites.count, 1)

    }
}
