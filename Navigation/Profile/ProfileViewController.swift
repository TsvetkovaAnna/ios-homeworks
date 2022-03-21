//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Anna Tsvetkova on 15.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profileHeaderView: ProfileHeaderView?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray

        profileHeaderView = ProfileHeaderView()
        guard let subview = profileHeaderView else { return }
        view.addSubview(subview)
        navigationController?.navigationBar.isHidden = false
        title = "Profile"
    }
    
    override func viewWillLayoutSubviews() {
        profileHeaderView?.frame = view.bounds
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
