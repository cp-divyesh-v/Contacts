//
//  HomeViewController.swift
//  Contacts
//
//  Created by Divyesh Vekariya on 22/09/21.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNew: UIButton!
    
    var viewModel: HomeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRxObservers()
        LocalRepository.INSTANCE.saveData(contact: createObject())
        
        
    }
    
    func createObject() -> ContactModel {
        let item = ContactModel(id: UUID().uuidString, firstName: "divyesh", lastName: "Vekariya", mobileNumbers: [8980807789, 9999999999], countryCode: 91, emails: ["divyesh.v@canopas.com", "123456789@gmail.com"], defaultRingtone: "tere liye", updateAt: Date(), createdAt: Date())

        return item
    }
    
    func setUpRxObservers() {
        
    }
    
    func setUpContentChangdObservers() {
        viewModel.contacts.asObserver().subscribe(onNext: { [weak self] contat in
            
        })
    }
}
