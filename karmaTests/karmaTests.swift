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
import ViewInspector
import SwiftUI

final class karmaTests: XCTestCase {
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //        print("Setting up Firebase emulator localhost:8080")
        if(FirebaseApp.app() == nil){
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
    
    func testBookmark(){
        let collectionService = CollectionServiceMock()
        let paymentS = PaymentServiceMock()
        let bookmarkVM = BookmarkViewModel(service: collectionService)
        
        bookmarkVM.fetchCollections()
        XCTAssertEqual(bookmarkVM.collections.count, 0)
        
        let collection = Collection(id : "c1", title: "Title", caption: "Caption", amount: 20000, currentAmount: 0, favourites: 0, participants: 1, collectionImageUrl: "", timestamp: Timestamp(), uid: "2")
        let summaryVM = SummaryCollectionViewModel(collection: collection, service: collectionService, paymentService: paymentS)
        
        summaryVM.addToFavourite()
        bookmarkVM.fetchCollections()
        XCTAssertEqual(bookmarkVM.collections.count, 1)
        XCTAssertEqual(bookmarkVM.collections[0].id, "c1")
    }
    
    func testFetchCollection(){
        let collectionService = CollectionServiceMock()
        let paymentS = PaymentServiceMock()
        
        let collection = Collection(id : "cc1", title: "Title", caption: "Caption", amount: 20000, currentAmount: 0, favourites: 0, participants: 1, collectionImageUrl: "", timestamp: Timestamp(), uid: "2")
        let uploadVM = UploadCollectionViewModel(service: collectionService, uploader: ImageUploaderMock())
        let summaryVM = SummaryCollectionViewModel(collection: collection, service: collectionService, paymentService: paymentS)
        
        uploadVM.uploadCollection(withTitle: "Title", withCaption: "capr", withAmount: 2000, withImage: UIImage())
        
        summaryVM.fetchCollection()
        XCTAssertEqual(summaryVM.collection.id, "cc1")
        
        summaryVM.deleteCollection()
        XCTAssertEqual(collectionService.collections.count, 0)
        
    }
    
    func testSumaryCollectionView() throws {
        let collection = Collection(id : "cc1", title: "coll", caption: "Caption", amount: 20000, currentAmount: 0, favourites: 0, participants: 1, collectionImageUrl: "", timestamp: Timestamp(), uid: "2")
        
        let summaryView = SummaryCollectionView(collection: collection)
        
        let textView = try summaryView.inspect().find(viewWithId: "title").text()
        let content = try textView.string()
        XCTAssertEqual(content, "coll")
    }
    
    func testOwnerSumaryCollectionView() throws {
        var collection = Collection(id : "cc1", title: "coll", caption: "Caption", amount: 20000, currentAmount: 0, favourites: 0, participants: 1, collectionImageUrl: "", timestamp: Timestamp(), uid: "1")
        let user = User(id: "1", username: "User", fullname: "Name", profileImageUrl: "", email: "email@gmail.com")
        collection.user = user
        
        let summaryView = SummaryCollectionView(collection: collection)
        summaryView.authViewModel.currentUser = user
        
        XCTAssertEqual(summaryView.viewModel.collection.user?.id, summaryView.authViewModel.currentUser?.id)
        
        let textView = try summaryView.inspect().find(viewWithId: "title").text()
        let content = try textView.string()
        XCTAssertEqual(content, "coll")
    }
    
    // MARK: EditCollectionViewModel
    func testUploadCollection (){
        let collection = Collection(id : "cc1", title: "Title", caption: "Caption", amount: 3000, currentAmount: 0, favourites: 0, participants: 1, collectionImageUrl: "url", timestamp: Timestamp(), uid: "1")
        let collectionService = CollectionServiceMock()
        let uploader = ImageUploaderMock()
        let editCollVM = EditCollectionViewModel(collection: collection, service: collectionService, uploader: uploader)
        
        let uploadCollVM = UploadCollectionViewModel(service: collectionService, uploader: uploader)
        uploadCollVM.uploadCollection(withTitle: "Title", withCaption: "Caption", withAmount: 3000, withImage: UIImage())
        
        XCTAssertTrue(uploadCollVM.didUploadCollection)
        XCTAssertEqual(collectionService.collections.count, 1)
        XCTAssertEqual(collectionService.collections[0].title, "Title")
        
        editCollVM.updateCollectionData(title: "NewTitle", description: "NewDescription", amount: 3500)
        editCollVM.editImage(UIImage())
        XCTAssertTrue(editCollVM.didEditCollection)
        XCTAssertEqual(collectionService.collections.count, 1)
        XCTAssertEqual(collectionService.collections[0].title, "NewTitle")
    }
    
    // MARK: EditProfileVM
    func testEditUserInfo() {
        let userService = UserServiceMock()
        let uploader = ImageUploaderMock()
        let user = User(id:"1", username: "Username", fullname: "Full", profileImageUrl: "", email: "Mail@gmail.com")
        let editProfileVM = EditProfileViewModel(user: user, service: userService, uploader: uploader)
        
        editProfileVM.editImage(UIImage())
        editProfileVM.updateUserData(fullname: "NewName", username: "")
        XCTAssertTrue(editProfileVM.didEditProfile)
        editProfileVM.updateUserData(fullname: "", username: "username")
        XCTAssertTrue(editProfileVM.didEditProfile)
        editProfileVM.updateUserData(fullname: "", username: "")
        XCTAssertTrue(editProfileVM.didEditProfile)
        editProfileVM.updateUserData(fullname: "NewName", username: "username")
        XCTAssertTrue(editProfileVM.didEditProfile)
    }
    
    // MARK: ActivityCollVM
    func testActivityCollVM (){
        let payment = Payment(id:"p1", senderId: "1", destinationId: "2", collectionId: "cc1", total: 10, timestamp: Timestamp())
        let paymentService = PaymentServiceMock()
        let userService = UserServiceMock()
        
        let actVM = ActivityCollectionViewModel(payment: payment, service: paymentService, userService: userService)
        
        actVM.fetchSenderForPayment()
        XCTAssertEqual(actVM.payment.sender?.id, "1")
        XCTAssertEqual(actVM.payment.sender?.email, "email@gmail.com")
        
    }
    
    // MARK: RecentUserActVM
    func testrecentUserActVM() {
        let payment = Payment(id:"p1", senderId: "1", destinationId: "2", collectionId: "cc1", total: 10, timestamp: Timestamp())
        let paymentService = PaymentServiceMock()
        let userService = UserServiceMock()
        let collectionService = CollectionServiceMock()
        
        let recentUserActVM = RecentUserActivityViewModel(payment: payment, userService: userService, service: paymentService, collectionService: collectionService)
        
        XCTAssertEqual(recentUserActVM.payment.collection?.id, "cc1")
        XCTAssertEqual(recentUserActVM.payment.receiver?.id, "2")
        XCTAssertEqual(recentUserActVM.payment.sender?.id, "1")
    }
    
    // MARK: DashboardVM
    func testDashboardVM (){
        let userService = UserServiceMock()
        let collectionService = CollectionServiceMock()
        let dashboardVM = DashboardViewModel(userService: userService, service: collectionService)
        
        let uploadCollVM = UploadCollectionViewModel(service: collectionService, uploader: ImageUploaderMock())
        uploadCollVM.uploadCollection(withTitle: "Title", withCaption: "Caption", withAmount: 2000, withImage: UIImage())
        
        dashboardVM.updateHome()
        XCTAssertEqual(dashboardVM.collections.count, 1)
        XCTAssertEqual(dashboardVM.collections[0].title, "Title")
        XCTAssertEqual(dashboardVM.collections[0].amount, 2000)
        
        
    }
    
    // SearchVM
    
    func testSearchVM(){
        let userService = UserServiceMock()
        let collectionService = CollectionServiceMock()
        
        let searchVM = SearchViewModel(userService: userService, collectionService: collectionService)
        let dashboardVM = DashboardViewModel(userService: userService, service: collectionService)
        let uploadCollVM = UploadCollectionViewModel(service: collectionService, uploader: ImageUploaderMock())
        uploadCollVM.uploadCollection(withTitle: "Title", withCaption: "Caption", withAmount: 2000, withImage: UIImage())
        dashboardVM.updateHome()
        
        searchVM.fetchUsers()
        XCTAssertEqual(searchVM.users.count, 1)
        XCTAssertEqual(searchVM.users[0].id, "1")
        
        searchVM.fetchCollections()
        XCTAssertEqual(searchVM.collections.count, 1)
        XCTAssertEqual(searchVM.collections[0].id, "cc1")
        
    }
    
    func testDashboardView() throws {
        let userService = UserServiceMock()
        let collectionService = CollectionServiceMock()
        let dashboardVM = DashboardViewModel(userService: userService, service: collectionService)
        
        let uploadCollVM = UploadCollectionViewModel(service: collectionService, uploader: ImageUploaderMock())
        uploadCollVM.uploadCollection(withTitle: "Title", withCaption: "Caption", withAmount: 2000, withImage: UIImage())
        
        dashboardVM.updateHome()
        let dashV = DashboardView(viewModel: dashboardVM, safeArea: EdgeInsets(), size: CGSize())
        let textView = try dashV.inspect().find(viewWithId: "home").text()
        let content = try textView.string()
        XCTAssertEqual(content, "Home")
        
    }
    
    func testProfileView() throws {
        let user = User(id:"1", username: "Kikko", fullname: "Full", profileImageUrl: "", email: "Mail@gmail.com")
        let authVM = AuthViewModel(service: UserServiceMock(), uploader: ImageUploaderMock())
        authVM.currentUser = user
        let profileV = ProfileView(user: user).environmentObject(authVM)
        
        let textView = try profileV.inspect().find(viewWithId: "username").text()
        let content = try textView.string()
        XCTAssertEqual(content, "Kikko")
    }
    
    func testEditProfileView() throws{
        let user = User(id:"1", username: "Kikko", fullname: "Full", profileImageUrl: "", email: "Mail@gmail.com")
        let authVM = AuthViewModel(service: UserServiceMock(), uploader: ImageUploaderMock())
        authVM.currentUser = user
        let editV = EditProfileView(user: user).environmentObject(authVM)
        
        let textView = try editV.inspect().find(text: "Kikko")
        let content = try textView.string()
        XCTAssertEqual(content, "Kikko")
    }
    
    func testLoginRegisterViews() throws{
        let user = User(id:"1", username: "Kikko", fullname: "Full", profileImageUrl: "", email: "Mail@gmail.com")
        let authVM = AuthViewModel(service: UserServiceMock(), uploader: ImageUploaderMock())
        authVM.currentUser = user
        let log = LoginView(test: false).environmentObject(authVM)
        
        let textView = try log.inspect().find(viewWithId: "titlelog").text()
        let content = try textView.string()
        XCTAssertEqual(content, "Login")
        
        let sign = RegistrationView(test: false).environmentObject(authVM)
        
        let textView2 = try sign.inspect().find(viewWithId: "title").text()
        let content2 = try textView2.string()
        XCTAssertEqual(content2, "Sign Up")
        
    }
    
    func testSearchView() throws {
        let searchV = SearchView()

        
        searchV.viewModel.users.append(User(id:"1", username: "Kikko", fullname: "Full", profileImageUrl: "", email: "Mail@gmail.com"))
        searchV.viewModel.collections.append(Collection(id : "cc1", title: "coll", caption: "Caption", amount: 20000, currentAmount: 0, favourites: 0, participants: 1, collectionImageUrl: "", timestamp: Timestamp(), uid: "2"))
        
        searchV.selectedFilter = .users
        let textView = try searchV.inspect().find(text: "Kikko")
        let content = try textView.string()
        XCTAssertEqual(content, "Kikko")
        let selectedFilter: FilterSearchViewModel = .collections
        searchV.selectedFilter = selectedFilter

    }
    
    func testUploadColl() throws {
        let uploadCV = UploadCollectionView().environmentObject(CollectionViewModel(collection: Collection(id : "cc1", title: "coll", caption: "Caption", amount: 20000, currentAmount: 0, favourites: 0, participants: 1, collectionImageUrl: "", timestamp: Timestamp(), uid: "2"), service: CollectionServiceMock()))
        let textView = try uploadCV.inspect().find(viewWithId: "photo").text()
        let content = try textView.string()
        XCTAssertEqual(content, "Add photo")
        let imupl = ImageUploaderView().environmentObject(AuthViewModel(service: UserServiceMock(), uploader: ImageUploaderMock()))
        let textView2 = try imupl.inspect().find(text: "select a photo")
        let content2 = try textView2.string()
        XCTAssertEqual(content2, "select a photo")
    }
    
    func testFavPaymView() throws {
        _ = MainView()
        let f = BookmarkView()
        f.viewModel.collections.append(Collection(id : "cc1", title: "coll", caption: "Caption", amount: 20000, currentAmount: 0, favourites: 0, participants: 1, collectionImageUrl: "", timestamp: Timestamp(), uid: "2"))
        
        let textView2 = try f.inspect().find(text: "coll")
        let content2 = try textView2.string()
        XCTAssertEqual(content2, "coll")
        
        let p = PaymentView(collection: Collection(id : "cc1", title: "coll", caption: "Caption", amount: 20000, currentAmount: 0, favourites: 0, participants: 1, collectionImageUrl: "", timestamp: Timestamp(), uid: "2"))
        let textView = try p.inspect().find(viewWithId: "amount").text()
        let content = try textView.string()
        XCTAssertEqual(content, "Donation amount")
    }
    
    func testMainCollectionView() throws {
        let c = Collection(id : "cc1", title: "coll", caption: "Caption", amount: 20000, currentAmount: 0, favourites: 0, participants: 1, collectionImageUrl: "", timestamp: Timestamp(), uid: "2")
        let mainCV = MainCollectionView(collection: c)
        
        let textView = try mainCV.inspect().find(viewWithId: "CollTitle").text()
        let content = try textView.string()
        XCTAssertEqual(content, "coll")
    }
    
    func testResentUserActivityView() throws {
        let payment = Payment(id:"p1", senderId: "1", destinationId: "2", collectionId: "cc1", total: 10, timestamp: Timestamp())
        let recentUAV = RecentUserActivityView(payment: payment, isPositive: true)
        
        let textView = try recentUAV.inspect().find(viewWithId: "amount").text()
        let content = try textView.string()
        XCTAssertEqual(content, "+ 10 €")
    }
    
    func testMainPageClickableTabBar() throws {
        let authVM = AuthViewModel(service: UserServiceMock(), uploader: ImageUploaderMock())
        let mainV = MainView().environmentObject(authVM)
        
        let click = try mainV.inspect().find(viewWithId: "tabbar")
        XCTAssertNotNil(click)
    }
    
    func testHomeHeaderWithCollection() throws {
        let userService = UserServiceMock()
        let collectionService = CollectionServiceMock()
        let uploadColl = UploadCollectionViewModel(service: collectionService, uploader: ImageUploaderMock())
        uploadColl.uploadCollection(withTitle: "Coll1", withCaption: "Capt1", withAmount: 2100, withImage: UIImage())
        uploadColl.uploadCollection(withTitle: "Coll2", withCaption: "Capt2", withAmount: 2100, withImage: UIImage())
        uploadColl.uploadCollection(withTitle: "Coll3", withCaption: "Capt3", withAmount: 2100, withImage: UIImage())
        uploadColl.uploadCollection(withTitle: "Coll4", withCaption: "Capt4", withAmount: 2100, withImage: UIImage())
        uploadColl.uploadCollection(withTitle: "Coll5", withCaption: "Capt5", withAmount: 2100, withImage: UIImage())
        uploadColl.uploadCollection(withTitle: "Coll6", withCaption: "Capt6", withAmount: 2100, withImage: UIImage())
        
        let dashboardVM = DashboardViewModel(userService: userService, service: collectionService)
        dashboardVM.updateHome()
        dashboardVM.collections = collectionService.collections
        let dashV = DashboardView(viewModel: dashboardVM, safeArea: EdgeInsets(), size: CGSize())
        let textView = try dashV.inspect().find(viewWithId: "home").text()
        let content = try textView.string()
        XCTAssertEqual(content, "Home")
        
        let scroll = try dashV.inspect().find(viewWithId: "scrollv")
        XCTAssertNotNil(scroll)
        let head = try dashV.inspect().find(viewWithId: "header")
        XCTAssertNotNil(head)
    }
    
    func testActivityCollView() throws {
        let payment = Payment(id:"p1", senderId: "1", destinationId: "2", collectionId: "cc1", total: 10, timestamp: Timestamp())
        let activityCV = ActivityCollectionView(payment: payment)
        
        let textView = try activityCV.inspect().find(viewWithId: "money").text()
        let content = try textView.string()
        XCTAssertEqual(content, "10 €")
        
    }
    
    func testEditCollView() throws {
        let c = Collection(id : "cc1", title: "CollecTitle", caption: "Caption", amount: 20000, currentAmount: 0, favourites: 0, participants: 1, collectionImageUrl: "", timestamp: Timestamp(), uid: "2")
        let editCV = EditCollectionView(collection: c)
        
        let textView = try editCV.inspect().find(viewWithId: "Title").text()
        let content = try textView.string()
        XCTAssertEqual(content, "Title")
    }
    
    func testCollectionRowView() throws {
        let c = Collection(id : "cc1", title: "CollecTitle", caption: "Caption", amount: 2000, currentAmount: 70, favourites: 0, participants: 1, collectionImageUrl: "", timestamp: Timestamp(), uid: "2")
        let collectionRowV = CollectionRowView(collection: c)
        
        let textView = try collectionRowV.inspect().find(viewWithId: "status").text()
        let content = try textView.string()
        XCTAssertEqual(content, "€70.00 of €2,000")
    }
    
    func testiPadLogin() throws {
        let authVM = AuthViewModel(service: UserServiceMock(), uploader: ImageUploaderMock())
        var ipadlog = LoginView(test: true).environmentObject(authVM)
        
        let textView = try ipadlog.inspect().find(viewWithId: "titlelogipad").text()
        let content = try textView.string()
        XCTAssertEqual(content, "Login")
    }
    
    func testiPadRegister() throws {
        let authVM = AuthViewModel(service: UserServiceMock(), uploader: ImageUploaderMock())
        let ipadregister = RegistrationView(test: true).environmentObject(authVM)
        
        let textView = try ipadregister.inspect().find(viewWithId: "titleipad").text()
        let content = try textView.string()
        XCTAssertEqual(content, "Sign Up")
    }
    
}
