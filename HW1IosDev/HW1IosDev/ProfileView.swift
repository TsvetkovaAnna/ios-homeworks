//
//  ProfileView.swift
//  HW1IosDev
//
//  Created by Anna Tsvetkova on 10.03.2022.
//

import UIKit

class ProfileView: UIView {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var XibTextView: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let view = self.setupView()
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    private func setupView() -> UIView {
        guard let view = Bundle.main.loadNibNamed("ProfileView", owner: self, options: nil)?.first as? UIView else { return UIView() }
        return view
    }
}
