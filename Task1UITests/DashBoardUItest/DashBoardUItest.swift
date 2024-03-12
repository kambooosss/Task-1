//
//  DashBoardVC.swift
//  Task1UITests
//
//  Created by kamalesh-pt7513 on 11/03/24.
//

import Foundation
import XCTest
@testable import Task1
final class DashBoardUITests: XCTestCase {
    let app = XCUIApplication()
    func login()
    {
        loginElement.usernameTextField.tap()
        loginElement.usernameTextField.typeText(MockUserData.username)
        
        loginElement.passwordTextField.tap()
        loginElement.passwordTextField.typeText(MockUserData.Password)
        loginElement.loginButton.tap()
        sleep(3)
    }
    override func setUp() {
        app.launch()
        continueAfterFailure = false
        if(!DashBoardElement.profileButton.exists)
        {
            login()
        }
        
        
    }
    func testDashBoard()
    {
        DashBoardElement.profileButton.tap()
        //check profile
        let name = "Name: \(MockUserData.username)"
        let age = "Age: \(MockUserData.age)"
        let country = "Country: \(MockUserData.country)"
        let Gender = "Gender: \(MockUserData.gender)"
        
        XCTAssertTrue(DashBoardElement.profileTV.cells.element(boundBy: 0).staticTexts.firstMatch.label == name)
        XCTAssertTrue(DashBoardElement.profileTV.cells.element(boundBy: 1).staticTexts.firstMatch.label == age)
        XCTAssertTrue(DashBoardElement.profileTV.cells.element(boundBy: 2).staticTexts.firstMatch.label == country)
        XCTAssertTrue(DashBoardElement.profileTV.cells.element(boundBy: 3).staticTexts.firstMatch.label == Gender)
        
        
        DashBoardElement.profileButton.tap()
        
        
                
        //change to table view
        if(DashBoardElement.doclistingCV.exists)
        {
            DashBoardElement.changeViewButton.tap()
        }
        //add 5 new docs
        for list in MockUserData.listing{
            
            
            let beforeCount = DashBoardElement.doclistingTV.cells.count
            DashBoardElement.newButton.tap()
            DashBoardElement.vcNameAlert.textFields.element.tap()
            DashBoardElement.vcNameAlert.textFields.element.typeText(list)
            
            DashBoardElement.okButton.tap()
            sleep(1)
            XCTAssertEqual(DashBoardElement.doclistingTV.cells.count,beforeCount + 1)
            XCTAssertTrue(DashBoardElement.doclistingTV.cells.element(boundBy: beforeCount).staticTexts.firstMatch.label == list)
            
            
        }
        DashBoardElement.changeViewButton.tap()
        //adding new docs in collection view
        for list in MockUserData.listing{
            
            let beforeCount = DashBoardElement.doclistingCV.cells.count
            DashBoardElement.newButton.tap()
            DashBoardElement.vcNameAlert.textFields.element.tap()
            DashBoardElement.vcNameAlert.textFields.element.typeText(list)
            
            DashBoardElement.okButton.tap()
            sleep(1)
            XCTAssertEqual(DashBoardElement.doclistingCV.cells.count,beforeCount + 1)
            XCTAssertTrue(DashBoardElement.doclistingCV.cells.element(boundBy: beforeCount).staticTexts.firstMatch.label == list)
            
        }
        //deleting from cv
        for i in 1...MockUserData.listing.count {
            let lastIndex = DashBoardElement.doclistingCV.cells.count - 1
            DashBoardElement.doclistingCV.cells.element(boundBy: lastIndex).tap()
            DashBoardElement.deleteButton.tap()
            sleep(1)
        }
        DashBoardElement.changeViewButton.tap()
        //dleting from tv
        for i in 1...MockUserData.listing.count {
            let lastIndex = DashBoardElement.doclistingTV.cells.count - 1
            DashBoardElement.doclistingTV.cells.element(boundBy: lastIndex).tap()
            DashBoardElement.deleteButton.tap()
            sleep(1)
        }
        
        
        
        //check cancel button
        //with typing
        DashBoardElement.newButton.tap()
        DashBoardElement.vcNameAlert.textFields.element.tap()
        DashBoardElement.vcNameAlert.textFields.element.typeText("dummy")
        DashBoardElement.cancelButton.tap()
        //with out typing
        DashBoardElement.newButton.tap()
        DashBoardElement.vcNameAlert.textFields.element.tap()
        DashBoardElement.cancelButton.tap()
        
        //chek new vc
        DashBoardElement.newButton.tap()
        DashBoardElement.vcNameAlert.textFields.element.tap()
        DashBoardElement.vcNameAlert.textFields.element.typeText("dummy")
        DashBoardElement.okButton.tap()
        
        DashBoardElement.doclistingTV.cells.element(boundBy: DashBoardElement.doclistingTV.cells.count - 1).tap()
        DashBoardElement.openButton.tap()
        sleep(1)
        
        NewVcElements.newVcTextLabel.press(forDuration: 2)
        NewVcElements.bold.tap()
        NewVcElements.newVcTextLabel.press(forDuration: 2)
        NewVcElements.italic.tap()
        NewVcElements.newVcTextLabel.press(forDuration: 2)
        NewVcElements.strike.tap()
        NewVcElements.newVcTextLabel.press(forDuration: 2)
        NewVcElements.underline.tap()
        sleep(1)
        
        
    }
    override func tearDown() {
        
    }
    
    
}

