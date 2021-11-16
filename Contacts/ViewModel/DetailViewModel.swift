//
//  DetailViewModel.swift
//  Contacts
//
//  Created by Divyesh Vekariya on 15/09/21.
//

import Foundation
import RxSwift
import RxRelay

class DetailViewModel {
    
    enum Action {
        case edit
        case addPresed
    }
    
    enum ViewToPresent {
        case showEditView
    }
    
    lazy var didActionSubject = PublishSubject<Action>()
    lazy var shouldPresentSubject = PublishSubject<ViewToPresent>()
    
    let number: BehaviorRelay<[Int]>
    let fisrtName: BehaviorRelay<String>
    let lastName: BehaviorRelay<String?>
    let countryCode: BehaviorRelay<String>
    let defaultRingTone: BehaviorRelay<String?>
    let email: BehaviorRelay<[String]>
    
    init(contact: ContactModel) {
        self.number = .init(value: contact.mobileNumbers)
        self.fisrtName = .init(value: contact.firstName)
        self.lastName = .init(value: contact.lastName)
        self.countryCode = .init(value: String("+\(contact.countryCode)"))
        self.defaultRingTone = .init(value: contact.defaultRingtone)
        self.email = .init(value: contact.emails ?? [])
    }
}
