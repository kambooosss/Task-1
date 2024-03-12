//
//  Task1UITests.swift
//  Task1UITests
//
//  Created by kamalesh-pt7513 on 09/03/24.
//

import XCTest
@testable import Task1
final class Task1UITests: XCTestCase,UiLoginVCtestDelegate {
    
    let mockUserData = MockUserData()
    
    let app = XCUIApplication()
    
    
    
    func logout() {
        DashBoardElement.profileButton.tap()
        DashBoardElement.logoutButton.tap()
    }
    func signup() {
        
        
        SignupElement.usernameTextField.tap()
        SignupElement.usernameTextField.typeText(MockUserData.username)
        sleep(2)
        SignupElement.passwordTextField.tap()
        SignupElement.passwordTextField.typeText(MockUserData.Password)
        sleep(2)
        SignupElement.age.tap()
        SignupElement.age.typeText(String(MockUserData.age))
        sleep(2)
        SignupElement.gender.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: MockUserData.gender)
        sleep(2)
        SignupElement.country.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue:  MockUserData.country)
        sleep(2)
        SignupElement.signupButton.tap()
        
        sleep(5)
        
        logout()
    }
    
    override func setUp() {
        
        app.launch()
        continueAfterFailure = true
        if(DashBoardElement.profileButton.exists)
        {
            logout()
        }
        

        
    }

    override func tearDown() {
        
//        MockUserData.Mockstate = .logedOut
    }

    func testLoginVC()
    {
        //wrong Password
        loginElement.usernameTextField.tap()
        loginElement.usernameTextField.typeText("Ttt")
        
        
        loginElement.passwordTextField.tap()
        loginElement.passwordTextField.typeText("wrong Password")
        
        loginElement.loginButton.tap()
        
        XCTAssertTrue(loginElement.alert.exists)
        
        //wrong username
        loginElement.usernameTextField.tap()
        loginElement.usernameTextField.typeText("TTT")
        
        loginElement.passwordTextField.tap()
        loginElement.passwordTextField.typeText("Kambuuussslok1!")
        loginElement.loginButton.tap()
        XCTAssertTrue(loginElement.alert.exists)
        //valid user
        loginElement.usernameTextField.tap()
        loginElement.usernameTextField.typeText(MockUserData.username)
        
        loginElement.passwordTextField.tap()
        loginElement.passwordTextField.typeText(MockUserData.Password)
        loginElement.loginButton.tap()
        
        XCTAssertTrue(loginElement.loadingIndicator.exists)
        
        sleep(10)
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
