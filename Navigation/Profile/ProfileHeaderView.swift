//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by admin on 17.03.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    private var buttonTopConstraint: NSLayoutConstraint?
    var isExpanded = true
    
    private lazy var myButton: UIButton = {
        let myButton = UIButton()
        myButton.layer.cornerRadius = 4
        //myButton.layer.masksToBounds = true // commented
        myButton.backgroundColor = .blue
        myButton.tintColor = .white
        myButton.setTitle("Show status", for: .normal)
        myButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        myButton.layer.shadowColor = UIColor.black.cgColor
        myButton.layer.shadowRadius = 4
        myButton.layer.shadowOpacity = 0.7
        myButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        myButton.translatesAutoresizingMaskIntoConstraints = false
        return myButton
    }()
    
    private lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.textColor = .gray
        statusLabel.text = "Waiting for smth"
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "6th Note"
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = true
        textField.backgroundColor = .white
        textField.tintColor = .black
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.placeholder = "Enter your status"
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var avatar: UIImageView = {
        let avatar = UIImageView(image: UIImage(named: "Nota"))
        avatar.layer.cornerRadius = 50
        avatar.layer.masksToBounds = true // commented
        avatar.contentMode = .scaleAspectFill
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.translatesAutoresizingMaskIntoConstraints = false
        return avatar
    }()
    
    var statusText: String?
    
    weak var delegate: ProfileHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
    }
    
    private func drawSelf() {
        
        addSubview(avatar)
        let avaTopConstraint = NSLayoutConstraint(item: avatar, attribute: .top, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 16)
        let avaLeadingConstraint = NSLayoutConstraint(item: avatar, attribute: .leading, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 16)
        let avaWidthConstraint = NSLayoutConstraint(item: avatar, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        let avaHeightConstraint = NSLayoutConstraint(item: avatar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        
        addSubview(myButton)
        buttonTopConstraint = myButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 167)
        let buttonLeadingConstraint = myButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        let buttonWidthConstraint = myButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: 0)
        let buttonHeightConstraint = myButton.heightAnchor.constraint(equalToConstant: 50)
         
        addSubview(nameLabel)
        let nameLabelTopConstraint = nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27)
        let nameLabelLeadingConstraint = nameLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 16)
        let nameLabelTrailingConstraint = nameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        let nameLabelHeightConstraint = nameLabel.heightAnchor.constraint(equalToConstant: 30)
                
        addSubview(statusLabel)
        let statusTopConstraint = statusLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 70)
        let statusLeadingConstraint = statusLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 16)
        let statusTrailingConstraint = statusLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        let statusHeightConstraint = statusLabel.heightAnchor.constraint(equalToConstant: 30)
           
        addSubview(textField)
        let textFieldTopConstraint = textField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16)
        let textFieldLeadingConstraint = textField.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 16)
        let textFieldTrailingConstraint = textField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        let textFieldHeightConstraint = textField.heightAnchor.constraint(equalToConstant: 40)
        
        NSLayoutConstraint.activate([avaTopConstraint, avaLeadingConstraint, avaWidthConstraint, avaHeightConstraint, buttonTopConstraint, buttonWidthConstraint, buttonHeightConstraint, buttonLeadingConstraint, nameLabelTopConstraint, nameLabelHeightConstraint, nameLabelLeadingConstraint, nameLabelTrailingConstraint, statusTopConstraint, statusHeightConstraint, statusLeadingConstraint, statusTrailingConstraint, textFieldTopConstraint, textFieldHeightConstraint, textFieldLeadingConstraint, textFieldTrailingConstraint].compactMap({ $0 }))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapButton() {
//        guard let statusLabell = statusLabel, let text = statusLabell.text else { return }
        if statusText != nil && isExpanded {
            statusLabel.text = statusText
            textField.text = ""
        }
        
        delegate?.statusButtonPressed(isTextFieldVisible: textField.isHidden, completion: {
            self.textField.isHidden.toggle()
        })
        
        buttonTopConstraint?.constant = isExpanded ? 127 : 167
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
            self.textField.alpha = self.isExpanded ? 0 : 1
        } completion: {_ in
            self.isExpanded.toggle()
        }
    }

    
    @objc private func statusTextChanged() {
        statusText = textField.text
    }
}

