//
//  PresenterTest.swift
//  Task1Tests
//
//  Created by kamalesh-pt7513 on 04/03/24.
//

import XCTest
@testable import Task1
final class PresenterTest: XCTestCase {
    
    
    var sut : Presenter!
    var mockInteracter: MockInteracter!
    var mockView: MockView!
    
    
    override func setUp(){
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = Presenter()
        mockView = MockView()
        mockInteracter = MockInteracter()
        sut.view = mockView
        sut.interactor = mockInteracter
        
        
    }

    override func tearDown(){
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockView = nil
        mockInteracter = nil
    }

    func testAddDocList(){
        sut.addDocList(user: User(), text: "MockText")
        XCTAssertTrue(mockInteracter.addDocListCalled, "add doclist not called after give valid input")
    }
    
    
    func testValidCheckCredentials()
    {
        sut.checkCredentials(username: "mockuserName", password: "mockPasword")
        XCTAssertTrue(mockInteracter.verifyCredentialCalled,"flow from present to interacteros Check credential stoped ")
    }
    func testNilUsernameCheckCredentials()
    {
        sut.checkCredentials(username: nil, password: "mockPasword")
        XCTAssertTrue(mockInteracter.verifyCredentialCalled,"flow from present to interacteros Check credential stoped ")
    }
    func testNilPasswordCheckCredentials()
    {
        sut.checkCredentials(username: "mockuserName", password: nil)
        XCTAssertTrue(mockInteracter.verifyCredentialCalled,"flow from present to interacteros Check credential stoped ")
    }
    
    
    func testValidNewUser(){
        sut.newUser(username: "mockUser", password: "MockPassword", age: 12, country: "MockCountry", gender: "Male")
        XCTAssertTrue(mockInteracter.creatUserCalled, "creat user not called for valid user details")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
