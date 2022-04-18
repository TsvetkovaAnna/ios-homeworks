//
//  AvatarGestureViewController.swift
//  Navigation
//
//  Created by Anna Tsvetkova on 12.04.2022.
//

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
        //avatar.layer.cornerRadius = 50//avatar.bounds.width/2//50
        avatar.layer.masksToBounds = true // commented
        avatar.contentMode = .scaleAspectFit
        //avatar.addGestureRecognizer(avaTapGestureRecognizes)
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = UIColor.gray.cgColor
        avatar.translatesAutoresizingMaskIntoConstraints = false
        return avatar
    }()
    
    private var avaHeight: NSLayoutConstraint?
    private var avaWidth: NSLayoutConstraint?
    
    private lazy var chest: UIButton = {
        let chest = UIButton()
        chest.setBackgroundImage(UIImage(systemName: "clear"), for: .normal)//UIImageView(image: UIImage(systemName: "clear"))
        chest.alpha = 0
        chest.isHidden = true
        chest.backgroundColor = .white
        chest.translatesAutoresizingMaskIntoConstraints = false
        chest.addTarget(self, action: #selector(chestTapped), for: .touchUpInside)//addGestureRecognizer(chestTapGestureRecognizer)
        return chest
    }()
    
    var isExpanded = false
    
    private lazy var avaTapGestureRecognizes = UITapGestureRecognizer()
    //private lazy var chestTapGestureRecognizer = UITapGestureRecognizer()
    
    
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
//        avaHeight = avatar.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: -30)
//        avaWidth = avatar.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -30)
        
        view.addSubview(chest)
        view.bringSubviewToFront(chest)
//        let chestTop = chest.topAnchor.constraint(equalTo: avatar.topAnchor)
//        let chestTrailing = chest.trailingAnchor.constraint(equalTo: avatar.trailingAnchor)
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
        //chestTapGestureRecognizer.addTarget(self, action: #selector(chestTapped))
    }
    
    @objc private func avaTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        guard avaTapGestureRecognizes === gestureRecognizer else { return }
        self.isExpanded.toggle()
        //let screenWidth = view.safeAreaLayoutGuide.widthAnchor
        avaWidth?.constant = view.safeAreaLayoutGuide.layoutFrame.width - 30//isExpanded ? view.safeAreaLayoutGuide.layoutFrame.width - 30 : 100
        //self.avaWidth?.constant = self.isExpanded ? 300 : 200
        avaHeight?.constant = view.safeAreaLayoutGuide.layoutFrame.height - 30//isExpanded ? view.safeAreaLayoutGuide.layoutFrame.height - 30 : 100
        //self.avaHeight?.constant = self.isExpanded ? 300 : 200
        avatar.layer.borderWidth = 0
        if self.isExpanded {
            self.chest.isHidden = false
        }
        
        UIView.animate(withDuration: 0.5) {
            self.chest.alpha = self.isExpanded ? 1 : 0
            self.avatar.layer.cornerRadius = 0
            //self.avatar.layer.borderWidth = 3
            self.avatar.layer.masksToBounds = false
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.chest.isHidden = !self.isExpanded
        }
    }
    
    @objc private func chestTapped() {//(_ gestureRecognizer: UITapGestureRecognizer) {
        self.isExpanded.toggle()
//        self.avaWidth?.constant = !isExpanded ? view.safeAreaLayoutGuide.layoutFrame.width - 30 : 100
//        self.avaHeight?.constant = !isExpanded ? view.safeAreaLayoutGuide.layoutFrame.height - 30 : 100
        self.avaHeight?.constant = 200//self.isExpanded ? 200 : 300
        self.avaWidth?.constant = 200//self.isExpanded ? 200 : 300
        self.avatar.layer.cornerRadius = 100//self.avatar.bounds.width/2
        self.avatar.layer.masksToBounds = true
//        if isExpanded {
//            chest.isHidden = false
//        }
        
        UIView.animate(withDuration: 0.5) {
            self.chest.alpha = self.isExpanded ? 0 : 1
            self.avatar.layer.borderWidth = 3
            //self.avatar.layer.borderColor = .gre
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.chest.isHidden = !self.isExpanded
        }
    }
}
