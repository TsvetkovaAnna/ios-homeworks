

import UIKit

final class AvatarGestureViewController: UIViewController {

    var customPhoto: UIImage?
    
    init(with photo: UIImage? = nil) {
        customPhoto = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var avatar: UIImageView = {
        let avatar = UIImageView()
        avatar.backgroundColor = .systemGray6
        avatar.image = customPhoto ?? UIImage(named: "Nota")
        avatar.isUserInteractionEnabled = true
        avatar.layer.masksToBounds = true
        avatar.contentMode = .scaleAspectFit
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = UIColor.gray.cgColor
        avatar.translatesAutoresizingMaskIntoConstraints = false
        return avatar
    }()
    
    private var avaHeight: NSLayoutConstraint?
    private var avaWidth: NSLayoutConstraint?
    
    private lazy var chest: UIButton = {
        let chest = UIButton()
        chest.setBackgroundImage(UIImage(systemName: "clear"), for: .normal)
        chest.alpha = 0
        chest.isHidden = true
        chest.backgroundColor = .white
        chest.translatesAutoresizingMaskIntoConstraints = false
        chest.addTarget(self, action: #selector(chestTapped), for: .touchUpInside)
        return chest
    }()
    
    var isExpanded = false
    
    private lazy var avaTapGestureRecognizes = UITapGestureRecognizer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Gestures"
        drawSelf()
        setupGesture()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        view.removeGestureRecognizer(avaTapGestureRecognizes)
    }
    
    private func drawSelf() {
        view.backgroundColor = .white
        view.addSubview(avatar)
        let avaCenterX = avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let avaCenterY = avatar.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        avaHeight = avatar.heightAnchor.constraint(equalToConstant: 200)
        avaWidth = avatar.widthAnchor.constraint(equalToConstant: 200)

        view.addSubview(chest)
        view.bringSubviewToFront(chest)
        let chestTop = chest.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let chestTrailing = chest.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        let chestHeight = chest.heightAnchor.constraint(equalToConstant: 25)
        let chestWidth = chest.widthAnchor.constraint(equalToConstant: 25)
        
        NSLayoutConstraint.activate([avaWidth, avaHeight, avaCenterX, avaCenterY, chestTop, chestTrailing, chestWidth, chestHeight].compactMap({ $0 }))
        
        self.avatar.layer.cornerRadius = avaWidth!.constant/2
    }
    
    private func setupGesture() {
        self.avaTapGestureRecognizes.addTarget(self, action: #selector(self.avaTapped(_:)))
        self.avatar.addGestureRecognizer(self.avaTapGestureRecognizes)
    }
    
    @objc private func avaTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        
        guard avaTapGestureRecognizes === gestureRecognizer else { return }
        self.isExpanded.toggle()
        avaWidth?.constant = view.safeAreaLayoutGuide.layoutFrame.width - 30
        avaHeight?.constant = view.safeAreaLayoutGuide.layoutFrame.height - 30
        avatar.layer.borderWidth = 0
        if self.isExpanded {
            self.chest.isHidden = false
        }
        
        UIView.animate(withDuration: 0.5) {
            self.chest.alpha = self.isExpanded ? 1 : 0
            self.avatar.layer.cornerRadius = 0
            self.avatar.layer.masksToBounds = false
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.chest.isHidden = !self.isExpanded
        }
    }
    
    @objc private func chestTapped() {
        self.isExpanded.toggle()
        self.avaHeight?.constant = 200
        self.avaWidth?.constant = 200
        self.avatar.layer.cornerRadius = 100
        self.avatar.layer.masksToBounds = true

        
        UIView.animate(withDuration: 0.5) {
            self.chest.alpha = self.isExpanded ? 0 : 1
            self.avatar.layer.borderWidth = 3
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.chest.isHidden = !self.isExpanded
        }
    }
}
