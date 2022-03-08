//
//  ProfileView.swift
//  Netology_IB_Instruments
//
//  Created by Anna Tsvetkova on 08.03.2022.
//

import UIKit

class ProfileView: UIView {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var myTextView: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let view = self.setupView()
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    private func setupView() -> UIView {
        guard let view = Bundle.main.loadNibNamed("ProfileView", owner: self, options: nil)?.first as? ProfileView else { return UIView() }
        return view
    }
}
