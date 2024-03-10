//
//  Task1UITests.swift
//  Task1UITests
//
//  Created by kamalesh-pt7513 on 09/03/24.
//

import XCTest
@testable import Task1
final class Task1UITests: XCTestCase {
    let app = XCUIApplication()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        app.launch()
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    func testLoginVC()
    {
       
        
        let usernameTextField = app.textFields["userName"]
        XCTAssertTrue(usernameTextField.exists)
        
        let passwordTextField = app.secureTextFields["password"]
        XCTAssertTrue(passwordTextField.exists)
        
        let loginButton = app.buttons["signin"]
        XCTAssertTrue(loginButton.exists)
        
        let signupButton = app.buttons["signup"]
        XCTAssertTrue(signupButton.exists)
        
        let alert = app.alerts["Alert"]
        loginButton.tap()
        XCTAssertTrue(alert.exists)
        
        usernameTextField.tap()
        usernameTextField.typeText("Ttt")
        
        passwordTextField.tap()
        passwordTextField.typeText("Kambuuussslok1!")
        
        loginButton.tap()
        
        let loadingIndicator = app.activityIndicators["loading"]
        XCTAssertTrue(loadingIndicator.exists)
        
        let logOutButtonExistsExpectation = expectation(for: NSPredicate(format: "exists == true"), evaluatedWith: app.navigationBars.buttons["profile"], handler: nil)
        
        waitForExpectations(timeout: 10, handler: nil)
        
        app.navigationBars.buttons["profile"].tap()
        
        let logoutButton = app.buttons["logout"]
        XCTAssertTrue(logoutButton.exists)
        
        logoutButton.tap()
        
        XCTAssertTrue(signupButton.exists)
        
        signupButton.tap()
        
        let signupPageSignupButton = app.buttons["signupPageSignupButton"]
        XCTAssertTrue(signupPageSignupButton.exists)
        
        signupPageSignupButton.tap()
        
        let signupAlert = app.alerts["signupAlert"]
        XCTAssertTrue(signupAlert.exists)
        
        
        
        
        
        
        
        
        
        
        
        
        
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
