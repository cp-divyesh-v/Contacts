//
//  DetailViewController.swift
//  Contacts
//
//  Created by Divyesh Vekariya on 03/09/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var firstCherecterLabel: UILabel!
    @IBOutlet weak var cherecterContainter: UIView!
    
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
