//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Anna Tsvetkova on 12.04.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    var photos = [UIImage]()
    
    private let defaultCellIdentifier = "DefaultIdentifier"
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        return layout
    }()
    
    private lazy var photosCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: defaultCellIdentifier)
        //cv.isScrollEnabled = true
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .systemGray6
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    private func drawSelf() {
        view.backgroundColor = .systemGray6
        title = "Photo Gallery"
        for i in 1...23 {
            if let photo = UIImage(named: "d\(i)") {
                self.photos.append(photo)
            }
        }
        
        view.addSubview(photosCollectionView)
        let top = photosCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        let leading = photosCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8)
        let trailing = photosCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        let bottom = photosCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        
        NSLayoutConstraint.activate([top, bottom, leading, trailing])
    }
    
    private func countItemSize(widthScreen: CGFloat, spasing: CGFloat) -> CGSize {
        let itemWidth = (widthScreen - spasing * 2) / 3 //3 elements in a row
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout/*, UICollectionViewDelegate*/ {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        returnPhotoCell(collectionView, indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize(width: 90, height: 90) }
        let spacing = layout.minimumInteritemSpacing
        return countItemSize(widthScreen: collectionView.frame.width, spasing: spacing)
        
    }
    
    private func returnPhotoCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else {
            return returnDefaultCell(collectionView, indexPath)
        }
        cell.photoView.image = self.photos[indexPath.item]
        return cell
    }
    
    private func returnDefaultCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: defaultCellIdentifier, for: indexPath)
    }
}
