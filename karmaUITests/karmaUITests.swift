//
//  karmaUITests.swift
//  karmaUITests
//
//  Created by Giovanni Demasi on 05/12/22.
//

import XCTest

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
    
    func testRegistratio() throws {
            // Application is launched
            let app = XCUIApplication()
            app.launch()
            
            app.buttons["Don't have an account ?, Sign Up"].tap()
            
            let fullnameTextField = app.textFields["Fullname"]
            XCTAssertTrue(fullnameTextField.exists)
            fullnameTextField.tap()
            fullnameTextField.typeText("UITest")
            
            let usernameTextField = app.textFields["Username"]
            XCTAssertTrue(usernameTextField.exists)
            usernameTextField.tap()
            usernameTextField.typeText("UITest")
            
            let emailTextField = app.textFields["Email"]
            XCTAssertTrue(emailTextField.exists)
            emailTextField.tap()
            emailTextField.typeText("uitest2@gmail.com")
            
            let passwordSecureTextField = app.secureTextFields["Password"]
            XCTAssertTrue(passwordSecureTextField.exists)
            passwordSecureTextField.tap()
            passwordSecureTextField.typeText("UITest2023!")
            passwordSecureTextField.typeText("\n")
            
            let signUpButton = app.buttons["Sign Up"]
            XCTAssertTrue(signUpButton.exists)
            signUpButton.tap()
            
//            to fix from here on, the button select a photo is not recognised
//            let selectPhotoButton = app.buttons["select a photo"]
//            XCTAssertTrue(selectPhotoButton.exists)
//            selectPhotoButton.tap()
//
//            app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.images["Foto, 30 marzo 2018, 9:14 PM"]/*[[".otherElements[\"Photos\"].scrollViews.otherElements",".otherElements[\"Foto, 30 marzo 2018, 9:14 PM, Foto, 08 agosto 2012, 11:55 PM, Foto, 08 agosto 2012, 11:29 PM, Foto, 08 agosto 2012, 8:52 PM, Foto, 09 ottobre 2009, 11:09 PM, Foto, 13 marzo 2011, 1:17 AM\"].images[\"Foto, 30 marzo 2018, 9:14 PM\"]",".images[\"Foto, 30 marzo 2018, 9:14 PM\"]",".scrollViews.otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
//
//            let continueButton = app.buttons["Continue"]
//            XCTAssertTrue(continueButton.exists)
//            continueButton.tap()
            
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
