//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Anna Tsvetkova on 15.03.2022.
//

import UIKit

protocol ProfileHeaderViewDelegate: AnyObject {
    func statusButtonPressed(isTextFieldVisible: Bool, completion: @escaping () -> Void)
}

class ProfileViewController: UIViewController {
    
    var tableHeaderViewHeight: CGFloat = 230
//   // lazy var profileHeaderView: = ProfileHeaderView()
//
    //var heightHeaderConstraint: NSLayoutConstraint?
//    private lazy var downButton: UIButton = {
//        let downButton = UIButton()
//        downButton.backgroundColor = .systemCyan
//        downButton.setTitle("Just Button", for: .normal)
//        downButton.translatesAutoresizingMaskIntoConstraints = false
//        return downButton
//    }()
//
    
    private let defaultCellIdentifier = "DefaultCell"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        //tableView.style = .grouped
        tableView.backgroundColor = .systemGray6
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellIdentifier)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        tableView.allowsSelection = true
        //tableView.estimatedRowHeight = 55
        return tableView
    }()
    
    private lazy var jsonDecoder = JSONDecoder()
    
    private var dataSource: [News.Article] = []
    
    private lazy var tableHeaderView: ProfileHeaderView = {
        let tableHeaderView = ProfileHeaderView(frame: .zero)
        tableHeaderView.delegate = self
        //tableHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return tableHeaderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        fetchArticles { [weak self] articles in
            self?.dataSource = articles
            self?.tableView.reloadData()
        }
        //tableView.tableHeaderView = tableHeaderView
        setupNavigationBar()
        setupView()
        tapGesture()
        setupProfileHeaderView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //updateProfileHeaderView(for: tableView.tableHeaderView)
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Profile"
    }
    
    private func setupProfileHeaderView() {
        self.view.backgroundColor = .systemGray6
//        let leadingConstraint = tableHeaderView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor)
//        let trailingConstraint = tableHeaderView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor)
//        let topConstraint = tableHeaderView.topAnchor.constraint(equalTo: tableView.topAnchor)
//        heightHeaderConstraint = tableHeaderView.heightAnchor.constraint(equalToConstant: 220)
//        let widthConstraint = tableHeaderView.widthAnchor.constraint(equalTo: tableView.widthAnchor)
//        let bottomConstraint = tableHeaderView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        
        
        //NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, heightHeaderConstraint, widthConstraint,bottomConstraint].compactMap({ $0 }))
    }
    
//    private func updateProfileHeaderView(for header: UIView?) {
//        guard let header = header else { return }
//        header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: view.bounds.width, height: CGFloat(heightHeaderConstraint!.constant))).height
//    }
    
    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupView() {
        //self.view.backgroundColor = .systemGray6
        self.view.addSubview(self.tableView)
        
        let topConstraint = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingConstraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ])
    }
    
    private func fetchArticles(completion: @escaping ([News.Article]) -> Void) {
        if let path = Bundle.main.path(forResource: "news", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
//                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let news = try self.jsonDecoder.decode(News.self, from: data)
                print("json data: \(news)")
                completion(news.articles)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            fatalError("Invalid filename/path.")
        }
    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .lightGray
//        navigationController?.navigationBar.isHidden = false
//        title = "Profile"
//        setupHeaderView()
//        setupDownButton()
//    }
//
//    private func setupDownButton() {
//        view.addSubview(downButton)
//        let downButtonBottom = downButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        let downButtonLeading = downButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
//        let downButtonTrailing = downButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
//        let downButtonHeight = downButton.heightAnchor.constraint(equalToConstant: 50)
//        NSLayoutConstraint.activate([downButtonBottom, downButtonHeight, downButtonLeading, downButtonTrailing])
//    }
//
//    private func setupHeaderView() {
//        view.addSubview(profileHeaderView)
//        let leadingConstraint = profileHeaderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
//        let trailingConstraint = profileHeaderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
//        let topConstraint = profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
//        heightHeaderConstraint = profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
//
//        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, heightHeaderConstraint].compactMap({ $0 }))
//    }
////    override func viewWillLayoutSubviews() {
////        profileHeaderView.frame = view.bounds
////    }

}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        indexPath.section == 0 ? 70 : 200
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? tableHeaderViewHeight : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        section == 0 ? tableHeaderView : nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : self.dataSource.count
        //return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("TV TAp")
        
        if indexPath.row == 0 {
            let photoVC = PhotosViewController()
            navigationController?.pushViewController(photoVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return returnPhotoCell(tableView, indexPath)
        case 1:
            return returnPostCell(tableView, indexPath)
        default:
            return returnDefaultCell(tableView, indexPath)
        }
    }
    
    private func returnPostCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
            return returnDefaultCell(tableView, indexPath)
        }
        let post = dataSource[indexPath.row]
        let viewModel = PostTableViewCell.ViewModel(author: post.author, image: post.image, description: post.description,/* publishedAt: post.publishedAtString, */ likes: post.likes, views: post.views)
        cell.setup(with: viewModel)
        return cell
    }
    
    private func returnPhotoCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as? PhotosTableViewCell else {
            return returnDefaultCell(tableView, indexPath)
        }
        cell.delegate = self
        return cell
    }
    
    private func returnDefaultCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: defaultCellIdentifier, for: indexPath)
    }
}

extension ProfileViewController: ProfileHeaderViewDelegate {
    func statusButtonPressed(isTextFieldVisible: Bool, completion: @escaping () -> Void) {
        //heightHeaderConstraint?.constant = isTextFieldVisible ? 220 : 174
        tableHeaderViewHeight = isTextFieldVisible ? 230 : 190 //174
//        tableView.beginUpdates()
        //tableView.reloadSections(IndexSet(0..<1), with: .automatic)
//        tableView.endUpdates()
        UIView.animate(withDuration: 0.3) {
            self.tableView.beginUpdates()
            self.view.layoutIfNeeded()
            self.tableView.endUpdates()
        } completion: { _ in
            completion()
        }
    }
}

extension ProfileViewController: PhotosTableViewCellDelegate {
    func showPhotoViewController() {
        let photoVC = PhotosViewController()
        navigationController?.pushViewController(photoVC, animated: true)
    }
}
