//
//  HomeViewModel.swift
//  Contacts
//
//  Created by Divyesh Vekariya on 15/09/21.
//

import Foundation
import RxSwift
import RxRelay

class HomeViewModel {
    
    enum Action {
        case selectRow(IndexPath)
        case deleteItemAt(IndexPath)
    }
    
    enum ViewToPresent {
        case showDetail(ContactModel)
    }
    
    // MARK: - Input
    lazy var didActionSubject = PublishSubject<Action>()

    // MARK: - Output
    lazy var shouldPresentSubject = PublishSubject<ViewToPresent>()
    
    var cells: BehaviorSubject<[NameCellModel]> = .init(value: [])

    var contacts: [ContactModel] = [] {
        didSet {
            cells.onNext(prepareCell(contacts: contacts))
        }
    }
    
    override init() {
        super.init()
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
        setUpActionObservers()
    }
    
    func setUpContentChangdObservers() {
        
    }
    
    func prepareCell(contacts: [ContactModel]) -> [NameCellModel] {
        contacts.map({NameCellModel.init(firstName: $0.firstName, lastName: $0.lastName ?? "")})
    }
    
    func setUpActionObservers() {
        self.didActionSubject.asObservable().subscribe(onNext: { [weak self] action in
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
            getContact()
            print("contact have been deleted successfully \(item.id)")
        case .failure(let error):
            print("error \(error) occured while deletting contact \(itemToDelete.id)")
        }
    }
}
