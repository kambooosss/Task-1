//
//  LoginVC.swift
//  Task1
//
//  Created by kamalesh-pt7513 on 21/02/24.
//


import Foundation
import UIKit

class LoginVC: UIViewController, viewDelegate {
    
    var presenter: presenterDelegate?
    let signupview = SignupVC()
    var dashboard : (DashBoardDelegate & UIViewController)?

    var userName = CustomTextField()
    var password = CustomTextField()
    
    var outerStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 25
        view.accessibilityIdentifier = "outerStack"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var signIn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SignIN", for: .normal)
        button.backgroundColor = .systemCyan
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.setTitleColor(.black, for: .highlighted)
        button.layer.cornerRadius = 10
        button.accessibilityIdentifier = "signin"
        button.addTarget(self, action: #selector(tapedSingIN), for: .touchUpInside)
//        button.isEnabled = false
        return button
    }()
    
    var loading : UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .large)
        loading.backgroundColor = .gray
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.accessibilityIdentifier = "loading"
        return loading
    }()
    
    var signUp: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SignUP", for: .normal)
        button.backgroundColor = .systemCyan
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.setTitleColor(.black, for: .highlighted)
        button.layer.cornerRadius = 10
        button.accessibilityIdentifier = "signup"
        button.addTarget(self, action: #selector(tapedSingUP), for: .touchUpInside)
        return button
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.accessibilityIdentifier = "stackView"
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureTextField()
        signupview.dashboard.presenter = presenter
        view.backgroundColor = .black
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        userName.text = nil
        password.text = nil

    }
    @objc func tapedSingIN()
    {
        
        presenter?.checkCredentials(username: userName.text, password: password.text)
        userName.text = nil
        password.text = nil
    }
    @objc func tapedSingUP()
    {
        signupview.presenter = presenter
//        signupview.presenter?.view = signupview
        navigationController?.pushViewController(signupview, animated: true)
    }
    @objc func textFieldDidChanged(_ sender: CustomTextField)
    {
        signIn.isEnabled = ( (userName.text?.count ?? 0) > 0 ) && ((password.text?.count ?? 0) > 0)
    }
    func configureTextField(){
        userName.placeholder = "userName"
        userName.accessibilityIdentifier = "userName"
//        userName.addTarget(self, action: #selector( textFieldDidChanged(_:)),for: .editingChanged)
        
        password.placeholder = "Password"
        password.accessibilityIdentifier = "password"
        password.isSecureTextEntry = true
//        password.addTarget(self, action: #selector( textFieldDidChanged(_:)),for: .editingChanged)
    }
    func setupView()
    {
        view.addSubview(outerStack)
        view.addSubview(signUp)
        
        outerStack.addArrangedSubview(userName)
        outerStack.addArrangedSubview(password)
        outerStack.addArrangedSubview(stackView)
        
        stackView.addArrangedSubview(signIn)
        stackView.addArrangedSubview(signUp)
        
        NSLayoutConstraint.activate([
            
            outerStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            outerStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            outerStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            outerStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            ])
    }
    func signupViewWarning(message: String) {
        signupview.signupViewWarning(message: message)
    }
    func showLoadingpage(user: User) {
        
        user.state = .logedIN
        
        if let top = navigationController?.topViewController{
            if top is LoginVC {
                
                view.addSubview(loading)
                
                NSLayoutConstraint.activate([
                    loading.topAnchor.constraint(equalTo: view.topAnchor),
                    loading.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                    loading.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    loading.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
                
                loading.startAnimating()
                loading.center = view.center
                
                DispatchQueue.global().async {
                    
                    sleep(2)
                    
                    Task {
                        
                        self.loading.stopAnimating()
                        self.loading.removeFromSuperview()
                        self.dashboard = Router.startWithDash()
                        if let dashboard = self.dashboard {
                            dashboard.setUserInstance(user: user)
                            self.navigationController?.pushViewController(dashboard, animated: true)
                            
                        }
                    }
                }
            }
            else
            {
                signupview.showLoadingpage(user: user)
            }
        }
    }
    func showWarning(message: String) {
        
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        alert.view.accessibilityIdentifier = "Alert"
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
