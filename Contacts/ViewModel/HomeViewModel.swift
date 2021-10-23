//
//  HomeViewModel.swift
//  Contacts
//
//  Created by Divyesh Vekariya on 15/09/21.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    let contacts: BehaviorSubject<[ContactModel]> = .init(value: [])
    
    init() {
        setUpRxObservers()
        getContact()
    }
    
    func getContact() {
        let result = LocalRepository.INSTANCE.fetchData()
        
        switch result {
        case .success(let contact):
            contacts.onNext(contact)
        case .failure(let error):
            print("Error occured while fetching contacts from local data base and error is \(error)")
        }
    }
    
    func setUpRxObservers() {
        setUpContentChangdObservers()
    }
    
    func setUpContentChangdObservers() {
    }
    
    func prepareCell() {
        
    }
}
