//
//  NameCell.swift
//  Contacts
//
//  Created by Divyesh Vekariya on 22/09/21.
//

import UIKit
import RxSwift

class NameCell: UITableViewCell {
    static var ID: String { String(describing: Self.self) }
    static var NIB: UINib { .init(nibName: String(describing: Self.self), bundle: .main) }
    
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
