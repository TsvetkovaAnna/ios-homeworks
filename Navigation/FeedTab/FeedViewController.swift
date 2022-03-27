//
//  FeedViewController.swift
//  Navigation
//
//  Created by Anna Tsvetkova on 15.03.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    lazy var openPostButton: UIButton = {
        let openPostButton = RoundedButton(cornerRadius: UIScreen.main.bounds.width * 0.05)
        openPostButton.addTarget(self, action: #selector(openPost), for: .touchUpInside)
        openPostButton.backgroundColor = .systemCyan
        openPostButton.tintColor = .white
        openPostButton.setTitle("Open Post", for: .normal)
        return openPostButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonConstraints()
        view.backgroundColor = .brown
    }
    
    private func makeButtonConstraints() {
        view.addSubview(openPostButton)
        let leadingConstraint = openPostButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        let trailingConstraint = openPostButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        let topConstraint = openPostButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let heightConstraint = openPostButton.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, heightConstraint])
    }
    
    @objc private func openPost() {
        let postViewController = PostViewController()
        postViewController.post = Post(title: "smth")
        navigationController?.pushViewController(postViewController, animated: true)
        //present(postViewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //guard segue.identifier == "openPostSegue" else { return }
        //let postViewController = segue.destination as? PostViewController
        //postViewController?.post = Post(title: "smth")
    }

}
