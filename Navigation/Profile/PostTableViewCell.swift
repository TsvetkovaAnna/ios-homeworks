//
//  DynamicArticleTableViewCell.swift
//  UITableViewProject
//
//  Created by Саидов Тимур on 18.02.2022.
//

import UIKit

protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}

final class PostTableViewCell: UITableViewCell {
    
    struct ViewModel: ViewModelProtocol {
        let author, image, description: String
        var likes, views: Int
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner
        ]
        view.backgroundColor = .white//UIColor(named: "AccentColor") //UIColor(hexString: "4885CC")
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
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
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
        image.contentMode = .scaleAspectFit
        //image.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black//UIColor(named: "AccentColor")
        return image
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
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
    
    private lazy var likes: UILabel = {
        let likes = UILabel()
        likes.text = "Likes: "
        likes.backgroundColor = .clear
        likes.font = UIFont.systemFont(ofSize: 16)
        likes.textColor = .black
        likes.preferredMaxLayoutWidth = self.frame.size.width
        likes.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        //likes.translatesAutoresizingMaskIntoConstraints = false
        return likes
    }()
    
    private lazy var views: UILabel = {
        let views = UILabel()
        views.text = "Views: "
        views.backgroundColor = .clear
        views.font = UIFont.systemFont(ofSize: 16)
        views.textColor = .black
        views.preferredMaxLayoutWidth = self.frame.size.width
        views.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        //views.translatesAutoresizingMaskIntoConstraints = false
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
        
        let backViewConstraints = self.backViewConstraints()
        let stackViewConstraints = self.stackViewConstraints()
        //let authorLabelConstraints = self.authorLabelConstraints()
        //let postImageConstraints = self.postImageConstraints()
        //let descriptionConstraints = self.descriptionConstraints()
        //let stackLikesViewsConstraints = self.stackLikesViewsConstraints()
        //let dateTitleConstraints = self.dateTitleConstraints()
        let imageConstraints = imageConstraints()

        NSLayoutConstraint.activate(backViewConstraints + stackViewConstraints + imageConstraints/* +  authorLabelConstraints + descriptionConstraints + stackLikesViewsConstraints + postImageConstraints + dateTitleConstraints*/)
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
        let leadingConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16)
        let trailingConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)
        let bottomConstraint = self.stackView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -16)

        return [
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ]
    }
    
    private func authorLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = authorLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16)
        let trailingConstraint = authorLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16)
        return [leadingConstraint, trailingConstraint]
    }
    
    private func postImageConstraints() -> [NSLayoutConstraint] {
        let topConstraint = postImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16)
        let leadingConstraint = postImage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor)
        let trailingConstraint = postImage.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        let width = postImage.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1.0)

        return [
            topConstraint, leadingConstraint, trailingConstraint, width
        ]
    }
    
    private func imageConstraints() -> [NSLayoutConstraint] {
        let height = postImage.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0)
//        let centerX = postImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
//        let width = postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0)
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
    
}

extension PostTableViewCell: Setupable {
    
    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
        
        authorLabel.text = viewModel.author
        postImage.image = UIImage(named: viewModel.image)
        descriptionLabel.text = viewModel.description
        //        dateTitle.text = viewModel.publishedAt
        likes.text? += String(viewModel.likes)
        views.text? += String(viewModel.views)
        
    }
}
