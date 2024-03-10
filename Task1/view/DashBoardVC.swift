//
//  DashBoard.swift
//  Task1
//
//  Created by kamalesh-pt7513 on 22/02/24.
//

import Foundation
import UIKit

class DashBoardVC: UIViewController,DashBoardDelegate {
    
    var presenter: presenterDelegate?
    
    //MARK: COLLECTION VIEW SETUP
    let layout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return layout
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray3
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell" )
        
        return collectionView
    }()
    

    


    lazy var user = User()
    lazy var details : [String] = []
    //MARK: TABLE VIEW DOC LISTING
    let docListingTV : UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 44
        tableView.separatorColor = .black
        tableView.backgroundColor = .systemGray3
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "doclist")
        return tableView
    }()
    //MARK: NEW BUTTON
    let newButton: UIButton = {
        let button = UIButton()
//        button.setTitle("New", for: .normal)
        button.setTitleColor(.black, for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize:35)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 40
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
//        button.imageView?.contentMode = .scaleAspectFill
        button.layer.borderWidth = 6
        button.layer.borderColor = UIColor.white.cgColor
        
        button.addTarget(self, action: #selector(newTapped), for: .touchUpInside)
        
        button.backgroundColor = .systemGray3
//        button.sizeToFit()
//        button.clipsToBounds = true
        
        return button
    }()
    let changeViewButton: UIButton = {
        let button = UIButton()
//        button.setTitle("New", for: .normal)
        button.setTitleColor(.black, for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize:35)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 40
        button.setImage(UIImage(systemName: "list.bullet"), for: .normal)
//        button.imageView?.contentMode = .scaleAspectFill
        button.layer.borderWidth = 6
        button.layer.borderColor = UIColor.white.cgColor
        
        button.addTarget(self, action: #selector(changeViewTapped), for: .touchUpInside)
        
        button.backgroundColor = .systemGray3
//        button.sizeToFit()
//        button.clipsToBounds = true
        
        return button
    }()
    
    let buttonView: UIStackView = {
        let buttonView = UIStackView()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.distribution = .fillEqually
        buttonView.spacing = 50
        
        buttonView.backgroundColor = .systemGray3
        
        
//        buttonView.autoresizesSubviews = true
        return buttonView
        
    }()
    
    
    
    //MARK: LOGOUT BUTTON
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
    //MARK: PROFILE
    lazy var profile : UIView = {
        let profile = UIView()
        profile.backgroundColor = .gray
        profile.translatesAutoresizingMaskIntoConstraints = false
        profile.isHidden = true
        return profile
    }()
    //MARK: TABLE VIEW
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .black
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.clipsToBounds = true
        tableView.estimatedRowHeight = 30
        tableView.tableFooterView = logOutButton
        return tableView
    }()
    //MARK: VIDE DID LOAD
    override func viewDidLoad() {
//        var navbar : UINavigationBar = {
//            let navbar = UINavigationBar()
//            navbar.backgroundColor = .blue
//            return navbar
//        }()
        
        super.viewDidLoad()
        
        title = "Login App"
        view.backgroundColor = .systemGray3
        setupNavigation()
        setupNewButton()
        setupDoclisting()
        
        configureCollectionView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        docListingTV.delegate = self
        docListingTV.dataSource = self
        
        collectionView.dataSource = self
        collectionView.delegate  = self
        
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
    //MARK: CONFIGURE COLLECTION VIEW
    
    func configureCollectionView()
    {
        
//        let itemWidth = (view.safeAreaLayoutGuide.layoutFrame.width - layout.sectionInset.left - layout.sectionInset.right - layout.minimumInteritemSpacing * 2) / 3
//        layout.itemSize = CGSize(width: itemWidth, height: itemWidth / 2)
        
        
        
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .systemGray3
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Register your custom UICollectionViewCell subclass
//        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        
        // Set the dataSource to self
        
        // Add the collection view to the view hierarchy
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: buttonView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        
        
        
        
        
    }    //MARK: VIEW DID APPER
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.present(aaa(), animated: true)
    }
    
    //MARK: SET USER INTANCE
    func setUserInstance(user: User)
    {
        self.user = user
        details = extractDetails(user: user)
    }
    //MARK: EXTRACT DETAILS
    func extractDetails(user: User) -> [String]
    {
//        let name = "Name: \(user.username)"
//        let age = "Age: \(user.age)"
//        let country = "Country: \(user.country)"
//        let gender = "Gender: \(user.gender)"
        
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
    //MARK: LOGOUT
    @objc func Logout()
    {
//        UserDefaults.standard.set("yes", forKey: "didLogOUT")
        self.user.state = .logedOUT
        print("from dashbaord : uer stteee is \(user.state)")
        
        //MARK: CHANGES AFTER WORKING
//        Task{
//            do{
//                let encodedData = try JSONEncoder().encode(user)
//                UserDefaults.standard.set(encodedData,forKey: "LastUser")
////                UserDefaults.standard.synchronize()
//                
//            }catch{
//                print("cant save LastUser")
//            }
//        }
        
        //MARK: CHANGES AFTER WORKING
        UserDefaults.standard.set(nil,forKey: "LastUser")
        
        
        print("from dash board logout funtion the lastuser is \(UserDefaults.standard.string(forKey: "LastUser"))")
//        UserDefaults.standard.synchronize()
        navigationController?.popToRootViewController(animated: true)
        if(navigationController?.topViewController is DashBoardVC)
        {
            
            navigationController?.setViewControllers([Router.start()], animated: true)
        }
        
        
        
    }
   
    
    //MARK: SETUP NAVIGATION
    func setupNavigation()
    {
        view.backgroundColor = .black
        navigationItem.hidesBackButton = true
//        view.addSubview(navbar)
//        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.backgroundColor = .gray
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(selectedProfile))
        self.navigationItem.rightBarButtonItem?.accessibilityIdentifier = "profile"
    }
    
    //MARK: VIEW WILL APEAR
    override func viewWillAppear(_ animated: Bool) {
        Task{
            navigationController?.navigationBar.isHidden = false
            profile.isHidden = true
            tableView.reloadData()
            showPreference()
            collectionView.reloadData()
            docListingTV.reloadData()
//            UserDefaults.standard.set("no", forKey: "didLogOUT")
//            user.state = .logedIN
            
            print("from dahs barod user stqte: \(user.state)")
        }
        Task{
            do{
                if(user.state == .logedIN)
                {
                    
                    
                    let encodedData = try JSONEncoder().encode(user)
                    UserDefaults.standard.set(encodedData,forKey: "LastUser")
                    //                UserDefaults.standard.synchronize()
                }
                
            }catch{
                print("cant save LastUser")
            }
        }
        
    }
    //MARK: VIEW DID APEAR
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Task{
            do{
                let encodedData = try JSONEncoder().encode(user)
                UserDefaults.standard.set(encodedData,forKey: "LastUser")
//                UserDefaults.standard.synchronize()
                
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
            collectionView.isHidden = false
        }
        else{
            collectionView.isHidden = true
            docListingTV.isHidden = false
        }
    }
    //MARK: SELECTED PROFILE
    @objc func selectedProfile ()
    {
        configureProfile()
//        navigationController?.pushViewController(NewVC(), animated: true)
//        navigationController?.popToRootViewController(animated: true)
        
    }
    //MARK: CONFIGURE PROFILE
    func configureProfile() {
        
        view.addSubview(profile)
        profile.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            profile.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profile.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            profile.leadingAnchor.constraint(equalTo: view.centerXAnchor),
            profile.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            
            
            tableView.topAnchor.constraint(equalTo: profile.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: profile.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: profile.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: profile.trailingAnchor),
        ])
        
        profile.isHidden = !profile.isHidden
        
    }
    //MARK: SHOW LISTING
    func ShowListing() {
        print("showing list")
    }
    
}
//MARK: TABLE VIEW DELEGATE
extension DashBoardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == docListingTV)
        {
            return user.listing.count
        }
         return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == self.tableView)
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
//            let new = NewVC()
//            let title = user.listing[indexPath.row]
//            new.configNav(title: title)
//            self.present(new, animated: true, completion: nil)
            showOpeningOptions(indexPath: indexPath)
        }
    }
    
    
}
//MARK: EXTENSION 2
extension DashBoardVC{
    
    
    @objc func newTapped() {
        print("tabped new from dashboard")
        
        
        
        let vcName = UIAlertController(title: "NewVC", message: "enter titiel for new VC", preferredStyle: .alert)
            vcName.addTextField(){
            textField in
            textField.placeholder = "Enter VC name"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) {
              action in 
              if let textField = vcName.textFields?.first,
              let text = textField.text{
                  
                  
                  self.presenter?.addDocList(user: self.user,text: text)
                  Task{
                      self.docListingTV.reloadData()
                      self.collectionView.reloadData()
                      self.showPreference()
                  }
                  Task{
                      do{
                          let encodedData = try JSONEncoder().encode(self.user)
                          UserDefaults.standard.set(encodedData,forKey: "LastUser")
          //                UserDefaults.standard.synchronize()
                          
                      }catch{
                          print("cant save LastUser")
                      }
                  }
                  
              }else {
                 print("No value has been entered in email address")
                  
                 return
              }

        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           // adding actions to alert
           vcName.addAction(okAction)
           vcName.addAction(cancelAction)
        present(vcName, animated: true)
        
        
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
//            newButton.heightAnchor.constraint(equalToConstant: 100),
//            newButton.widthAnchor.constraint(equalToConstant: 100)
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
extension DashBoardVC: UICollectionViewDelegate,
    
    UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
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

            let open = UIAlertAction(title: "Open", style: .default) { _ in
                
                let new = NewVC()
                new.presenter = self.presenter //for the flow
                new.presenter?.newVc = new
//                new.presenter?.interactor = self.presenter?.interactor
//                new.presenter?.interactor?.presenter = self.presenter
                let title = self.user.listing[indexPath.row]
                new.configNav(title: title)
                self.present(new, animated: true, completion: nil)
            }

            let delete = UIAlertAction(title: "Delete", style: .destructive) { _ in
                
                self.user.listing.remove(at: indexPath.row)
                
                Task{
                    do{
                        let encodedData = try JSONEncoder().encode(self.user)
                        UserDefaults.standard.set(encodedData,forKey: "LastUser")
                        
                    }catch{
                        print("cant save LastUser from change View tappped")
                    }
                    self.collectionView.reloadData()
                    self.docListingTV.reloadData()
                }
                
            }

            alertController.addAction(open)
            alertController.addAction(delete)

            present(alertController, animated: true, completion: nil)
        }
    
    
    @objc func changeViewTapped()
    {
        if(docListingTV.isHidden){
            collectionView.reloadData()
            docListingTV.isHidden = false
            collectionView.isHidden = true
            
            user.doclist = .table
        }
        else{
            docListingTV.reloadData()
            docListingTV.isHidden = true
            collectionView.isHidden = false
            
            user.doclist = .collectioin
        }
        
        Task{
            do{
                let encodedData = try JSONEncoder().encode(self.user)
                UserDefaults.standard.set(encodedData,forKey: "LastUser")
//                UserDefaults.standard.synchronize()
                
            }catch{
                print("cant save LastUser from change View tappped")
            }
        }
        
        
    }
    
    
}
//MARK: CUSTOM COLLECTIO VIEW CELL
class MyCollectionViewCell: UICollectionViewCell {
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Create a UILabel and add it to the cell's contentView
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



//extension DashBoardVC:{
//    func saveAppState() {
//        // Save the state of this view controller if needed
//        // In this example, we'll save the text of the label
//        do{
//            let encodedData = try JSONEncoder().encode(user)
//            UserDefaults.standard.set(encodedData,forKey: "key")
////            print("create new account succesfully")
////            presenter?.showLoadingPage(user: user)
//        }catch{
//            print("error occured while creting user")
//        }
////        UserDefaults.standard.set(user, forKey: "key")
//    }
//    
//    func restoreAppState() {
//        // Restore the state of this view controller if needed
//        // In this example, we'll restore the text of the label
//        if let user = UserDefaults.standard.data(forKey: "key"){
//            do{
//                let decodedInstance = try JSONDecoder().decode(User.self, from: user)
////                self.user = decodedInstance
//                setUserInstance(user: decodedInstance)
//            }catch{
//                print("can't decode")
//            }
//        }
//    }
//}
//#Preview{
//    DashBoardVC()
//}
//MARK: CALSS NEW VC

#Preview{
    DashBoardVC()
}
