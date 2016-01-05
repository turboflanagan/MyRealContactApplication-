//
//  DataManager.swift
//  MyRealContactApplication
//
//  Created by MacBook Pro on 12/21/15.
//  Copyright © 2015 Peter Flanagan. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    
    static let sharedManager : DataManager = DataManager()
    
    let coreDataManager : CoreDataManager = CoreDataManager()
    
    func loadContacts() -> [Contact]? {
        let query = NSFetchRequest(entityName: "Contact")
        
        let sort = NSSortDescriptor(key: "firstName", ascending: true)
        
        query.sortDescriptors = [sort]
        
        do {
            if let results = try self.coreDataManager.context.executeFetchRequest(query) as? [Contact]{
            return results
            }
        } catch {
            print("Failed to query Contacts: \(error)")
        }
        return [Contact]()
    }
    
    
    func save() {
        do {
            try self.coreDataManager.context.save()
        }
        catch {
            print("Failed to save context: \(error)")
        }
    }
    
    
    func createContact() -> Contact {
        let contact = NSEntityDescription.insertNewObjectForEntityForName("Contact", inManagedObjectContext: coreDataManager.context) as? Contact
        let address = NSEntityDescription.insertNewObjectForEntityForName("Address", inManagedObjectContext: coreDataManager.context) as? Address
    
        contact?.address = address
        return contact!
    }
    
    
    func getContact(contactId contactId:Int) -> Contact? {
        let query = NSFetchRequest(entityName: "Contact")
        
        let filter = NSPredicate(format: "contactId = %@", String(contactId))
        
      
        query.predicate = filter
        
        do {
            if let results = try self.coreDataManager.context.executeFetchRequest(query) as? [Contact] {
                if results.count > 0 {
                    return results[0]
                }
            }
        }
        catch {
            print("Failed to query for contact: \(error)")
        }
        return nil
        
    }
}








