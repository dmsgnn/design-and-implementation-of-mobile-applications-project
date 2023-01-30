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

final class PropertyExpectation<T: AnyObject, V: Equatable>: XCTNSPredicateExpectation {
    init(object: T, keyPath: KeyPath<T, V>, expectedValue: V) {
        let predicate = NSPredicate(block: { _, _ in
            return object[keyPath: keyPath] == expectedValue
        })
        super.init(predicate: predicate, object: nil)
    }
}

final class karmaTests: XCTestCase {
    
    private var cancellable = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        print("Setting up Firebase emulator localhost:8080")
        FirebaseApp.configure()
        Auth.auth().useEmulator(withHost: "127.0.0.1", port: 9099)
        Storage.storage().useEmulator(withHost: "127.0.0.1", port: 9199)
        //Firestore.firestore().useEmulator(withHost: "127.0.0.1", port: 8080)
        let settings = Firestore.firestore().settings
        settings.host = "127.0.0.1:8080"
        settings.isPersistenceEnabled = false
        settings.isSSLEnabled = false
        Firestore.firestore().settings = settings
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        let collection = Collection(title: "Title", caption: "Caption", amount: 20000, currentAmount: 0, favourites: 0, participants: 1, collectionImageUrl: "", timestamp: Timestamp(), uid: "")
        let collectionService = CollectionServiceMock()
        let collectionVM = CollectionViewModel(collection: collection, service: collectionService)
        
        collectionVM.addToFavourite()
        XCTAssertEqual(collectionVM.collection.didLike, true)
        XCTAssertEqual(collectionService.addToFavouriteIsCalled, true)

        
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
