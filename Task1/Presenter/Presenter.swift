//
//  Presenter.swift
//  Task1
//
//  Created by kamalesh-pt7513 on 21/02/24.
//

import Foundation
import UIKit

class Presenter: presenterDelegate{
    
    
    var newVc: newVcDelegate?
    
   
    
    
    
    
    var DashBoard: DashBoardDelegate?
    
//    var signupview: signUpviewDelegate?
    
    var view: viewDelegate?
    
    var interactor: interactorDelegate?
    
    var router: routerDelegate?
    
    func addDocList(user: User, text: String) {
        print("add doc list form presenter")
        interactor?.addDocList(user: user, text: text)
        
        
    }
    func checkCredentials(username: String?, password: String?) {
        
        interactor?.verifyCredential(username: username, password: password)
        
    }
    
    func newUser(username: String?, password: String?, age: Int?, country: String?, gender: String?) {
//        print("entered new user")
//        print("interact is : \(interactor)")
        interactor?.creatUser(username: username, password: password, age: age, country: country, gender: gender)
    }
    
    
    func signupViewWarning(message: String) {
        view?.signupViewWarning(message: message)
    }
    
    func showLoadingPage(user: User) {
        view?.showLoadingpage(user: user)
    }
    
}
extension Presenter{
    func didFetchData(result: Result<[Names], Error>) {
        switch result{
        case.success(let names):
            newVc?.updateView(usernames: names)
        case.failure(let error):
            newVc?.showError(with: error)
        }
    }
    
    func fetchData() {
        interactor?.fetchData()
    }
}
extension Presenter{
    func showWarning(message: String) {
        print(view)
        view?.showWarning(message: message)
        print("show warning rading from presenter")
    }
}
