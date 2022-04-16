//
//  MarginLabel.swift
//  Navigation
//
//  Created by Anna Tsvetkova on 12.04.2022.
//

import UIKit

class MarginLabel: UILabel {

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        super.drawText(in: rect.inset(by: insets))
    }
}
