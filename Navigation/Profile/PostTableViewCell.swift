

import UIKit

protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}

protocol PostTableViewCellDelegate: AnyObject {
    func openFullPost(viewModel: ViewModelProtocol)
}

final class PostTableViewCell: UITableViewCell {
    
    weak var delegate: PostTableViewCellDelegate?
    
    var viewModel: ViewModel?
    
    var isPhotoInteractionEnabled = false {
        didSet {
            postImage.isUserInteractionEnabled = isPhotoInteractionEnabled
        }
    }
    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner
        ]
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var authorLabel: MarginLabel = {
        let label = MarginLabel()
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = false
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openPost)))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        return image
    }()

    private lazy var descriptionLabel: MarginLabel = {
        let label = MarginLabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        label.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackLikesViews: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var likes: MarginLabel = {
        let likes = MarginLabel()
        likes.backgroundColor = .clear
        likes.font = UIFont.systemFont(ofSize: 16)
        likes.textColor = .black
        likes.isUserInteractionEnabled = true
        likes.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(putLike)))
        likes.preferredMaxLayoutWidth = self.frame.size.width
        likes.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        return likes
    }()
    
    private lazy var views: MarginLabel = {
        let views = MarginLabel()
        views.textAlignment = .right
        views.backgroundColor = .clear
        views.font = UIFont.systemFont(ofSize: 16)
        views.textColor = .black
        views.preferredMaxLayoutWidth = self.frame.size.width
        views.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        return views
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        authorLabel.text = ""
        descriptionLabel.text = ""
        postImage.image = nil
        likes.text = "Likes: "
        views.text = "Views: "
    }
    
    private func setupView() {
        contentView.backgroundColor = .systemGray6

        contentView.addSubview(backView)
        backView.addSubview(stackView)
        stackView.addArrangedSubview(authorLabel)
        stackView.addArrangedSubview(postImage)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(stackLikesViews)
        stackLikesViews.addArrangedSubview(likes)
        stackLikesViews.addArrangedSubview(views)
    
        stackView.isLayoutMarginsRelativeArrangement = true
        
        let backViewConstraints = self.backViewConstraints()
        let stackViewConstraints = self.stackViewConstraints()
        
        let imageConstraints = imageConstraints()

        let labelConstraints = [likes.widthAnchor.constraint(equalToConstant: 130), views.widthAnchor.constraint(equalToConstant: 130)]
        
        NSLayoutConstraint.activate(backViewConstraints + stackViewConstraints + imageConstraints + labelConstraints)
    }
    
    private func backViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.backView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        let leadingConstraint = self.backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let trailingConstraint = self.backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        let bottomConstraint = self.backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)

        return [
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ]
    }
    
    private func stackViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.stackView.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 16)
        let leadingConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 0)
        let trailingConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: 0)
        let bottomConstraint = self.stackView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -16)

        return [
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ]
    }
    
    private func imageConstraints() -> [NSLayoutConstraint] {
        let height = postImage.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0)
        return [ height ]
    }
    
    private func descriptionConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = descriptionLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16)
        let trailingConstraint = descriptionLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16)
        return [leadingConstraint, trailingConstraint]
    }
    
    private func stackLikesViewsConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = stackLikesViews.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16)
        let trailingConstraint = stackLikesViews.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16)
        return [leadingConstraint, trailingConstraint]
    }
    
    @objc private func openPost() {
        print(#function)
        guard let viewModel = viewModel else { return }
        CoreDataManager().addViewsToPost(post: viewModel)
        delegate?.openFullPost(viewModel: viewModel)
        setViewsText(CoreDataManager().showViewsInPost(post: viewModel) ?? viewModel.views)
    }
    
    @objc private func putLike() {
        guard let viewModel = viewModel else { return }
        CoreDataManager().addLikeToPost(post: viewModel)
        setLikesText(CoreDataManager().showLikesInPost(post: viewModel) ?? viewModel.likes)
    }
}


extension PostTableViewCell: Setupable {
    
    func setup(with viewModel: ViewModelProtocol) {
        guard var viewModel = viewModel as? ViewModel else { return }
        self.viewModel = viewModel
        viewModel.likes = CoreDataManager().showLikesInPost(post: viewModel) ?? viewModel.likes
        viewModel.views = CoreDataManager().showViewsInPost(post: viewModel) ?? viewModel.views
        authorLabel.text = viewModel.author
        postImage.image = UIImage(named: viewModel.image)
        descriptionLabel.text = viewModel.description
        setLikesText(viewModel.likes)
        setViewsText(viewModel.views)
        
    }
    
    func setLikesText(_ number: Int) {
        likes.text = "Likes: " + String(number)
    }
    
    func setViewsText(_ number: Int) {
        views.text = "Views: " + String(number)
    }
}
