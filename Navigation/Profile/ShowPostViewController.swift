

import UIKit

protocol ShowPostViewControllerDelegate: AnyObject {
    func reloadTableView()
}

class ShowPostViewController: UIViewController {
    
    private let defaultCellIdentifier = "DefaultCell"
    
    private let viewModel: ViewModelProtocol
    
    weak var delegate: ShowPostViewControllerDelegate?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemGray6
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellIdentifier)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        tableView.allowsSelection = true
        return tableView
    }()
    
    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.reloadTableView()
    }
    
    func drawSelf() {
        self.view.addSubview(self.tableView)
        
        let topConstraint = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingConstraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ])
    }

}

extension ShowPostViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        returnPostCell(tableView, indexPath, viewModel: viewModel)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    private func returnPostCell(_ tableView: UITableView, _ indexPath: IndexPath, viewModel: ViewModelProtocol) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
            return returnDefaultCell(tableView, indexPath)
        }
        
        cell.setup(with: viewModel)
        return cell
    }
    
    private func returnDefaultCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: defaultCellIdentifier, for: indexPath)
    }
}
