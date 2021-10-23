//
//  View+Extension.swift
//  Contacts
//
//  Created by Divyesh Vekariya on 23/10/21.
//

import Foundation
import UIKit

extension UIView {
    func makeMeCircular(withBorderWidth: CGFloat = 0, borderColor: UIColor = UIColor.lightGray) {
        self.clipsToBounds = true
        self.layer.cornerRadius = (self.frame.height) / 2
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = withBorderWidth
    }
}
