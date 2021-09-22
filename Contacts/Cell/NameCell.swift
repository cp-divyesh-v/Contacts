//
//  NameCell.swift
//  Contacts
//
//  Created by Divyesh Vekariya on 22/09/21.
//

import UIKit

class NameCell: UITableViewCell {

    @IBOutlet weak var carecterView: UIView!
    @IBOutlet weak var charecterLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
