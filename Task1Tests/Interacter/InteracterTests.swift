//
//  Task1Tests.swift
//  Task1Tests
//
//  Created by kamalesh-pt7513 on 01/03/24.
//

import XCTest
@testable import Task1
final class InteracterTests: XCTestCase {
    
    var sut : Interacter!
    var mockpresenter : Mockpresenter!
    var mockUser : User!
    var expectation: XCTestExpectation!
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = Interacter()
        mockpresenter = Mockpresenter()
        sut?.presenter = mockpresenter
        sut.presenter?.interactor = sut
        mockUser = User()
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockpresenter = nil
        mockUser = nil
        
    }
    
    func testVerifyCredential() {

        mockUser.username = "mockUser"
        mockUser.country = "mockcountry"
        mockUser.age = 12
        mockUser.gender = "male"
        mockUser.password = "Kambuuussslok1!"
        //valid user
        expectation = XCTestExpectation(description: "show login page for valid user")
        encodeData(user: mockUser)
        mockpresenter.setExpectation(expectation: expectation)
        sut?.verifyCredential(username: mockUser.username  , password: mockUser.password)
        wait(for: [expectation], timeout: 2)
        //wrong password
        mockUser.password = "mock wrong password"
        expectation = XCTestExpectation(description: "nil user name aleart must be shown")
        
        mockpresenter.setExpectation(expectation: expectation)
        sut?.verifyCredential(username: mockUser.username  , password: mockUser.password)
        wait(for: [expectation], timeout: 2)
        //wrong user name
        mockUser.username = "mock wrong username"
        mockUser.password = "Kambuuussslok1!"
        expectation = XCTestExpectation(description: "show wrong passwordd aleart")
        
        mockpresenter.setExpectation(expectation: expectation)
        sut?.verifyCredential(username: mockUser.username  , password: mockUser.password)
        wait(for: [expectation], timeout: 2)
        //username nil
        mockUser.username = nil
        mockUser.password = "Kambuuussslok1!"
        expectation = XCTestExpectation(description: "show wrong passwordd aleart")
        
        mockpresenter.setExpectation(expectation: expectation)
        sut?.verifyCredential(username: mockUser.username  , password: mockUser.password)
        wait(for: [expectation], timeout: 2)
        
        
        
    }
    func encodeData(user: User)
    {
        do{
            let encodedData = try JSONEncoder().encode(mockUser)
            UserDefaults.standard.set(encodedData,forKey: mockUser.username! )
            
        }catch{
            XCTFail("unable to encode mockUser in tsetVerifyCredential()")
        }
    }
    func testcreatUser()
    {   //valid new user
        let mockUserName = "mock user name"
        let mockPassword = "Kambuuussslok1!"
        let mockage = 12
        let mockGender = "male"
        let mockCountry = "india"
        
        expectation = XCTestExpectation(description: "show wrong passwordd aleart")
        mockpresenter.setExpectation(expectation: expectation)
        
        sut.creatUser(username: mockUserName, password: mockPassword, age: mockage, country: mockCountry, gender: mockGender)
        wait(for: [expectation], timeout: 2)
        //username empty
        expectation = XCTestExpectation(description: "show wrong passwordd aleart")
        mockpresenter.setExpectation(expectation: expectation)
        
        sut.creatUser(username: nil, password: mockPassword, age: mockage, country: mockCountry, gender: mockGender)
        wait(for: [expectation], timeout: 2)
        //uername already exist
        expectation = XCTestExpectation(description: "uername already exist")
        mockpresenter.setExpectation(expectation: expectation)
        
        sut.creatUser(username: mockUserName, password: mockPassword, age: mockage, country: mockCountry, gender: mockGender)
        wait(for: [expectation], timeout: 2)
        UserDefaults.standard.removeObject(forKey: mockUserName)
        //passwornd is weak
        expectation = XCTestExpectation(description: "weak password")
        mockpresenter.setExpectation(expectation: expectation)
        
        sut.creatUser(username: mockUserName, password: "weak password", age: mockage, country: mockCountry, gender: mockGender)
        wait(for: [expectation], timeout: 2)
        //empty age
        expectation = XCTestExpectation(description: "empty age")
        mockpresenter.setExpectation(expectation: expectation)
        
        sut.creatUser(username: mockUserName, password: mockPassword, age: nil, country: mockCountry, gender: mockGender)
        wait(for: [expectation], timeout: 2)
        //empty country
        expectation = XCTestExpectation(description: "empty country")
        mockpresenter.setExpectation(expectation: expectation)
        
        sut.creatUser(username: mockUserName, password: mockPassword, age: mockage, country: nil, gender: mockGender)
        wait(for: [expectation], timeout: 2)
        //empty gender
        expectation = XCTestExpectation(description: "empty gender")
        mockpresenter.setExpectation(expectation: expectation)
        
        sut.creatUser(username: mockUserName, password: mockPassword, age: mockage, country: mockCountry, gender: nil)
        wait(for: [expectation], timeout: 2)
        
    }
    func testAddDoclist(){
        mockUser.username = "mockUser"
        mockUser.country = "mockcountry"
        mockUser.age = 12
        mockUser.gender = "male"
        mockUser.password = "Kambuuussslok1!"
        mockUser.state = .logedIN
        
        encodeData(user: mockUser)
        
        let beforeCount = mockUser.listing.count
        sut.addDocList(user: mockUser, text: "Mock Doc")
        let afterCount = mockUser.listing.count
        XCTAssertEqual(beforeCount+1, afterCount)
    }
    func testFetchData()
    {
        expectation = XCTestExpectation(description: "fetched data successfully")
        mockpresenter.setExpectation(expectation: expectation)
        sut.fetchData()
        wait(for: [expectation], timeout: 10)
        
        sut.url = URL(string: "mock failure url")
        expectation = XCTestExpectation(description: "api doesnt work")
        mockpresenter.setExpectation(expectation: expectation)
        sut.fetchData()
        
        wait(for: [expectation], timeout: 10)
        
        expectation = XCTestExpectation(description: "Should fail becouaes url is nil")
        mockpresenter.setExpectation(expectation: expectation)
        sut.url = URL(string: "")
        sut.fetchData()
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        if result == .completed {
            XCTFail("this expectation should fail but fullfilled")
        }
        
        
    }
}

