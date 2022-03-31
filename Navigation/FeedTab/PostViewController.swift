//
//  PostViewController.swift
//  Navigation
//
//  Created by Anna Tsvetkova on 15.03.2022.
//
import UIKit

class PostViewController: UIViewController {

    var post: Post?
    lazy var infoViewController = InfoViewController()
    lazy var barButtonInfo: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "i.circle.fill"), style: .plain, target: self, action: #selector(didTapBarInfo))
        return barButton
    }()
    
    //let infoViewController = InfoViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = post?.title ?? "nothing new"
        self.navigationItem.setRightBarButton(barButtonInfo, animated: true)
    }
    
    @objc private func didTapBarInfo() {
//        let infoViewController = InfoViewController()
        present(infoViewController, animated: true)
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
