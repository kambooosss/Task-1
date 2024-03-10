//
//  Protocols.swift
//  Task1
//
//  Created by kamalesh-pt7513 on 21/02/24.
//

import Foundation
import UIKit

protocol viewDelegate{
    var presenter: presenterDelegate? {get set}
    func signupViewWarning(message: String)
    func showLoadingpage(user: User)
    func showWarning(message: String)
    
}

protocol DashBoardDelegate{
    var presenter:presenterDelegate? {get set}
    func ShowListing()
    func setUserInstance(user: User)
}
//protocol signUpviewDelegate{
//    var presenter: presenterDelegate? {get set}
//}
protocol presenterDelegate{
    var view: viewDelegate? {get set}
//    var signupview: signUpviewDelegate? {get set}
    var interactor: interactorDelegate? {get set}
    var router: routerDelegate? {get set}
    var DashBoard: DashBoardDelegate? {get set}
    
    var newVc: newVcDelegate? {get set}
    
    func checkCredentials(username: String?,password: String?)
    func newUser(username: String?, password: String?, age: Int?, country: String?, gender: String?)
    func signupViewWarning(message: String)
    func showLoadingPage(user: User)
    
    
    func addDocList(user: User, text: String)
    
    func didFetchData(result: Result<[Names],Error>)
    func fetchData()
    
    func showWarning(message: String)
    
}

protocol interactorDelegate{
    var presenter: presenterDelegate? {get set}
    
    
    func verifyCredential(username: String?,password: String?)
    func creatUser(username: String?, password: String?, age: Int?, country: String?, gender: String?)
    
    func addDocList(user: User,text: String)
    
    func fetchData()
}
protocol routerDelegate{
    static func start() -> viewDelegate & UIViewController
    static func startWithDash() -> DashBoardDelegate & UIViewController
}
protocol newVcDelegate{
    var presenter: presenterDelegate? {get set}
    
    func updateView(usernames: [Names])
    func showError(with error: Error)
    
}

