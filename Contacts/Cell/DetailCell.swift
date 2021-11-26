//
//  DetailCell.swift
//  Contacts
//
//  Created by Divyesh Vekariya on 23/09/21.
//

import UIKit

class DetailCell: UICollectionViewCell {
    
    static var ID: String { String(describing: Self.self) }
    static var NIB: UINib { .init(nibName: String(describing: Self.self), bundle: .main) }
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var countryCode: UITextField!
    @IBOutlet weak var numberLabel: UITextField!
    @IBOutlet weak var optionImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
