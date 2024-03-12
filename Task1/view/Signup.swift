
import Foundation
import UIKit

class SignupVC: UIViewController,viewDelegate {
    func showWarning(message: String) {
        
    }
    
    var presenter: presenterDelegate?
    let countryDropDown = UIPickerView()
    let genderDropDown = UIPickerView()
    let dashboard = DashBoardVC()

    let genders = ["Male","Female","Other"]
    let countries = [
        "United States",
        "Canada",
        "United Kingdom",
        "Germany",
        "France",
        "Italy",
        "Japan",
        "Australia",
        "Brazil",
        "China",
        "India",
        "Mexico",
        "Netherlands",
        "Russia",
        "South Africa",
        "Spain",
        "Switzerland",
        "Sweden",
        "Turkey",
        "United Arab Emirates"
    ]

    
    var loading : UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .large)
        loading.backgroundColor = .gray
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.accessibilityIdentifier = "loadingfromSignup"
        return loading
    }()
    var outerStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var userName = CustomTextField()
    var password = CustomTextField()
    var age = CustomTextField()
    var gender = CustomTextField()
    var country = CustomTextField()
    
    
    var signUp: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SignUP", for: .normal)
        button.backgroundColor = .systemCyan
        button.setTitleColor(.gray, for: .disabled)
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.setTitleColor(.black, for: .highlighted)
        button.layer.cornerRadius = 10
        button.accessibilityIdentifier = "signupPageSignupButton"
        button.addTarget(self, action: #selector(tapedSingUP), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear from signup view")
        navigationController?.navigationBar.isHidden = false
        userName.text = nil
        password.text = nil
        age.text = nil
        gender.text = nil
        country.text = nil
    }
    
    @objc func tapedSingUP()
    {
        
        presenter?.newUser(username: userName.text, password: password.text, age: Int(age.text ?? "0"), country: country.text, gender: gender.text)
        
    }
    @objc func textFieldDidChanged(_ sender: CustomTextField)
    {
        let name: Bool = userName.text?.count ?? 0 > 0
        let password: Bool = password.text?.count ?? 0 > 0
        let age: Bool = age.text?.count ?? 0 > 0
        let gender: Bool = gender.text?.count ?? 0 > 0
        let country: Bool = country.text?.count ?? 0 > 0
        
        signUp.isEnabled = (name && password && age && gender && country)
        
        
    }
    func showLoadingpage(user: User)
    {
        user.state = .logedIN
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
                self.navigationController?.pushViewController(
                    self.dashboard,
                    animated: true
                )
                self.dashboard.setUserInstance(user: user)
                
            }
            
        }
        
        
        
        
        
        
        
    }
    func configureTextField(){
        userName.placeholder = "userName"
        userName.accessibilityIdentifier = "usernameFromSignup"
        userName.addTarget(self, action: #selector( textFieldDidChanged(_:)),for: .editingChanged)
        
        age.placeholder = "Age"
        age.accessibilityIdentifier = "age"
        age.addTarget(self, action: #selector( textFieldDidChanged(_:)),for: .editingChanged)
        
        gender.placeholder = "Gender"
        gender.accessibilityIdentifier = "gender"
        gender.inputView = genderDropDown
        gender.addTarget(self, action: #selector( textFieldDidChanged(_:)),for: .allEditingEvents)
        
        country.placeholder = "Country"
        country.accessibilityIdentifier = "country"
        country.inputView = countryDropDown
        country.addTarget(self, action: #selector( textFieldDidChanged(_:)),for: .allEditingEvents)
        
        password.placeholder = "Password"
        password.accessibilityIdentifier = "passwordFromSignup"
        password.isSecureTextEntry = true
        password.textContentType = .oneTimeCode
        password.addTarget(self, action: #selector( textFieldDidChanged(_:)),for: .editingChanged)
        
        
        countryDropDown.dataSource = self
        countryDropDown.delegate = self
        countryDropDown.accessibilityIdentifier = "countryDropDown"
        
        genderDropDown.delegate = self
        genderDropDown.dataSource = self
        genderDropDown.accessibilityIdentifier = "genderDropDown"
        
    }
    func setupView()
    {
        view.backgroundColor = .black
        view.addSubview(outerStack)

        
        outerStack.addArrangedSubview(userName)
        outerStack.addArrangedSubview(password)
        outerStack.addArrangedSubview(age)
        outerStack.addArrangedSubview(gender)
        outerStack.addArrangedSubview(country)
        outerStack.addArrangedSubview(stackView)
        stackView.addArrangedSubview(signUp)
        
        NSLayoutConstraint.activate([
            
            outerStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            outerStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            outerStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            outerStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            
            ])
    }

    func signupViewWarning(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        alert.view.accessibilityIdentifier = "signupAlert"
        self.present(alert, animated: true, completion: nil)
    }
}

extension SignupVC: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerView == countryDropDown ? countries.count : genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView == countryDropDown ? countries[row] : genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == countryDropDown{
            country.text = countries[row]
            
        }else
        {
            gender.text = genders[row]
        }
        view.endEditing(true)
    }
    
    
}
