//
//  File.swift
//  Task1UITests
//
//  Created by kamalesh-pt7513 on 11/03/24.
//

import Foundation
import XCTest
@testable import Task1
struct MockUserData{
    
    static let username = "MockUser"
    static let Password = "Kambuuussslok1!"
    static let age = 12
    static let gender = "Female"
    static let country = "India"
    static let listing = ["Mocklist1","Mocklist2","Mocklist3"]
//    static var mockstate : MockState = .logedOut
}
//enum MockState{
//    
//    case logedIn
//    case logedOut
//    case new
//}
struct loginElement{
    
    static let app = XCUIApplication()
    
    static let usernameTextField = app.textFields["userName"]
    static let passwordTextField = app.secureTextFields["password"]
    static let loginButton = app.buttons["signin"]
    static let signupButton = app.buttons["signup"]
    static let alert = app.alerts["Alert"]
    static let loadingIndicator = app.activityIndicators["loading"]
}
struct SignupElement{
    
    static let app = XCUIApplication()
    
    static let usernameTextField = app.textFields["usernameFromSignup"]
    static let age = app.textFields["Age"]
    static let gender = app.textFields["gender"]
    static let country = app.textFields["country"]
    static let passwordTextField = app.secureTextFields["passwordFromSignup"]
    static let signupButton = app.buttons["signupPageSignupButton"]
    static let loadingIndicator = app.activityIndicators["loadingfromSignup"]
    static let alert = app.alerts["singupAlert"]
    
}



struct DashBoardElement{
    
    static let app = XCUIApplication()
    static let logoutButton = app.buttons["logout"]
    static let profileButton = app.navigationBars.buttons["profile"]
    static let profileTV = app.tables["profileTV"]
    static let doclistingCV = app.collectionViews["doclistingCV"]
    static let doclistingTV = app.tables["doclistingTV"]
    static let newButton = app.buttons["NewButton"]
    static let changeViewButton = app.buttons["changeViewButton"]
    static let vcNameAlert = app.alerts["vcNameAlert"]
    static let okButton = app.alerts.buttons["alertOkButton"]
    static let cancelButton = app.alerts.buttons["alertCancelButton"]
    static let openAlert = app.alerts["openAlert"]
    static let openButton = app.alerts.buttons["openButton"]
    static let deleteButton = app.alerts.buttons["deleButton"]
}
struct NewVcElements{
    static let app = XCUIApplication()
    static let newVcTextLabel = app.staticTexts["NewVctextLabel"]
    static let bold = app.buttons["bold"]
    static let italic = app.buttons["italic"]
    static let strike = app.buttons["strike"]
    static let underline = app.buttons["underline"]
    
}
protocol UiDashBoardtestDelegate{
    func login(username: String,password: String)
    func signup(username: String,password: String)
}
protocol UiLoginVCtestDelegate{
    func logout()
    func signup()
}


