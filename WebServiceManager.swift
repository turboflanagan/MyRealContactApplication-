//
//  WebServiceManager.swift
//  Contacts App
//
//  Created by MacBook Pro on 11/16/15.
//  Copyright © 2015 Peter Flanagan. All rights reserved.
//

import Foundation


struct WebServiceManager {
    
    func fetchContacts(callback : ([Contact]) -> Void) {
        
        let url = NSURL(string:
            "http://jsonplaceholder.typicode.com/users")
        let request = NSURLRequest(URL: url!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {data, response, err in
            
            if err == nil {
                var contactList = [Contact]()
                
                do {
                    if let jsonArray : [ [String : AnyObject] ] = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? [ [String:AnyObject] ] {
                        dispatch_async(dispatch_get_main_queue(), {
                            //Processing code goes here
                            for jsonDict in jsonArray {
                                let newContact = self.parseContact(jsonDict)
                                contactList.append(newContact)
                            }
                            callback(contactList)
                        })
                    }
                }
                catch {
                    callback([])
                }
            }
            else {
                print("Got an error: \(err)")
            }
        }
        task.resume()
    }
    private func parseContact(jsonDict : [String:AnyObject]) -> Contact {
        let newContact = DataManager.sharedManager.createContact()
        newContact.phoneNumber = jsonDict["phone"] as? String
        
        if let addressDict = jsonDict["address"] as? [String : AnyObject] {
            newContact.address?.street = addressDict["street"] as? String
            newContact.address?.city = addressDict["city"] as? String
            newContact.address?.zipCode = addressDict["zipcode"] as? String
            //Use the properties of addressDict here
        }
        if let fullName = jsonDict["name"] as? String {
            let fullNameArray = fullName.componentsSeparatedByString(" ")
            
            if fullNameArray.count > 1 {
                newContact.firstName = fullNameArray[0]
                newContact.lastName = fullNameArray[1]
                
            }
        }
        // Save the id as a string instead of a number so we are free to use UUID's as is's to ensure uniqueness when we create new contacts.
        if let contactId = jsonDict["id"] as? NSNumber {            
            newContact.contactId = (contactId)
        }
        
        return newContact
    }
}



















