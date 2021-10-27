//
//  HomeViewModel.swift
//  Contacts
//
//  Created by Divyesh Vekariya on 15/09/21.
//

import Foundation
import RxSwift

class HomeViewModel {
    
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
    
    var cells: BehaviorSubject<[NameCellModel]> = .init(value: [])

    var contacts: [ContactModel] = [] {
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
//        setUpContentChangdObservers()
//        setUpActionObservers()
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
        }) .disposed(by: DisposeBag())
    }
    
    func deleteItemAt(index: IndexPath) {
        let itemToDelete = contacts.remove(at: index.row)
        let result = LocalRepository.INSTANCE.deleteItem(item: itemToDelete)
        switch result {
        case .success(let item):
            print("contact have been deleted successfully \(item.id)")
        case .failure(let error):
            print("error \(error) occured while deletting contact \(itemToDelete.id)")
        }
    }
}
