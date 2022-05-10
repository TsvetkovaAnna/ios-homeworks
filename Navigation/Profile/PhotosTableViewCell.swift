

import UIKit

protocol PhotosTableViewCellDelegate: AnyObject {
    func showPhotoViewController()
}

class PhotosTableViewCell: UITableViewCell {
    
    weak var delegate: PhotosTableViewCellDelegate?

    static let identifier = "PhotosTableViewCell"
    
    private let defaultCellIdentifier = "DefaultIdentifier"
    
    var photos = [UIImage]()
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        cv.isScrollEnabled = true
        cv.dataSource = self
        cv.delegate = self
        cv.allowsSelection = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAllPhotos)))
        return cv
    }()
    
    @objc func showAllPhotos() {
        delegate?.showPhotoViewController()
    }
    
    private lazy var stackFull: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 12
        return stack
    }()
    
    private lazy var stackLabelButton: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var arrowButton: UIButton = {
        let arrow = UIButton()
        arrow.backgroundColor = .white
        arrow.setBackgroundImage(UIImage(systemName: "arrow.right"), for: .normal)
        arrow.addTarget(self, action: #selector(showAllPhotos), for: .touchUpInside)
        return arrow
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func drawSelf() {

        self.contentView.addSubview(backView)
        let leftBV = backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let rightBV = backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        let topBV = backView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        let bottomBV = backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        
        backView.addSubview(stackLabelButton)
        let leftSL = stackLabelButton.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12)
        let rightSL = stackLabelButton.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -12)
        let topSL = stackLabelButton.topAnchor.constraint(equalTo: backView.topAnchor, constant: 12)
        
        stackLabelButton.addArrangedSubview(label)
        stackLabelButton.addArrangedSubview(arrowButton)
        
        backView.addSubview(collectionView)
        let leftCV = collectionView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12)
        let rightCV = collectionView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -12)
        let topCV = collectionView.topAnchor.constraint(equalTo: stackLabelButton.bottomAnchor, constant: 12)
        let bottomCV = collectionView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -12)
        
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let fullWidth = UIScreen.main.bounds.width
        let imageWidth = (fullWidth - 3*spacing) / 4
        let heightCV = collectionView.heightAnchor.constraint(equalToConstant: imageWidth)

        NSLayoutConstraint.activate([leftBV, rightBV, bottomBV, topBV, leftCV, rightCV,topCV, bottomCV, leftSL, rightSL, topSL, heightCV])
        
        for i in 1...23 {
            if let photo = UIImage(named: "d\(i)") {
                photos.append(photo)
            }
        }
    }
    
    func itemSize(width: CGFloat, spacing: CGFloat) -> CGSize {
        let fullWidth = width - 3*spacing
        let itemWidth = floor(fullWidth/4)//4 items in a collection row
        return CGSize(width: itemWidth, height: itemWidth)
    }

}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("CV Tap")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let width = (collectionView.frame.width - 3*spacing) / 4

        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        returnPhotoCell(collectionView, indexPath)
    }
    
    private func returnPhotoCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else {
            return returnDefaultCell(collectionView, indexPath)
        }
        cell.photoView.image = photos[indexPath.item]
        return cell
    }
    
    private func returnDefaultCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: defaultCellIdentifier, for: indexPath)
    }
}


