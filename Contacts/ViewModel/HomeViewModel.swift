//
//  HomeViewModel.swift
//  Contacts
//
//  Created by Divyesh Vekariya on 15/09/21.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    let disposeBag = DisposeBag()
    
    let cells: BehaviorSubject<[NameCellModel]> = .init(value: [])
   
    // MARK: - Input
    let didActionSubject = PublishSubject<Action>()
    enum Action {
        case selectRow(IndexPath)
        case deleteItemAt(IndexPath)
    }
    // MARK: - Output
    let shouldPresentSubject = PublishSubject<ViewToPresent>()
    enum ViewToPresent {
        case showDetail(ContactModel)
    }

    var contacts: [ContactModel] {
        didSet {
            cells.onNext(prepareCell(contacts: contacts))
        }
    }
    
    init() {
        setUpRxObservers()
        getContact()
    }
    
    func getContact() {
        let result = LocalRepository.INSTANCE.fetchData()
        
        switch result {
        case .success(let contact):
            contacts = contact
        case .failure(let error):
            print("Error occured while fetching contacts from local data base and error is \(error)")
        }
    }
    
    func setUpRxObservers() {
        setUpContentChangdObservers()
    }
    
    func setUpContentChangdObservers() {
        
    }
    
    func prepareCell(contacts: [ContactModel]) -> [NameCellModel] {
        contacts.map({NameCellModel.init(firstName: $0.firstName, lastName: $0.lastName)})
    }
    
    func setUpActionObservers() {
        didActionSubject.asObserver().subscribe(onNext: { [weak self] action in
            switch action {
            case .deleteItemAt(let indexPath):
                self?.deleteItemAt(index: indexPath)
            case .selectRow(let indexPath):
                self?.shouldPresentSubject.onNext(.showDetail((self?.contacts[indexPath.row])!))
            }
        }) .disposed(by: disposeBag)
    }
    
    func deleteItemAt(index: IndexPath) {
        
    }
}
