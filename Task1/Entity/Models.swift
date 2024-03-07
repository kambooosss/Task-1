//
//  Models.swift
//  Task1
//
//  Created by kamalesh-pt7513 on 21/02/24.
//

import Foundation
import UIKit

class User : Codable{
    
    var username: String?
    var country: String?
    var age: Int?
    var gender: String?
    var password: String?
    var state: State?
    var doclist: DocList = .table
//    var data: Data?
    var listing: [String] = []
    
    init(){
        
    }
    
    init(username: String, country: String, age: Int, gender: String, password: String) {
        self.username = username
        self.country = country
        self.age = age
        self.gender = gender
        self.password = password
    }
}
enum State: Codable {
    case logedIN
    case logedOUT
}
enum DocList: Codable {
    case table
    case collectioin
}
enum LabelState: Codable {
    case bold
    case italic
    case bolditalic
    case none
}
struct Names: Codable{
    var name: String
}

