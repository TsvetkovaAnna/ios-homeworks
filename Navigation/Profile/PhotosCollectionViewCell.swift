
import UIKit

protocol PhotosCollectionViewCellDelegate: AnyObject {
    func openPhotoFullScreen(_ image: UIImage?)
}

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var delegate: PhotosCollectionViewCellDelegate?
    
    static let identifier = "PhotosCollectionViewCell"
    
    private let defaultCellIdentifier = "DefaultIdentifier"
    
    var image: UIImage?
    
    var indexCell: IndexPath?
    
    var isPhotoInteractionEnabled = false {
        didSet {
            photoView.isUserInteractionEnabled = isPhotoInteractionEnabled
        }
    }
    
    lazy var photoView: UIImageView = {
        let photoView = UIImageView()
        photoView.layer.cornerRadius = 6
        photoView.clipsToBounds = true
        photoView.backgroundColor = .white
        photoView.contentMode = .scaleAspectFill
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(photoViewTapped)))
        return photoView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
        
    }
    
    private func drawSelf() {
        self.contentView.addSubview(photoView)
        let left = photoView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        let right = photoView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        let top = photoView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        let bottom = photoView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([left, right, bottom, top])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func photoViewTapped() {
        print(#function)
        delegate?.openPhotoFullScreen(photoView.image)
    }
}
