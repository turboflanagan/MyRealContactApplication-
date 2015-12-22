//
//  CoreDataManager.swift
//  MyRealContactApplication
//
//  Created by MacBook Pro on 12/21/15.
//  Copyright © 2015 Peter Flanagan. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    lazy var managedModel : NSManagedObjectModel = {
        
        let modelURL = NSBundle.mainBundle().URLForResource("Contacts", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var coordinator : NSPersistentStoreCoordinator = {
        let applicationUrls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let applicationUrl = applicationUrls[applicationUrls.count-1]
        let url = applicationUrl.URLByAppendingPathComponent("Contacts.sqlite")
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedModel)
        
        var failureReason = "There was an error creating or loading the application's saved data."
        
        do {
            
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
            
        } catch {
            
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var context : NSManagedObjectContext = {
        
        let coordinator = self.coordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
}












