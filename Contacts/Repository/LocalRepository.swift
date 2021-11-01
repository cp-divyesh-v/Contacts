//
//  File.swift
//  Contacts
//
//  Created by Divyesh Vekariya on 27/09/21.
//

import CoreData
import UIKit

class LocalRepository {
    static let INSTANCE = LocalRepository()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
    var context: NSManagedObjectContext!
    
    func openDatabse() -> NSManagedObject {
        context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context)
        let newContact = NSManagedObject(entity: entity!, insertInto: context)
        return newContact
    }
    
    func saveData(contact: ContactModel) {
        context = appDelegate.persistentContainer.viewContext
        let managedObjec = openDatabse()
        
        managedObjec.setValue(contact.id, forKey: "id")
        managedObjec.setValue(contact.firstName, forKey: "firstName")
        managedObjec.setValue(contact.lastName, forKey: "lastName")
        managedObjec.setValue(contact.mobileNumbers, forKey: "mobileNumbers")
        managedObjec.setValue(contact.emails, forKey: "emails")
        managedObjec.setValue(contact.countryCode, forKey: "countryCode")
        managedObjec.setValue(contact.defaultRingtone, forKey: "defaultRingtone")
        managedObjec.setValue(contact.updateAt, forKey: "updatedAt")
        managedObjec.setValue(contact.createdAt, forKey: "createdAt")
        
        print("Storing Data..")
        do {
            context.insert(managedObjec)
            try context.save()
            print("contact with id: \(managedObjec.objectID) have been saved at \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path ?? "it's nil")")
        } catch {
            print("Storing data Failed")
        }
    }
    
    func fetchData(id: String = "") -> Result<[ContactModel], Error> {
        context = appDelegate.persistentContainer.viewContext
        print("Fetching Data..")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        request.returnsObjectsAsFaults = false
        if id != "" {
            request.predicate = NSPredicate(format:"id = %@", id)
            
        }
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            var contacts = [ContactModel]()
            for data in result {
                let id = data.value(forKey: "id") as! String
                let firstName = data.value(forKey: "firstName") as! String
                let lastName = data.value(forKey: "lastName") as! String
                let mobileNumbers = data.value(forKey: "mobileNumbers") as! [Int]
                let emails = data.value(forKey: "emails") as! [String]
                let countryCode = data.value(forKey: "countryCode") as! Int
                let defaultRingtone = data.value(forKey: "defaultRingtone") as! String
                let updatedAt = data.value(forKey: "updatedAt") as! Date
                let createdAt = data.value(forKey: "createdAt") as! Date
                contacts.append(ContactModel(id: id, firstName: firstName, lastName: lastName, mobileNumbers: mobileNumbers, countryCode: countryCode, emails: emails, defaultRingtone: defaultRingtone, updateAt: updatedAt, createdAt: createdAt))
            }
            return .success(contacts)
        } catch {
            print("Fetching contact Failed")
            return .failure(error)
        }
    }
    
    func deleteItem(item: ContactModel) -> Result<ContactModel, Error> {
        context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format:"id = %@", item.id)
        do {
            let result = try context.fetch(request).first as! NSManagedObject
            context.delete(result)
             try context.save()
            return .success(item)
        } catch {
            print("Delete contact Failed")
            return .failure(error)
        }
    }
}
