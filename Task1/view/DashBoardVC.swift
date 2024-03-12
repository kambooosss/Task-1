
import Foundation
import UIKit

class DashBoardVC: UIViewController,DashBoardDelegate {
    
    lazy var user = User()
    lazy var details : [String] = []
    var presenter: presenterDelegate?
    var vcName: UIAlertController?
    
    let layout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }()
    
    var DoclistingCV: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray3
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell" )
        collectionView.accessibilityIdentifier = "doclistingCV"
        return collectionView
    }()
    
    let docListingTV : UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 44
        tableView.separatorColor = .black
        tableView.backgroundColor = .systemGray3
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "doclist")
        tableView.accessibilityIdentifier = "doclistingTV"
        return tableView
    }()
    
    let newButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 40
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.layer.borderWidth = 6
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(newTapped), for: .touchUpInside)
        button.backgroundColor = .systemGray3
        button.accessibilityIdentifier = "NewButton"
        return button
    }()
    let changeViewButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 40
        button.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        button.layer.borderWidth = 6
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(changeViewTapped), for: .touchUpInside)
        button.backgroundColor = .systemGray3
        button.accessibilityIdentifier = "changeViewButton"
        return button
    }()
    
    let buttonView: UIStackView = {
        let buttonView = UIStackView()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.distribution = .fillEqually
        buttonView.spacing = 50
        buttonView.backgroundColor = .systemGray3
        return buttonView
    }()
    
    lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("LogOut", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(Logout), for: .touchUpInside)
        button.backgroundColor = .gray
        button.accessibilityIdentifier = "logout"
        button.sizeToFit()
        return button
    }()
    
    lazy var profile : UIView = {
        let profile = UIView()
        profile.backgroundColor = .gray
        profile.translatesAutoresizingMaskIntoConstraints = false
        profile.isHidden = true
        return profile
    }()
    
    lazy var profileTV: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .black
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.clipsToBounds = true
        tableView.estimatedRowHeight = 30
        tableView.tableFooterView = logOutButton
        tableView.accessibilityIdentifier = "profileTV"
        return tableView
    }()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        title = "Login App"
        view.backgroundColor = .systemGray3
        setupNavigation()
        setupNewButton()
        setupDoclisting()
        
        configureCollectionView()
        
        profileTV.delegate = self
        profileTV.dataSource = self
        
        docListingTV.delegate = self
        docListingTV.dataSource = self
        
        DoclistingCV.dataSource = self
        DoclistingCV.delegate  = self
        
        /*if dash is the first viewcontroller in nvigation stack set user instance else
        setting up user instance will be taken care by loginvc*/
        if (navigationController?.viewControllers.first is DashBoardVC)
        {
            if let user = UserDefaults.standard.data(forKey: "LastUser"){
                do{
                    let decodedInstance = try JSONDecoder().decode(User.self, from:user)
                    setUserInstance(user: decodedInstance)
                }catch{
                    print("bro...")
                }
            }
            
        }
        
    }
    
    func configureCollectionView()
    {
        view.addSubview(DoclistingCV)
        
        NSLayoutConstraint.activate([
            DoclistingCV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            DoclistingCV.bottomAnchor.constraint(equalTo: buttonView.topAnchor),
            DoclistingCV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            DoclistingCV.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    
    }    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setUserInstance(user: User)
    {
        self.user = user
        details = extractDetails(user: user)
    }
    
    func extractDetails(user: User) -> [String]
    {

        var name = ""
        if let username = user.username {
            name = "Name: \(username)"
        }

        var age = ""
        if let userAge = user.age {
            age = "Age: \(userAge)"
        }

        var country = ""
        if let userCountry = user.country {
            country = "Country: \(userCountry)"
        }

        var gender = ""
        if let userGender = user.gender {
            gender = "Gender: \(userGender)"
        }

        return [name,age,country,gender]
    }
    
    @objc func Logout()
    {
        self.user.state = .logedOUT
        
        UserDefaults.standard.set(nil,forKey: "LastUser")
        
        navigationController?.popToRootViewController(animated: true)
        
        if(navigationController?.topViewController is DashBoardVC)
        {
            navigationController?.setViewControllers([Router.start()], animated: true)
        }
    }
    
    func setupNavigation()
    {
        view.backgroundColor = .black
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.backgroundColor = .gray
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(selectedProfile))
        self.navigationItem.rightBarButtonItem?.accessibilityIdentifier = "profile"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        Task{
            navigationController?.navigationBar.isHidden = false
            profile.isHidden = true
            profileTV.reloadData()
            showPreference()
            DoclistingCV.reloadData()
            docListingTV.reloadData()
            print("from dahs barod user stqte: \(user.state)")
        }
        Task{
            do{
                if(user.state == .logedIN)
                {
                    let encodedData = try JSONEncoder().encode(user)
                    UserDefaults.standard.set(encodedData,forKey: "LastUser")
                }
                
            }catch{
                print("cant save LastUser")
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Task{
            do{
                let encodedData = try JSONEncoder().encode(user)
//                UserDefaults.standard.set(encodedData,forKey: "LastUser")
                UserDefaults.standard.set(encodedData,forKey: user.username!)

            }catch{
                print("cant save LastUser")
            }
        }
    }
    
    func showPreference()
    {
        if(user.doclist == .collectioin)
        {
            docListingTV.isHidden = true
            DoclistingCV.isHidden = false
        }
        else{
            DoclistingCV.isHidden = true
            docListingTV.isHidden = false
        }
    }
    
    @objc func selectedProfile ()
    {
        configureProfile()

    }
    
    func configureProfile() {
        
        view.addSubview(profile)
        profile.addSubview(profileTV)
        
        NSLayoutConstraint.activate([
            profile.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profile.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            profile.leadingAnchor.constraint(equalTo: view.centerXAnchor),
            profile.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            
            
            profileTV.topAnchor.constraint(equalTo: profile.topAnchor),
            profileTV.bottomAnchor.constraint(equalTo: profile.bottomAnchor),
            profileTV.leadingAnchor.constraint(equalTo: profile.leadingAnchor),
            profileTV.trailingAnchor.constraint(equalTo: profile.trailingAnchor),
        ])
        
        profile.isHidden = !profile.isHidden
        
    }
    
    func ShowListing() {
        print("showing list")
    }
    
}

extension DashBoardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == docListingTV)
        {
            return user.listing.count
        }
         return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == self.profileTV)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = details[indexPath.row]
            cell.textLabel?.textColor = .black
            cell.textLabel?.numberOfLines = 0
            return cell
        }
        
        let docCell = tableView.dequeueReusableCell(withIdentifier: "doclist", for: indexPath)
        docCell.textLabel?.text = user.listing[indexPath.row]
        return docCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == docListingTV)
        {
            showOpeningOptions(indexPath: indexPath)
        }
    }
}

extension DashBoardVC{
    @objc func aleartTextFieldDidChange(_ sender: UITextField)
    {
        vcName?.actions[0].isEnabled = sender.text?.count ?? 0 > 0
    }
    
    
    @objc func newTapped() {
        print("tabped new from dashboard")
        
        vcName = UIAlertController(title: "NewVC", message: "enter titiel for new VC", preferredStyle: .alert)
        vcName?.view.accessibilityIdentifier = "vcNameAlert"
            vcName?.addTextField(){
            textField in
                textField.placeholder = "Enter VC name"
                textField.addTarget(self, action: #selector(self.aleartTextFieldDidChange(_:)), for: .editingChanged)
        }
        
        
        let okAction = UIAlertAction(title: "OK", style: .default) {
              action in 
            if let textField = self.vcName?.textFields?.first,
                 let text = textField.text , !text.isEmpty{
                  
                  
                  self.presenter?.addDocList(user: self.user,text: text)
                  Task{
                      self.docListingTV.reloadData()
                      self.DoclistingCV.reloadData()
                      self.showPreference()
                  }
                  Task{
                      do{
                          let encodedData = try JSONEncoder().encode(self.user)
                          UserDefaults.standard.set(encodedData,forKey: "LastUser")
          
                      }catch{
                          print("cant save LastUser")
                      }
                  }
                  
              }else {
                 print("No value has been entered")
                 return
              }

        }
        
        okAction.isEnabled = false
        okAction.accessibilityIdentifier = "alertOkButton"
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           
           vcName?.addAction(okAction)
           vcName?.addAction(cancelAction)
        present(vcName!, animated: true)
        cancelAction.accessibilityIdentifier = "alertCancelButton"
        
        
        print(user.listing)
        
    }
    
    
    func setupNewButton()
    {
        view.addSubview(buttonView)
        buttonView.addArrangedSubview(newButton)
        buttonView.addArrangedSubview(changeViewButton)
        
        
        NSLayoutConstraint.activate([
            
            buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            
            newButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            newButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            newButton.heightAnchor.constraint(equalTo: buttonView.heightAnchor, multiplier: 1),
            newButton.widthAnchor.constraint(equalTo: buttonView.widthAnchor, multiplier: 0.22),
        ])
    }
    func setupDoclisting(){
        view.addSubview(docListingTV)
        
        NSLayoutConstraint.activate([
            docListingTV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            docListingTV.bottomAnchor.constraint(equalTo: buttonView.topAnchor),
            docListingTV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            docListingTV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

}
extension DashBoardVC: UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.listing.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? MyCollectionViewCell
        
        cell?.titleLabel.text = user.listing[indexPath.item]
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.safeAreaLayoutGuide.layoutFrame.width/3.5
        return CGSize(width:size , height: size/2)
    }
        
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showOpeningOptions(indexPath: indexPath)
    }
        func showOpeningOptions(indexPath: IndexPath)
    {
        let alertController = UIAlertController(title: "Choose an action", message: "Do you want to open or Delete", preferredStyle: .alert)
        alertController.view.accessibilityIdentifier = "openAlert"
        let open = UIAlertAction(title: "Open", style: .default) { _ in
            
            let new = NewVC()
            new.presenter = self.presenter
            new.presenter?.newVc = new
            
            
            let title = self.user.listing[indexPath.row]
            new.configNav(title: title)
            self.present(new, animated: true, completion: nil)
        }
        open.accessibilityIdentifier = "openButton"
        
        let delete = UIAlertAction(title: "Delete", style: .destructive) { _ in
            
            self.user.listing.remove(at: indexPath.row)
            
            Task{
                do{
                    let encodedData = try JSONEncoder().encode(self.user)
                    UserDefaults.standard.set(encodedData,forKey: "LastUser")
                    
                }catch{
                    print("cant save LastUser from change View tappped")
                }
                self.DoclistingCV.reloadData()
                self.docListingTV.reloadData()
            }
            
        }
        delete.accessibilityIdentifier = "deleButton"
        
        alertController.addAction(open)
        alertController.addAction(delete)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    @objc func changeViewTapped()
    {
        if(docListingTV.isHidden){
            DoclistingCV.reloadData()
            docListingTV.isHidden = false
            DoclistingCV.isHidden = true
            
            user.doclist = .table
        }
        else{
            docListingTV.reloadData()
            docListingTV.isHidden = true
            DoclistingCV.isHidden = false
            
            user.doclist = .collectioin
        }
        
        Task{
            do{
                let encodedData = try JSONEncoder().encode(self.user)
                UserDefaults.standard.set(encodedData,forKey: "LastUser")

            }catch{
                print("cant save LastUser from change View tappped")
            }
        }
        
    }
    
}

class MyCollectionViewCell: UICollectionViewCell {
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel = UILabel(frame: contentView.bounds)
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview{
    DashBoardVC()
}
