//
//  ContactModel.swift
//  Contacts
//
//  Created by Divyesh Vekariya on 08/09/21.
//

import Foundation
 

struct ContactModel {
    let id: String
    let firstName: String
    let lastName: String?
    let mobileNumbers: [Int]
    let countryCode: Int
    let emails: [String]?
    let defaultRingtone: String?
    let updateAt: Date
    let createdAt: Date
}

struct AddressModel {
    let postalCode: Int?
    let street: String?
    let state: String?
    let country: String?
}
