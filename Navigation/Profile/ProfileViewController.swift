//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Anna Tsvetkova on 15.03.2022.
//

import UIKit

protocol ProfileHeaderViewDelegate: AnyObject {
    func statusButtonPressed(isTextFieldVisible: Bool, completion: @escaping () -> Void)
}

class ProfileViewController: UIViewController {
    
   // lazy var profileHeaderView: = ProfileHeaderView()
        
    var heightButtonConstraint: NSLayoutConstraint?
    
    lazy var profileHeaderView: ProfileHeaderView = {
        let profileHeaderView = ProfileHeaderView(frame: .zero)
        profileHeaderView.delegate = self
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return profileHeaderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.isHidden = false
        title = "Profile"
        setupHeaderView()
    }
    
    private func setupHeaderView() {
        view.addSubview(profileHeaderView)
        let leadingConstraint = profileHeaderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        let trailingConstraint = profileHeaderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        let topConstraint = profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        heightButtonConstraint = profileHeaderView.heightAnchor.constraint(equalToConstant: 230)
        
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, heightButtonConstraint].compactMap({ $0 }))
    }
}
//    override func viewWillLayoutSubviews() {
//        profileHeaderView.frame = view.bounds
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

extension ProfileViewController: ProfileHeaderViewDelegate {
    func statusButtonPressed(isTextFieldVisible: Bool, completion: @escaping () -> Void) {
        heightButtonConstraint?.constant = isTextFieldVisible ? 220 : 180
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}
