//
//  Mockpresenter.swift
//  Task1Tests
//
//  Created by kamalesh-pt7513 on 01/03/24.
//

import XCTest
@testable import Task1
class Mockpresenter: presenterDelegate {
    
    
    
    
    
    var expectation : XCTestExpectation!
    var newVc: Task1.newVcDelegate?
    
    func didFetchData(result: Result<[Task1.Names], Error>) {
        switch result{
        case .success(let names):
            XCTAssertNotNil(names)
            expectation.fulfill()
        case .failure(let error):
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
    }
    
    func fetchData() {
        
    }
    
    var view: Task1.viewDelegate?
    
    var interactor: Task1.interactorDelegate?
    
    var router: Task1.routerDelegate?
    
    var DashBoard: Task1.DashBoardDelegate?
    
    func setExpectation(expectation: XCTestExpectation)
    {
        self.expectation = expectation
    }
    
    func checkCredentials(username: String?, password: String?) {
        
    }
    
    func newUser(username: String?, password: String?, age: Int?, country: String?, gender: String?) {
        
    }
    
    
    func showLoadingPage(user: Task1.User) {
        self.expectation.fulfill()
    }
    
    func addDocList(user: Task1.User, text: String) {
        
    }
    func showWarning(message: String) {
        self.expectation.fulfill()
    }
    
    func signupViewWarning(message: String) {
        self.expectation.fulfill()
    }
}
