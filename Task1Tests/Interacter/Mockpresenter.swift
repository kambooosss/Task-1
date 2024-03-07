//
//  Mockpresenter.swift
//  Task1Tests
//
//  Created by kamalesh-pt7513 on 01/03/24.
//

import XCTest
@testable import Task1
class Mockpresenter: presenterDelegate {
    var view: Task1.viewDelegate?
    
    var interactor: Task1.interactorDelegate?
    
    var router: Task1.routerDelegate?
    
    var DashBoard: Task1.DashBoardDelegate?
    
    var showLoadingPaginCalled = false
    var addDoclistCalled = false
    var weakPasswordCalled = false
    
    func checkCredentials(username: String?, password: String?) {
        
    }
    
    func newUser(username: String?, password: String?, age: Int?, country: String?, gender: String?) {
        
    }
    
    func weakPassword() {
        weakPasswordCalled = true
    }
    
    func showLoadingPage(user: Task1.User) {
        showLoadingPaginCalled = true
    }
    
    func addDocList(user: Task1.User, text: String) {
        addDoclistCalled = true
    }
    
    
}
