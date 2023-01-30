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
    
    // MARK: CollectionViewModel
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
    
    // MARK: ProfileViewModel
    func testFetchUser(){
        let userService = UserServiceMock()
        let paymentService = PaymentServiceMock()
        let collectionService = CollectionServiceMock()
        let user = User(id: "1", username: "MAN", fullname: "NAM", profileImageUrl: "", email: "mail@gmail.com")
        
        let profileVM = ProfileViewModel(user: user, userService: userService, service: collectionService, paymentService: paymentService)
        
        profileVM.fetchUser()
        XCTAssertTrue(userService.fetchUserIsCalled)
        XCTAssertEqual(profileVM.user.email, "email@gmail.com")
        XCTAssertEqual(profileVM.user.username, "User")
        XCTAssertEqual(profileVM.user.fullname, "Name")
    }
    
    func testFetchUserCollections(){
        let userService = UserServiceMock()
        let paymentService = PaymentServiceMock()
        let collectionService = CollectionServiceMock()
        let user = User(id: "1", username: "User", fullname: "Name", profileImageUrl: "", email: "email@gmail.com")
        var collection = Collection(title: "Title", caption: "Caption", amount: 20000, currentAmount: 0, favourites: 0, participants: 1, collectionImageUrl: "", timestamp: Timestamp(), uid: "1")
        collection.user = user
        
        let profileVM = ProfileViewModel(user: user, userService: userService, service: collectionService, paymentService: paymentService)
        
        let uploadCollectionVM = UploadCollectionViewModel(service: collectionService, uploader: ImageUploaderMock())
        uploadCollectionVM.uploadCollection(withTitle: "title", withCaption: "Caption", withAmount: 20000, withImage: UIImage())
        XCTAssertEqual(uploadCollectionVM.didUploadCollection, true)
        XCTAssertEqual(collectionService.uploadCollectionIsCalled, true)

        XCTAssertEqual(collectionService.collections.count, 1)
        XCTAssertEqual(collectionService.collections[0].uid, profileVM.user.id)
        XCTAssertEqual(collectionService.collections[0].user?.id, profileVM.user.id)

        
        profileVM.fetchUserCollections()
        XCTAssertEqual(collectionService.collections.count, 1)
        XCTAssertEqual(collectionService.collections[0].uid, profileVM.user.id)
        XCTAssertEqual(collectionService.collections[0].user?.id, profileVM.user.id)

    }
    
    func testFetchPayments(){
        let userService = UserServiceMock()
        let paymentService = PaymentServiceMock()
        let collectionService = CollectionServiceMock()
        let user = User(id: "1", username: "User", fullname: "Name", profileImageUrl: "", email: "email@gmail.com")
        var collection = Collection(id : "c1", title: "Title", caption: "Caption", amount: 20000, currentAmount: 0, favourites: 0, participants: 1, collectionImageUrl: "", timestamp: Timestamp(), uid: "2")
        
        let user2 = User(id: "2", username: "User", fullname: "Name", profileImageUrl: "", email: "email@gmail.com")
        var collection2 = Collection(id : "c2", title: "Title", caption: "Caption", amount: 20000, currentAmount: 0, favourites: 0, participants: 1, collectionImageUrl: "", timestamp: Timestamp(), uid: "1")

        collection.user = user2
        collection2.user = user
        
        let profileVM = ProfileViewModel(user: user, userService: userService, service: collectionService, paymentService: paymentService)
        
        let paymentVM = PaymentViewModel(service: paymentService)
        paymentVM.makePayment(forCollection: collection, ofAmount: 20)
        XCTAssertEqual(paymentVM.didMakePayment, true)
        paymentVM.makePayment(forCollection: collection2, ofAmount: 40)

        
        profileVM.fetchPayments()
        XCTAssertTrue(paymentService.fetchPaymentsForReceiverIsCalled)
        XCTAssertTrue(paymentService.fetchPaymentsForSenderIsCalled)

        XCTAssertEqual(paymentService.payments.count, 2)
        XCTAssertEqual(profileVM.balance, 20)

        XCTAssertEqual(profileVM.sentPayments.count, 1)
        XCTAssertEqual(profileVM.receivedPayments.count, 1)

        
        
    }
}
