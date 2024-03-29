






import Foundation
import UIKit

class NewVC: UIViewController , newVcDelegate {
    
    var presenter: presenterDelegate?
    var names: [Names] = []
    var textlabel = forMatingLabel()
    
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(customTable.self, forCellReuseIdentifier: customTable.identifier)
        tableView.layer.cornerRadius = 20
        return tableView
    }()
    
    var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Iam a Button", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        button.showsMenuAsPrimaryAction = true
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 15
        button.isUserInteractionEnabled = true
        button.backgroundColor = .white
        return button
    }()

    var nav:UINavigationBar = {
        let nav = UINavigationBar()
        nav.prefersLargeTitles = true
        nav.backgroundColor = .systemBackground
        nav.translatesAutoresizingMaskIntoConstraints = false
        return nav
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint
        setupFormating()
        setupTableView()
        tableView.dataSource = self
            
    }
    func setupTableView(){
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: button.bottomAnchor,constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let attributedStringData = try? NSKeyedArchiver.archivedData(withRootObject: textlabel.attributedText, requiringSecureCoding: false) {
            
            UserDefaults.standard.set(attributedStringData, forKey: "attributedStringKey")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if let attributedStringData = UserDefaults.standard.data(forKey: "attributedStringKey") {

            if let retrievedAttributedString = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(attributedStringData) as? NSAttributedString {

                textlabel.attributedText =  retrievedAttributedString
            } else {
                print("Error: Failed to unarchive attributed string")
            }
        } else {
            print("Error: No data found for key")
        }
        presenter?.fetchData()
    }
    
    func configNav(title : String)
    {
        
        nav.items = [UINavigationItem(title: title)]
        
        NSLayoutConstraint.activate([
            nav.topAnchor.constraint(equalTo: view.topAnchor),
            nav.heightAnchor.constraint(equalToConstant: 100),
            nav.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nav.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
        
    }
    func setupFormating()
    {

        view.addSubview(textlabel)
        view.addSubview(nav)
        view.addSubview(button)
        
        textlabel.accessibilityIdentifier = "NewVctextLabel"
        
        let contexMenu = UIContextMenuInteraction(delegate: self)
        contexMenu.view?.removeGestureRecognizer(UILongPressGestureRecognizer())
        textlabel.addInteraction(contexMenu)
        
        let bold = UIAction(title: "Bold",image: UIImage(systemName: "bold")) { _ in
            print("bold taped")
        }
        let strike = UIAction(title: "italic",image: UIImage(systemName: "italic")) { _ in
            print("italic taped")
        }
        let underline = UIAction(title: "strike",image: UIImage(systemName: "underline")) { _ in
            print("strike taped")
        }
        
        button.menu = UIMenu(children: [bold,strike,underline])
        
        NSLayoutConstraint.activate([
            textlabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textlabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textlabel.topAnchor.constraint(equalTo: nav.bottomAnchor),
            textlabel.heightAnchor.constraint(equalToConstant: 44),
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.topAnchor.constraint(equalTo: textlabel.bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 44),
        ])
        
    }

}
extension NewVC: UIContextMenuInteractionDelegate{
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        let italicAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.italicSystemFont(ofSize: self.textlabel.font.pointSize)
        ]
        let boldAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: self.textlabel.font.pointSize,weight: .bold)
        ]
        let boldItalicAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "verdana-BoldItalic", size: self.textlabel.font.pointSize)
        ]
        let strikeThroughAttribute: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: NSUnderlineStyle.single.rawValue
        ]
        let underlineAttribute: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        return  UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in

            let bold = UIAction(title: "Bold",image: UIImage(systemName: "bold")) { _ in
                
                if let labeltext = self.textlabel.attributedText
                {
                    print(labeltext)
                    let formatText = NSMutableAttributedString(attributedString: labeltext)
                    if(!self.textlabel.boldFlag)
                    {
                        self.textlabel.boldFlag = true
                        switch(self.getFormat(boldflag: self.textlabel.boldFlag,italicflag: self.textlabel.italicFlag))
                        {
                        case .bold:
                            formatText.addAttributes(boldAttribute, range: NSRange(location: 0, length: labeltext.length))
                        case .bolditalic:
                            formatText.addAttributes(boldItalicAttribute, range: NSRange(location: 0, length: labeltext.length))
                        default:
                            break
                        }
                        
                    }else
                    {
                        self.textlabel.boldFlag = false
                        formatText.removeAttribute(.font, range: NSRange(location: 0, length: labeltext.length))
                        switch(self.getFormat(boldflag: self.textlabel.boldFlag,italicflag: self.textlabel.italicFlag))
                        {
                        case .italic:
                            formatText.addAttributes(italicAttribute, range: NSRange(location: 0, length: labeltext.length))
                        default:
                            break
                        }
                         
                    }
                    self.textlabel.attributedText = formatText
                    
                }

            }
            bold.accessibilityIdentifier = "bold"
            
            let italic = UIAction(title: "Italic",image: UIImage(systemName: "italic") ) { _ in

                if let labeltext = self.textlabel.attributedText
                {
                 
                    print(labeltext)
                    let formatText = NSMutableAttributedString(attributedString: labeltext)
                    if(!self.textlabel.italicFlag)
                    {
                        self.textlabel.italicFlag = true
                        switch(self.getFormat(boldflag: self.textlabel.boldFlag,italicflag: self.textlabel.italicFlag))
                        {
                        case .bold:
                            formatText.addAttributes(boldAttribute, range: NSRange(location: 0, length: labeltext.length))
                        case .italic:
                            formatText.addAttributes(italicAttribute, range: NSRange(location: 0, length: labeltext.length))
                        case .bolditalic:
                            formatText.addAttributes(boldItalicAttribute, range: NSRange(location: 0, length: labeltext.length))
                        default:
                            break
                        }
                        
                    }else
                    {
                        self.textlabel.italicFlag = false
                        formatText.removeAttribute(.font, range: NSRange(location: 0, length: labeltext.length))
                        switch(self.getFormat(boldflag: self.textlabel.boldFlag,italicflag: self.textlabel.italicFlag))
                        {
                        case .bold:
                            formatText.addAttributes(boldAttribute, range: NSRange(location: 0, length: labeltext.length))
                        default:
                            break
                        }
                         
                    }
                    self.textlabel.attributedText = formatText
                }
                
            }
            italic.accessibilityIdentifier = "italic"
            
            let strike = UIAction(title: "strike",image: UIImage(systemName: "strikethrough" )) { _ in
                
                if var labeltext = self.textlabel.attributedText
                {
                    print(labeltext.description)
                    var formatText = NSMutableAttributedString(attributedString: labeltext)
                    
                    if(!self.textlabel.strikeFlag)
                    {
                        formatText.addAttributes(strikeThroughAttribute, range: NSRange(location: 0, length: labeltext.length))
                        self.textlabel.strikeFlag = !self.textlabel.strikeFlag
                    }else
                    {
                        formatText.removeAttribute(.strikethroughStyle, range: NSRange(location: 0, length: labeltext.length))
                        self.textlabel.strikeFlag = !self.textlabel.strikeFlag
                    }
                    
                    self.textlabel.attributedText = formatText
                    
                }
            }
            strike.accessibilityIdentifier = "strike"
            
            let underline = UIAction(title: "underline",image: UIImage(systemName: "underline")) { _ in
                if var labeltext = self.textlabel.attributedText
                {
                    print(labeltext.description)
                    var formatText = NSMutableAttributedString(attributedString: labeltext)
                    
                    if(!self.textlabel.underlineFlag)
                    {
                        formatText.addAttributes(underlineAttribute, range: NSRange(location: 0, length: labeltext.length))
                        self.textlabel.underlineFlag = !self.textlabel.underlineFlag
                    }
                    else
                    {
                        formatText.removeAttribute(.underlineStyle, range: NSRange(location: 0, length: labeltext.length))
                        self.textlabel.underlineFlag = !self.textlabel.underlineFlag
                    }
                    
                    
                    self.textlabel.attributedText = formatText
                    
                }
            }
            underline.accessibilityIdentifier = "underline"
            
            return UIMenu(children: [bold,italic,strike,underline])
        }
    }
    func getFormat(boldflag: Bool, italicflag: Bool) -> LabelState
    {
        if(boldflag && italicflag)
        {
            return .bolditalic
        }
        else if(boldflag)
        {
            return .bold
        }
        else if(italicflag)
        {
            return .italic
        }
        else
        {
            return .none
        }
        
    }
}

class forMatingLabel: UILabel {
    
    var boldFlag = false
    var italicFlag = false
    var strikeFlag = false
    var underlineFlag = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: 30)
        textAlignment = .center
        contentMode = .center
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 3
        layer.cornerRadius = 15

        attributedText = NSMutableAttributedString(string: "Formate me")
        isUserInteractionEnabled = true
        backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NewVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: customTable.identifier, for: indexPath) as! customTable
        cell.textlabel.attributedText = NSMutableAttributedString(string: names[indexPath.row].name)
        return cell
    }
    
    
}
extension NewVC{
    
    func updateView(usernames: [Names]) {
        self.names = usernames
        Task{
            tableView.reloadData()
        }
    }

    func showError(with error: Error) {
        print(error.localizedDescription)
    }
}



#Preview{
    NewVC()
}









