//
//  EmailCheck.swift
//  Navigation
//
//  Created by Anna Tsvetkova on 19.04.2022.
//

import Foundation
import UIKit

let firstPart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
let serverPart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
let emailRegex = firstPart + "@" + serverPart + "[A-Za-z]{2,8}"
let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

extension String {
    func isEmail() -> Bool {
        emailPredicate.evaluate(with: self)
    }
}

extension UITextField {
    func isEmail() -> Bool {
        self.text?.isEmail() ?? false
    }
}
