






import Foundation
import UIKit
class customTable: UITableViewCell{
    
    static let identifier = "customTableCellIdenditfier"
    let textlabel = forMatingLabel()
    
    let moreButton: UIButton = {
        let button = UIButton()
        button.showsMenuAsPrimaryAction = true
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .default
        contentView.bringSubviewToFront(moreButton)
        self.addSubview(textlabel)
        self.addSubview(moreButton)
        setupUI()
        addAction()
    }
    func setupUI()
    {
        textlabel.layer.borderWidth = 0
        textlabel.layer.borderColor = UIColor.white.cgColor
        textlabel.layer.borderWidth = 0
        textlabel.textAlignment = .left
        
        
        NSLayoutConstraint.activate([
            textlabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textlabel.heightAnchor.constraint(equalToConstant: 50),
            textlabel.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor),
            
            moreButton.leadingAnchor.constraint(equalTo: textlabel.trailingAnchor),
            moreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            moreButton.widthAnchor.constraint(equalToConstant: 50),
            moreButton.heightAnchor.constraint(equalToConstant: 50),
            
            
        ])
        
    }
    
    func addAction()
    {
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
        
        moreButton.menu = UIMenu(children: [bold,italic,strike,underline])
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
    
    required init?(coder: NSCoder) {
        fatalError("fatol error in newvc custom table view")
    }
    
    
}
