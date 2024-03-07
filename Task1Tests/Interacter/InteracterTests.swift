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
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = Interacter()
        mockpresenter = Mockpresenter()
        sut?.presenter = mockpresenter
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockpresenter = nil
    }
    
    func testValidUserVerifyCredential() {
        let mockUser = User(username: "mockUser", country: "mockCountry", age: 34, gender: "male", password: "Kambuuussslok1!")
        
        do{
            let encodedData = try JSONEncoder().encode(mockUser)
            UserDefaults.standard.set(encodedData,forKey: mockUser.username! )
            
        }catch{
            XCTFail("unable to encode mockUser in tsetValidUserVerifyCredential()")
        }
        
        sut?.verifyCredential(username: mockUser.username  , password: mockUser.password)
        UserDefaults.standard.removeObject(forKey: mockUser.username!)
        XCTAssertTrue(mockpresenter.showLoadingPaginCalled , "Show loading paging not called")
        
        
        
        
    }
    func testInvalidUserVerifyCredential (){
        let mockUser = User()
        
        sut?.verifyCredential(username: mockUser.username, password: mockUser.password)
        
        XCTAssertFalse(mockpresenter.showLoadingPaginCalled , "show loaidng page in called but username is nil")
    }
    
    func testValidCreatUser()
    {
        sut.creatUser(username: "Mockusername", password: "Kambuuussslok1!", age: 23, country: "mockCountry", gender: "male")
        
        XCTAssertTrue(mockpresenter.showLoadingPaginCalled, "show loading page not called after signup ")
        
        UserDefaults.standard.removeObject(forKey: "Mockusername")
        
        
    }
    func testRedundantUserCreatUser()
    {
        let mockUser = User(username: "mockUser", country: "mockCountry", age: 34, gender: "male", password: "Kambuuussslok1!")
        
        do{
            let encodedData = try JSONEncoder().encode(mockUser)
            UserDefaults.standard.set(encodedData,forKey: mockUser.username! )
            
        }catch{
            XCTFail("unable to encode mockUser in tsetRedundantUserCreatUser")
        }
        XCTAssertTrue(sut.CheckRedundancy(username: "mockUser"))

        sut.creatUser(username: "mockUser", password: "Kambuuussslok1!", age: 34, country: "mockCountry", gender: "male")
        
        XCTAssertFalse(mockpresenter.showLoadingPaginCalled,"user already exist but creating user new user happened")
        UserDefaults.standard.removeObject(forKey: "mockUser")
    }
    
    func testUsernameNilCreatUser(){
        sut.creatUser(username: nil, password: nil, age: nil, country: nil, gender: nil)
        XCTAssertFalse(mockpresenter.showLoadingPaginCalled, "user name is nil but show laoding page called")
    }
    
    func testNilPasswordCreatUser(){
        sut.creatUser(username: "mockUsername", password: nil, age: 12, country: "MockCountry", gender: "male")
        XCTAssertTrue(mockpresenter.weakPasswordCalled, "password is nil but weakPasswrod not called")
    }
    
    func testShortPasswordCreatUser(){
        sut.creatUser(username: "mockUsername", password: "k1!K", age: 12, country: "MockCountry", gender: "male")
        XCTAssertTrue(mockpresenter.weakPasswordCalled, "password is short but weakPasswrod not called")
    }
    
//    func testNoNumericPasswordCreatUser(){
//        sut.creatUser(username: "mockUsername", password: "Kambuuussslok!", age: 12, country: "MockCountry", gender: "male")
//        XCTAssertTrue(mockpresenter.weakPasswordCalled, "password does not conatian any numberic value but no call made to weakPasswrod ")
//    }
    
    func testNoSpecialCharacterPasswordCreatUser(){
        sut.creatUser(username: "mockUsername", password: "Kambuuussslok1", age: 12, country: "MockCountry", gender: "male")
        XCTAssertTrue(mockpresenter.weakPasswordCalled, "password does not conatin any special character but no call made to weakPasswrod")
    }
    
    func testNoCapitalPasswordCreatUser(){
        sut.creatUser(username: "mockUsername", password: "kambuuussslok1!", age: 12, country: "MockCountry", gender: "male")
        XCTAssertTrue(mockpresenter.weakPasswordCalled, "password does not conatin any Capital letter but no call made to weakPasswrod")
    }
    
    
    

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}

