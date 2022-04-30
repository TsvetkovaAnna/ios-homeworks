

import UIKit

class FeedViewController: UIViewController {
    
    public func openPostButton(tag: Int) -> UIButton {
        let openPostButton = RoundedButton(cornerRadius: 12)
        openPostButton.addTarget(self, action: #selector(openPostInStack(sender:)), for: .touchUpInside)
        openPostButton.tag = tag
        openPostButton.backgroundColor = UIColor(named: "AccentColor")
        openPostButton.tintColor = .white
        openPostButton.setTitle("Open Post", for: .normal)
        openPostButton.translatesAutoresizingMaskIntoConstraints = false
        return openPostButton
    }
    
    private lazy var photoBackView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "Nota2"))
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .systemGray6
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPhotoView()
        setStackView()
    }
    
    private func setPhotoView() {
        view.addSubview(photoBackView)
        let photoLeadingConstraint = photoBackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        let photoCenterXConstraint = photoBackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        let photoCenterYConstraint = photoBackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        NSLayoutConstraint.activate([photoLeadingConstraint, photoCenterXConstraint, photoCenterYConstraint])
        
    }
    
    private func setStackView() {
        let firstButton = openPostButton(tag: 0)
        let secondButton = openPostButton(tag: 1)
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        photoBackView.addSubview(stackView)
        view.bringSubviewToFront(stackView)
        stackView.backgroundColor = .clear
        let stackLeadingConstraint = stackView.leadingAnchor.constraint(equalTo: photoBackView.leadingAnchor)
        let stackCenterXConstraint = stackView.centerXAnchor.constraint(equalTo: photoBackView.centerXAnchor)
        let stackCenterYConstraint = stackView.centerYAnchor.constraint(equalTo: photoBackView.centerYAnchor)
        let firstButtonHeightConstraint = firstButton.heightAnchor.constraint(equalToConstant: 50)
        let secondButtonHeightConstraint = secondButton.heightAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([stackLeadingConstraint, stackCenterXConstraint, stackCenterYConstraint, firstButtonHeightConstraint, secondButtonHeightConstraint])
    }
    
    @objc private func openPost() {
        let postViewController = PostViewController()
        postViewController.post = Post(title: "smth")
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    @objc private func openPostInStack(sender: UIButton) {
        let postViewController = PostViewController()
        let posts: [Post] = [Post(title: "first post"), Post(title: "Second Post")]
        postViewController.post = posts[sender.tag]
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //guard segue.identifier == "openPostSegue" else { return }
        //let postViewController = segue.destination as? PostViewController
        //postViewController?.post = Post(title: "smth")
    }

}
