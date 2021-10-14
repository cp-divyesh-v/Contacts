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
    
    func createObject() -> ContactModel {
        let item = ContactModel(id: UUID().uuidString, firstName: "divyesh", lastName: "Vekariya", mobileNumbers: [8980807789, 9999999999], countryCode: 91, emails: ["divyesh.v@canopas.com", "123456789@gmail.com"], defaultRingtone: "tere liye", updateAt: Date(), createdAt: Date())

        return item
    }
}
