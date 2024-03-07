//
//  CustomTextField.swift
//  Task1
//
//  Created by kamalesh-pt7513 on 21/02/24.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure()
    {
        
        translatesAutoresizingMaskIntoConstraints = false
//        isHidden = true
        textColor = .label
        font = .systemFont(ofSize: 20)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
        textAlignment = .left
        adjustsFontSizeToFitWidth = true
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        keyboardAppearance = .dark
        keyboardType = .default
        returnKeyType = .go
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        
    }
}
