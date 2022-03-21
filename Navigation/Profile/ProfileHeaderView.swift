//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by admin on 17.03.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    var statusLabel: UILabel?
    var textField: UITextField?
    var statusText: String?
    
    override func draw(_ rect: CGRect) {
        let avatar = UIImageView(image: UIImage(named: "turtle2"))
        
        avatar.layer.cornerRadius = 50
        avatar.layer.masksToBounds = true // commented
        avatar.contentMode = .scaleAspectFill
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = UIColor.white.cgColor
        addSubview(avatar)
        
        NSLayoutConstraint(item: avatar, attribute: .top, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: avatar, attribute: .leading, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: avatar, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100).isActive = true
        NSLayoutConstraint(item: avatar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100).isActive = true
        avatar.translatesAutoresizingMaskIntoConstraints = false
        
        let myButton  = UIButton()
        myButton.layer.cornerRadius = 4
        //myButton.layer.masksToBounds = true // commented
        myButton.backgroundColor = .blue
        myButton.tintColor = .white
        //myButton.titleLabel?.text = "Show Status"
        myButton.setTitle("Show status", for: .normal)
        addSubview(myButton)
        
        myButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        myButton.layer.shadowColor = UIColor.black.cgColor
        myButton.layer.shadowRadius = 4
        myButton.layer.shadowOpacity = 0.7
        
        NSLayoutConstraint(item: myButton, attribute: .top, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 183).isActive = true
        NSLayoutConstraint(item: myButton, attribute: .leading, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: myButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: myButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
        myButton.translatesAutoresizingMaskIntoConstraints = false
        
        myButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        let nameLabel = UILabel()
        nameLabel.text = "Indi Turtle"
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        addSubview(nameLabel)
        
        NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 27).isActive = true
        NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: avatar, attribute: .trailing, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -16).isActive = true
        NSLayoutConstraint(item: nameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30).isActive = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        statusLabel = UILabel()
        statusLabel?.textColor = .gray
        statusLabel?.text = "Waiting for smth"
        if let status = statusLabel {
            addSubview(status)
        }
        
        NSLayoutConstraint(item: statusLabel!, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 25).isActive = true
        NSLayoutConstraint(item: statusLabel!, attribute: .leading, relatedBy: .equal, toItem: avatar, attribute: .trailing, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: statusLabel!, attribute: .trailing, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -16).isActive = true
        NSLayoutConstraint(item: statusLabel!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30).isActive = true
        statusLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        textField = UITextField()
        //status?.text = "Waiting for smth"
        
        if let textFieldd = textField {
            textFieldd.layer.cornerRadius = 12
            textFieldd.layer.masksToBounds = true
            textFieldd.backgroundColor = .white
            textFieldd.tintColor = .black
            textFieldd.font = UIFont.systemFont(ofSize: 15)
            textFieldd.layer.borderWidth = 1
            textFieldd.layer.borderColor = UIColor.black.cgColor
            textFieldd.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldd.frame.height))
            textFieldd.leftViewMode = .always
            textFieldd.placeholder = "Enter your status"
            addSubview(textFieldd)
        }
       
        textField?.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
       
        
        NSLayoutConstraint(item: textField!, attribute: .top, relatedBy: .equal, toItem: statusLabel!, attribute: .bottom, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: textField!, attribute: .leading, relatedBy: .equal, toItem: avatar, attribute: .trailing, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: textField!, attribute: .trailing, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -16).isActive = true
        NSLayoutConstraint(item: textField!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40).isActive = true
        
        
        textField!.translatesAutoresizingMaskIntoConstraints = false
        
        textField?.backgroundColor = .white
    }
    
    
    @objc private func didTapButton() {
        guard let statusLabell = statusLabel, let text = statusLabell.text else { return }
        print(text)
        if statusText != nil {
            statusLabel?.text = statusText
            textField?.text = ""
        }
    }
    
    @objc private func statusTextChanged() {
        guard let textField = textField else { return }
        statusText = textField.text
    }
}
