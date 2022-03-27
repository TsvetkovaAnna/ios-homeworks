//
//  RoundedButton.swift
//  Navigation
//
//  Created by Anna Tsvetkova on 27.03.2022.
//

import UIKit

class RoundedButton: UIButton {

    init(cornerRadius: CGFloat) {
        super.init(frame: .zero)
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
