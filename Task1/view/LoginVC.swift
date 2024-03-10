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

    
    var outerStack: UIStackView = {
        let view = UIStackView()
        
//        view.backgroundColor = .blue
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 25
        view.accessibilityIdentifier = "outerStack"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var userName = CustomTextField()
    var password = CustomTextField()
    var age = CustomTextField()
    var gender = CustomTextField()
    var country = CustomTextField()
    
    
    
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
        print("view will aperar from lgoin vc")
        navigationController?.navigationBar.isHidden = true
        userName.text = nil
        password.text = nil
//    MARK: OLD STATE RESTORATION
        
        
//        if(UserDefaults.standard.string(forKey: "didLogOUT") == "no")
//        {
//            if let user = UserDefaults.standard.data(forKey: "state"){
//                do{
//                    let decodedInstance = try JSONDecoder().decode(User.self, from: user)
//                    
//                    showLoadingpage(user: decodedInstance)
//                    
//                    
//                }catch{
//                    print("can't decode state")
//                }
//            }
//            else{
//                print("Username doesnt exist")
//            }
//        }
        
        
        
//      MARK: NEW STATE RESTORATION
//        if let user = UserDefaults.standard.data(forKey: "LastUser"){
//            print("from login vc the last user is \(UserDefaults.standard.string(forKey: "LastUser"))")
//            do{
//                let decodedInstance = try JSONDecoder().decode(User.self, from: user)
//                print("from lgin vc user state is : \(decodedInstance.state)")
//                if(decodedInstance.state == .logedIN)
//                {
//                    showLoadingpage(user: decodedInstance)
//                }
//               
//            }catch{
//                print("can't decode state")
//            }
//        }
//        else{
//            print("Username doesnt exist")
//        }
        
        
        
    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//    }
    
    @objc func tapedSingIN()
    {
        presenter?.checkCredentials(username: userName.text, password: password.text)
    }
    @objc func tapedSingUP()
    {
//        presenter?.newUser(username: userName.text, password: password.text, age: Int(age.text ?? "0"), country: country.text, gender: gender.text)
        
        signupview.presenter = presenter
//        self.present(signupview, animated: true, completion: nil)
        navigationController?.pushViewController(signupview, animated: true)
//        self.dismiss(animated: true)
        
    }
    
    func configureTextField(){
        userName.placeholder = "userName"
        userName.accessibilityIdentifier = "userName"
        age.placeholder = "Age"
        gender.placeholder = "Gender"
        country.placeholder = "Country"
        password.placeholder = "Password"
        password.accessibilityIdentifier = "password"
        password.isSecureTextEntry = true
//        password.inputView = pickerView
        
    }
    func setupView()
    {
        view.addSubview(outerStack)
        view.addSubview(signUp)
        outerStack.addArrangedSubview(userName)
        outerStack.addArrangedSubview(password)
//        outerStack.addArrangedSubview(age)
//        outerStack.addArrangedSubview(gender)
//        outerStack.addArrangedSubview(country)
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
//                navigationController?.pushViewController(signupview, animated: true)
//                signupview.showLoadingpage(user: user)
//                navigationController?.pushViewController(dashboard, animated: true)
//                dashboard.setUserInstance(user: user)
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
                            self.navigationController?.pushViewController(dashboard, animated: true)
                            dashboard.setUserInstance(user: user)
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
        print("from login vc show waring")
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        alert.view.accessibilityIdentifier = "Alert"
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
}
