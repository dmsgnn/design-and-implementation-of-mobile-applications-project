//
//  karmaUITests.swift
//  karmaUITests
//
//  Created by Giovanni Demasi on 05/12/22.
//

import XCTest
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseMessaging

final class karmaUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testRegistration() throws {
        // Application is launched
        let app = XCUIApplication()
        app.launch()
        
        // MARK: Registration
        app.buttons["Don't have an account ?, Sign Up"].tap()
        sleep(1)
        
        let fullnameTextField = app.textFields["fullname"]
        XCTAssertTrue(fullnameTextField.exists)
        fullnameTextField.tap()
        fullnameTextField.typeText("UITest")
        
        let usernameTextField = app.textFields["username"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText("UITest")
        
        let emailTextField = app.textFields["email"]
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText("maill@gmail.com")
        
        let passwordSecureTextField = app.secureTextFields["password"]
        XCTAssertTrue(passwordSecureTextField.exists)
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("UITest2023!")
        passwordSecureTextField.typeText("\n")
        
        let signUpButton = app.buttons["Sign Up"]
        XCTAssertTrue(signUpButton.exists)
        signUpButton.tap()
        sleep(1)
        
        let selectPhotoButton = app.buttons["uploadProfileImage"]
        XCTAssertTrue(selectPhotoButton.exists)
        selectPhotoButton.tap()
        
        app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.images["Foto, 30 marzo 2018, 9:14 PM"]/*[[".otherElements[\"Photos\"].scrollViews.otherElements",".otherElements[\"Foto, 30 marzo 2018, 9:14 PM, Foto, 08 agosto 2012, 11:55 PM, Foto, 08 agosto 2012, 11:29 PM, Foto, 08 agosto 2012, 8:52 PM, Foto, 09 ottobre 2009, 11:09 PM, Foto, 13 marzo 2011, 1:17 AM\"].images[\"Foto, 30 marzo 2018, 9:14 PM\"]",".images[\"Foto, 30 marzo 2018, 9:14 PM\"]",".scrollViews.otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        sleep(1)
        
        let continueButton = app.buttons["continueAfterImageUpload"]
        XCTAssertTrue(continueButton.exists)
        continueButton.tap()
        sleep(1)
        
        // MARK: Edit user info
        let profileButton = app.images["person"]
        XCTAssertTrue(profileButton.exists)
        profileButton.tap()
        sleep(1)
        
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]/*@START_MENU_TOKEN@*/.buttons["Add"]/*[[".otherElements[\"Add\"].buttons[\"Add\"]",".buttons[\"Add\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Edit profile"]/*[[".cells.buttons[\"Edit profile\"]",".buttons[\"Edit profile\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(1)
        
        let editNameTextField = app.textFields["editName"]
        XCTAssertTrue(editNameTextField.exists)
        editNameTextField.tap()
        editNameTextField.typeText("NewName")
        
        let editUsernameTextField = app.textFields["editUsername"]
        XCTAssertTrue(editUsernameTextField.exists)
        editUsernameTextField.tap()
        editUsernameTextField.typeText("NewName")
        editUsernameTextField.typeText("\n")
        
        let doneButton = app.buttons["editDone"]
        XCTAssertTrue(doneButton.exists)
        doneButton.tap()
        sleep(2)
        
//        // MARK: New collection
//        let addNewCollectionButton = app.buttons["addNewCollection"]
//        XCTAssertTrue(addNewCollectionButton.exists)
//        addNewCollectionButton.tap()
//        sleep(1)
//
//        let uploadCollectionPhotoButton = app.buttons["collectionImageUpload"]
//        XCTAssertTrue(uploadCollectionPhotoButton.exists)
//        uploadCollectionPhotoButton.tap()
//
//        app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.images["Foto, 30 marzo 2018, 9:14 PM"]/*[[".otherElements[\"Photos\"].scrollViews.otherElements",".otherElements[\"Foto, 30 marzo 2018, 9:14 PM, Foto, 08 agosto 2012, 11:55 PM, Foto, 08 agosto 2012, 11:29 PM, Foto, 08 agosto 2012, 8:52 PM, Foto, 09 ottobre 2009, 11:09 PM, Foto, 13 marzo 2011, 1:17 AM\"].images[\"Foto, 30 marzo 2018, 9:14 PM\"]",".images[\"Foto, 30 marzo 2018, 9:14 PM\"]",".scrollViews.otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
//        sleep(1)
//
//        let collectionTitleTextField = app.textFields["collectionTitleField"]
//        XCTAssertTrue(collectionTitleTextField.exists)
//        collectionTitleTextField.tap()
//        collectionTitleTextField.typeText("New collection")
//
//        let collectionDescriptionTextField = app.textFields["collectionDescriptionField"]
//        XCTAssertTrue(collectionDescriptionTextField.exists)
//        collectionDescriptionTextField.tap()
//        collectionDescriptionTextField.typeText("Collection description")
//        collectionDescriptionTextField.typeText("\n")
//
//
//        let picker = app.pickers["picker"].pickerWheels.firstMatch
//        XCTAssertTrue(picker.exists)
//        picker.adjust(toPickerWheelValue: "1")
//
//        let shareCollectionButton = app.images["shareCollection"]
//        XCTAssertTrue(shareCollectionButton.exists)
//        shareCollectionButton.tap()
//        sleep(1)
        
        // MARK: Home and open collections
        let homeButton = app.images["house"]
        XCTAssertTrue(homeButton.exists)
        homeButton.tap()
        sleep(1)
        
        // MARK: Search
        let searchButton = app.images["magnifyingglass"]
        XCTAssertTrue(searchButton.exists)
        searchButton.tap()
        sleep(1)
        
        let favouritesButton = app.images["bookmark"]
        XCTAssertTrue(favouritesButton.exists)
        favouritesButton.tap()
        sleep(1)
        
        // MARK: Sign out
        profileButton.tap()
        sleep(1)
        
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]/*@START_MENU_TOKEN@*/.buttons["Add"]/*[[".otherElements[\"Add\"].buttons[\"Add\"]",".buttons[\"Add\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.collectionViews.buttons["Sign out"].tap()
        sleep(1)
        
        // MARK: Login
        let emailLoginTextField = app.textFields["email"]
        XCTAssertTrue(emailLoginTextField.exists)
        emailLoginTextField.tap()
        emailLoginTextField.typeText("maill@gmail.com")
        emailLoginTextField.typeText("\n")
        
        let passwordLoginTextField = app.secureTextFields["password"]
        XCTAssertTrue(passwordLoginTextField.exists)
        passwordLoginTextField.tap()
        passwordLoginTextField.typeText("UITest2023!")
        passwordLoginTextField.typeText("\n")
        
        let loginButton = app.buttons["Login"]
        XCTAssertTrue(loginButton.exists)
        loginButton.tap()
        sleep(5)

        // MARK: Sign out
//        profileButton.tap()
//        sleep(1)
//
//        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]/*@START_MENU_TOKEN@*/.buttons["Add"]/*[[".otherElements[\"Add\"].buttons[\"Add\"]",".buttons[\"Add\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.collectionViews.buttons["Sign out"].tap()
//        sleep(1)
        
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
