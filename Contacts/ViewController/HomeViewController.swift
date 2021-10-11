//
//  HomeViewController.swift
//  Contacts
//
//  Created by Divyesh Vekariya on 22/09/21.
//

import UIKit

class HomeViewController: UIViewController {

    var viewModel: HomeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        LocalRepository.INSTANCE.saveData(contact: createObject())
    }
    
    func createObject() -> Contact {
        let item = Contact()
        item.lastName = "vekariya"
        item.countryCode = "+91"
        item.mobileNumber = [8980807789, 9999999999]
        item.emails = ["divyesh.v@canopas.com", "123456789@gmail.com"]
        return item
    }
}
