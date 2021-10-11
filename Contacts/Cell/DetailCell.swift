//
//  DetailCell.swift
//  Contacts
//
//  Created by Divyesh Vekariya on 23/09/21.
//

import UIKit

class DetailCell: UICollectionViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var countryCode: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var optionImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
