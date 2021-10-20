//
//  NameCellModel.swift
//  Contacts
//
//  Created by Divyesh Vekariya on 15/09/21.
//

import Foundation
import RxSwift

class NameCellModel {
   
    let name: BehaviorSubject<String>
    let carecter: BehaviorSubject<String>
    
    init(firstName: String, lastName: String) {
        self.name = .init(value: "\(firstName) \(lastName)")
    }
    
}
