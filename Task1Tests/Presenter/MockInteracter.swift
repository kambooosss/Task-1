//
//  MockInteracter.swift
//  Task1Tests
//
//  Created by kamalesh-pt7513 on 04/03/24.
//

import Foundation
@testable import Task1

class MockInteracter: interactorDelegate{
    var presenter: Task1.presenterDelegate?
    
    var addDocListCalled = false
    var verifyCredentialCalled = false
    var creatUserCalled = false
    
    func verifyCredential(username: String?, password: String?) {
        verifyCredentialCalled = true
    }
    
    func creatUser(username: String?, password: String?, age: Int?, country: String?, gender: String?) {
        creatUserCalled = true
    }
    
    func addDocList(user: Task1.User, text: String) {
        addDocListCalled = true
    }
    
    
}
