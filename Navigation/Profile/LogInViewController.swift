//
//  LogInViewController.swift
//  Navigation
//
//  Created by Anna Tsvetkova on 26.03.2022.
//

import UIKit

final class LogInViewController: UIViewController {

    private var accentColor = UIColor(named: "AccentColor")
    
    private var loginButtonHeight: CGFloat = 50
    
    private var loginButtonTopConstraint: NSLayoutConstraint?
    
    private var isAlertAnimationBlocked = false
    
    private let trueLogin = "n"
    
    private let truePassword = "222222"
    
    private lazy var alertPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password should be not shorter then 6 symbols"
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .red
        //label.isHidden = true
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var loginButton: UIButton = {
        let loginButton = RoundedButton(cornerRadius: 10)
        loginButton.addTarget(self, action: #selector(makeLogin), for: .touchUpInside)
        let blueImage = UIImage(named: "blue")
        loginButton.setBackgroundImage(blueImage, for: .normal)
        loginButton.setTitle("Log In", for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(valueChanged(sender:)), for: .valueChanged)
        return loginButton
    }()
    
    @objc func valueChanged(sender: UIButton) {
        switch sender.state {
        case .normal:
            sender.alpha = 1
        case .selected, .highlighted, .disabled:
            sender.alpha = 0.8
        default:
            sender.alpha = 1
        }
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.contentSize = view.safeAreaLayoutGuide.layoutFrame.size
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        //customView.backgroundColor = .red
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
        
    private lazy var separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    private lazy var logoVK: UIImageView = {
        let logoVK = UIImageView(image: UIImage(named: "logoVK"))
        logoVK.translatesAutoresizingMaskIntoConstraints = false
        return logoVK
    }()
    
    private lazy var loginField: IndentTextField = {
        let login = IndentTextField()
        login.textColor = .black
        login.font = UIFont.systemFont(ofSize: 16)
        login.tintColor = accentColor
        login.autocapitalizationType = .none
//        login.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: login.frame.height))
//        login.leftViewMode = .always
        login.placeholder = "Email or phone"
        //let isValid = "somemail".range(of: #""#, options: .regularExpression) != nil
        login.translatesAutoresizingMaskIntoConstraints = false
        return login
    }()
    
    private lazy var passwordField: IndentTextField = {
        let password = IndentTextField()
        stackView.axis = .vertical
        password.textColor = .black
        password.font = UIFont.systemFont(ofSize: 16)
        password.tintColor = accentColor
        password.autocapitalizationType = .none
//        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: password.frame.height))
//        password.leftViewMode = .always
        password.isSecureTextEntry = true
        password.placeholder = "Password"
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
       // stackView.axis = .vertical
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 0.5
        stackView.clipsToBounds = true
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.backgroundColor = .systemGray6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        UITapGestureRecognizer(target: self, action: #selector(viewTapped))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true //не скрылся навигейшн!!
        self.view.backgroundColor = .white
        drawSelf()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addGestureRecognizer(tapRecognizer)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        view.removeGestureRecognizer(tapRecognizer)
        
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        
        guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        
        let offsetY = keyboardFrameValue.cgRectValue.height
        scrollView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
        
        //scrollView.frame -
    }
    
    @objc func keyboardWillHide() {
        scrollView.setContentOffset(.zero, animated: true)
    }
    
    @objc func viewTapped() {
        view.endEditing(true)
    }
  //--------------------
    @objc private func keyboardDidShow(_ notification: Notification) {
        print(#function)
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let loginButtonBottomPointY = loginButton.frame.origin.y + loginButtonHeight
            let keyboardOriginY = view.safeAreaLayoutGuide.layoutFrame.height - keyboardHeight
            
            var tabBarHeight: CGFloat = 0
            if let barHeight = navigationController?.tabBarController?.tabBar.frame.height {
                tabBarHeight = barHeight
            }
            
            let yOffset = keyboardOriginY <= loginButtonBottomPointY ? loginButtonBottomPointY - keyboardOriginY + 16 - tabBarHeight  : 0
            
            scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
        }
    }
    
    @objc private func keyboardDidHide(_ notification: Notification) {
        print(#function)
        //view.endEditing(true)
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    //-----------------
    private func drawSelf() {
        
        view.addSubview(scrollView)
        let scrollViewTop = scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let scrollViewBottom = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        let scrollViewLeading = scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        let scrollViewTrailing = scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        
        scrollView.addSubview(contentView)
        let customViewTop = contentView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        //let customViewHeight = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)//522.5)
        let customViewHeight = contentView.heightAnchor.constraint(equalToConstant: 700)
        let customViewWidth = contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        let customViewX = contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        
        contentView.addSubview(loginButton)
        let buttonHeight = loginButton.heightAnchor.constraint(equalToConstant: loginButtonHeight)
        loginButtonTopConstraint = loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16)
        let buttonLeading = loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        let buttonCenterX = loginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        
        contentView.addSubview(logoVK)
        let logoHeightConstraint = logoVK.heightAnchor.constraint(equalToConstant: 100)
        let logoWidthConstraint = logoVK.widthAnchor.constraint(equalToConstant: 100)
        let logoTopConstraint = logoVK.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120)
        let logoXConstraint = logoVK.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        
        contentView.addSubview(stackView)
        //contentView.bringSubviewToFront(stackView)
        stackView.addArrangedSubview(loginField)
        stackView.addArrangedSubview(separator)
        stackView.addArrangedSubview(passwordField)
        let stackLeadingConstraint = stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        let stackCenterXConstraint = stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let stackTopConstraint = stackView.topAnchor.constraint(equalTo: logoVK.bottomAnchor, constant: 120)
        let stackHeightConstraint = stackView.heightAnchor.constraint(equalToConstant: 100.5)
        let loginHeightConstraint = loginField.heightAnchor.constraint(equalToConstant: 50)
        let passwordHeightConstraint = passwordField.heightAnchor.constraint(equalToConstant: 50)
        let separatorHeight = separator.heightAnchor.constraint(equalToConstant: 0.5)
        
        contentView.addSubview(alertPasswordLabel)
        let alertTop = alertPasswordLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16)
        let alertX = alertPasswordLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
//        let alertTrailing = alertPasswordLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
//        let alertBottom = alertPasswordLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: 16)
        NSLayoutConstraint.activate([scrollViewTop, scrollViewBottom, scrollViewLeading, scrollViewTrailing, stackLeadingConstraint, stackCenterXConstraint, stackTopConstraint, stackHeightConstraint, loginHeightConstraint, passwordHeightConstraint, logoXConstraint, logoTopConstraint, logoWidthConstraint, logoHeightConstraint, separatorHeight, loginButtonTopConstraint, buttonHeight, buttonLeading, buttonCenterX, customViewTop, customViewWidth, customViewHeight, customViewX, alertTop, alertX].compactMap({ $0 }))
        //stackView.endEditing(true)
        //login.resignFirstResponder()
        //password.resignFirstResponder()
    }
    
    @objc private func makeLogin() {
        
        guard !isAlertAnimationBlocked,
              let login = loginField.text,
              let password = passwordField.text
        else { return }
        
        if login == "" {
            self.loginField.backgroundColor = .purple
            self.loginField.backgroundColor = self.loginField.backgroundColor?.withAlphaComponent(0.5)
//            UIView.animate(withDuration: 0.3) {
//                self.view.layoutIfNeeded()
//            } completion: { _ in
                UIView.animate(withDuration: 0.3, delay: 1) {
                    self.loginField.backgroundColor = .clear
                    self.view.layoutIfNeeded()
               // }
            }
        }

        if password == "" {
            self.passwordField.backgroundColor = .purple
            self.passwordField.backgroundColor = self.passwordField.backgroundColor?.withAlphaComponent(0.5)
//            UIView.animate(withDuration: 0.3 ) {
//                self.view.layoutIfNeeded()
//            } completion: { _ in
                UIView.animate(withDuration: 0.3, delay: 1) {
                    self.passwordField.backgroundColor = .clear
                    self.view.layoutIfNeeded()
                //}
            }
        }
        
        if password.count < 6 && password.count > 0 {
            alertAnimation()
        } else if password.count > 5 {
            if login == trueLogin && password == truePassword { //Nota 222222
            navigationController?.pushViewController(ProfileViewController(), animated: true)
            } else if login.count > 0 {
                let alertController = UIAlertController(title: "Login Failed", message: "Wrong Name or Password", preferredStyle: .alert)
                let ok = UIAlertAction(title: "ok", style: .cancel) { _ in
                    print("ok pushed")
                }
                alertController.addAction(ok)
                present(alertController, animated: true)
            }
        }
    }
    
    func alertAnimation() {
        isAlertAnimationBlocked = true
        self.passwordField.backgroundColor = .purple
        self.passwordField.backgroundColor = self.passwordField.backgroundColor?.withAlphaComponent(0.5)
        UIView.animate(withDuration: 0.3, delay: 0) {
            print("animate")
            self.loginButtonTopConstraint?.constant += 20
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.3, delay: 0.15) {
                self.alertPasswordLabel.alpha = 1
            }
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 3) {
                print("revert")
                self.alertPasswordLabel.alpha = 0
                UIView.animate(withDuration: 0.3, delay: 3.15) {
                    self.passwordField.backgroundColor = .clear
                    self.loginButtonTopConstraint?.constant -= 20
                    self.view.layoutIfNeeded()
                } completion: { _ in
                    self.isAlertAnimationBlocked = false
                }
            }
        }
    }
        
    func alertAnimation2() { //не используется
        isAlertAnimationBlocked = true
        UIView.animate(withDuration: 1.3, delay: 0) {
            print("animate")
            self.passwordField.backgroundColor = .purple
            self.passwordField.backgroundColor = self.passwordField.backgroundColor?.withAlphaComponent(0.5)
            self.loginButtonTopConstraint?.constant += 70
            self.view.layoutIfNeeded()
        } completion: { _ in
            UIView.animate(withDuration: 1.3, delay: 0) {
                self.alertPasswordLabel.alpha = 1
            } completion: { _ in
                UIView.animate(withDuration: 1.3, delay: 5) {
                    print("revert")
                    self.alertPasswordLabel.alpha = 0
                } completion: { _ in
                    UIView.animate(withDuration: 1.3, delay: 0) {
                        self.passwordField.backgroundColor = .clear
                        self.loginButtonTopConstraint?.constant -= 70
                        self.view.layoutIfNeeded()
                    } completion: { _ in
                        self.isAlertAnimationBlocked = false
                    }
                }
            }
        }
    }

//    @objc private func makeLogin() {
//        let profileViewController = ProfileViewController()
//        navigationController?.pushViewController(profileViewController, animated: true)
//    }


}
