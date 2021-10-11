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
    
    func saveData(contact: Contact) {
        let managedObjec = openDatabse()
        
        managedObjec.setValue(contact.id, forKey: "id")
        managedObjec.setValue(contact.firstName, forKey: "firstName")
        managedObjec.setValue(contact.lastName, forKey: "lastName")
        managedObjec.setValue(contact.mobileNumber, forKey: "mobileNumber")
        managedObjec.setValue(contact.emails, forKey: "emails")
        managedObjec.setValue(contact.countryCode, forKey: "countryCode")
        managedObjec.setValue(contact.defaultRingTone, forKey: "defaultRingTone")
        managedObjec.setValue(contact.updateAt, forKey: "updatedAt")
        managedObjec.setValue(contact.createdAt, forKey: "createdAt")
        
        print("Storing Data..")
        do {
            context.insert(managedObjec)
            try context.save()
        } catch {
            print("Storing data Failed")
        }
    }
    
    func fetchData() {
        print("Fetching Data..")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let userName = data.value(forKey: "firstName") as! String
                let age = data.value(forKey: "age") as! String
                print("User Name is : "+userName+" and Age is : "+age)
            }
        } catch {
            print("Fetching data Failed")
        }
    }
}
