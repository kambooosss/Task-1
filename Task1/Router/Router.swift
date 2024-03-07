//
//  Router.swift
//  Task1
//
//  Created by kamalesh-pt7513 on 21/02/24.
//

import Foundation
import UIKit

class Router: routerDelegate{
    static func startWithDash() -> UIViewController & DashBoardDelegate {
        let router: routerDelegate = Router()
        
        var presenter: presenterDelegate = Presenter()
        var interactor: interactorDelegate = Interacter()
        var view: DashBoardDelegate & UIViewController = DashBoardVC()
        
//        var sigupview: viewDelegate & UIViewController = SignupVC()
        
//        print("from router sigupview is: \(sigupview)")
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.DashBoard = view
        interactor.presenter = presenter
        view.presenter = presenter
//        sigupview.presenter = presenter
//        print("from router sigupview.presenter is: \(sigupview.presenter)")
        return view
    }
    
    
    
    
    
    
    static func start() -> UIViewController & viewDelegate {
        let router: routerDelegate = Router()
        
        var presenter: presenterDelegate = Presenter()
        var interactor: interactorDelegate = Interacter()
        var view: viewDelegate & UIViewController = LoginVC()
        
//        var sigupview: viewDelegate & UIViewController = SignupVC()
        
//        print("from router sigupview is: \(sigupview)")
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        interactor.presenter = presenter
        view.presenter = presenter
//        sigupview.presenter = presenter
//        print("from router sigupview.presenter is: \(sigupview.presenter)")
        return view
    }
    
    
}
