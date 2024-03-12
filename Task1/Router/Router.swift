
import Foundation
import UIKit

class Router: routerDelegate{
    
    static func startWithDash() -> UIViewController & DashBoardDelegate {
        let router: routerDelegate = Router()
        var presenter: presenterDelegate = Presenter()
        var interactor: interactorDelegate = Interacter()
        var view: DashBoardDelegate & UIViewController = DashBoardVC()
    
        presenter.interactor = interactor
        presenter.router = router
        presenter.DashBoard = view
        interactor.presenter = presenter
        view.presenter = presenter

        return view
    }
    
    static func start() -> UIViewController & viewDelegate {
        
        let router: routerDelegate = Router()
        
        var presenter: presenterDelegate = Presenter()
        var interactor: interactorDelegate = Interacter()
        var view: viewDelegate & UIViewController = LoginVC()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        interactor.presenter = presenter
        view.presenter = presenter

        return view
    }
    
    
}
