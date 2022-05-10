

import UIKit

class PostViewController: UIViewController {

    var post: Post?
    lazy var infoViewController = InfoViewController()
    lazy var barButtonInfo: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "i.circle.fill"), style: .plain, target: self, action: #selector(didTapBarInfo))
        return barButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = post?.title ?? "nothing new"
        self.navigationItem.setRightBarButton(barButtonInfo, animated: true)
    }
    
    @objc private func didTapBarInfo() {
        present(infoViewController, animated: true)
    }
    
}
