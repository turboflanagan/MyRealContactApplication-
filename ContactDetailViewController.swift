//
//  ContactDetailViewController.swift
//  Contacts App
//
//  Created by MacBook Pro on 11/9/15.
//  Copyright © 2015 Peter Flanagan. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController, NewContactDelegate {
    
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    @IBOutlet weak var streetAddress: UILabel!
    
    @IBOutlet weak var city: UILabel!
    
    
    @IBOutlet weak var state: UILabel!
    
    @IBOutlet weak var zipCode: UILabel!
    
    
    var selectedContact : Contact!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        self.firstName.text = self.selectedContact.firstName
        self.lastName.text = self.selectedContact.lastName
        self.phoneNumber.text = self.selectedContact.phoneNumber
        self.streetAddress.text = self.selectedContact.address?.street
        self.city.text = self.selectedContact.address?.city
        self.state.text = self.selectedContact.address?.state
        self.zipCode.text = self.selectedContact.address?.zipCode

        // Do any additional setup after loading the view.
    }
    
    func didUpdateContact(contact: Contact) {
        self.selectedContact = contact
        self.updateTextFields()
    }
    
    func updateTextFields() {
        self.firstName.text = self.selectedContact?.firstName
        self.lastName.text = self.selectedContact?.lastName
        self.phoneNumber.text = self.selectedContact?.phoneNumber
        self.streetAddress.text = self.selectedContact?.address?.street
        self.city.text = self.selectedContact?.address?.city
        self.state.text = self.selectedContact?.address?.state
        self.zipCode.text = self.selectedContact?.address?.zipCode
    }
    
    func didCreateNewContact(newContact: Contact) {
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditContactSegue" {
            if let vc = segue.destinationViewController as? NewContactViewController {
                vc.delegate = self
                vc.editedContact = self.selectedContact
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    */

}
