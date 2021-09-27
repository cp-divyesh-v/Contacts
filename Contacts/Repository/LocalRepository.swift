//
//  File.swift
//  Contacts
//
//  Created by Divyesh Vekariya on 27/09/21.
//

import CoreData
import UIKit

class LocalRepository {
    
    init() {
        openDatabse()
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
    var context: NSManagedObjectContext!

    func openDatabse() -> NSManagedObject {
        context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context)
        let newContact = NSManagedObject(entity: entity!, insertInto: context)
        return newContact
    }
    
    func saveData(managedObjec: NSManagedObject, Contact: ContactModel) {
        managedObjec.setValue(Contact.id, forKey: "id")
        managedObjec.setValue(Contact.firstName, forKey: "firstName")
        managedObjec.setValue(Contact.lastName, forKey: "lastName")
        managedObjec.setValue(Contact.mobileNumber, forKey: "mobileNumber")
        managedObjec.setValue(Contact.emails, forKey: "emails")
        managedObjec.setValue(Contact.countryCode, forKey: "countryCode")
        managedObjec.setValue(Contact.defaultRingTone, forKey: "defaultRingTone")
        managedObjec.setValue(Contact.updateAt, forKey: "updatedAt")
        managedObjec.setValue(Contact.createdAt, forKey: "createdAt")
        
        print("Storing Data..")
        do {
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
                let userName = data.value(forKey: "username") as! String
                let age = data.value(forKey: "age") as! String
                print("User Name is : "+userName+" and Age is : "+age)
            }
        } catch {
            print("Fetching data Failed")
        }
    }
}
