//
//  ViewController.swift
//  AddressBookManager
//
//  Created by aadesh on 05/30/2015.
//  Copyright (c) 05/30/2015 aadesh. All rights reserved.
//

import UIKit
import AddressBookManager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var abm: AddressBookManager? = AddressBookManager()
        /*abm?.retrieveAllContactsInQueue(dispatch_get_main_queue(),
            sort: { $0.firstName < $1.firstName },
            filter: { count($0.emails!) > 0 },
            completion: { (contacts: [AddressBookPerson]?, error: CFError?) -> Void in
                for contact: AddressBookPerson in contacts! {
                    println(contact.firstName!)
                }
        })*/
        
        /*abm?.requestAuthorizationWithCompletion({ (granted: Bool, error: CFError?) -> Void in
            abm?.allContacts
        })*/
        
        abm?.requestAuthorizationWithCompletion { (granted: Bool, error: CFError?) -> Void in
            var person = AddressBookPerson()
            person.firstName = "Bob"
            person.lastName = "Smith"
            
            var personalEmail = MultiValue(id: 0, key: "personal", value: "bob@mail.com")
            person.emails = [personalEmail]
            
            var homePhoneNumber = MultiValue(id: 0, key: "home", value: "5555555555")
            var mobilePhoneNumber = MultiValue(id: 1, key: "mobile", value: "1234567890")
            person.phoneNumbers = [homePhoneNumber, mobilePhoneNumber]
            
            //person.profilePicture = UIImage(named: "bob.png")
            
            var homeAddress = Dictionary<AddressProperty, AnyObject>()
            homeAddress[AddressProperty.Street] = "123 Maple Street"
            homeAddress[AddressProperty.City] = "Miami"
            homeAddress[AddressProperty.State] = "FL"
            homeAddress[AddressProperty.ZipCode] = "00000"
            homeAddress[AddressProperty.Country] = "USA"
            
            var homeAddressValue = MultiValue(id: 0, key: "home", value: homeAddress)
            person.addresses = [homeAddressValue]
            
            var dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let birthday: NSDate? = dateFormatter.dateFromString("01/01/1970")
            person.birthday = birthday
            
            person.organization = "Some Huge Organization"
            person.jobTitle = "Developer"
            person.department = "Software"
            person.note = "Some Note Here"
            
            var personalURL = MultiValue(id: 0, key: "personal", value: "https://somewebsite")
            person.urls = [personalURL]
            
            person.prefix = "Mr"
            person.suffix = "Jr"
            person.middleName = "Roger"
            
            var anniversaryDate = MultiValue(id: 0, key: "anniversary", value: dateFormatter.dateFromString("02/02/2000"))
            person.dates = [anniversaryDate]
            
            abm?.addRecord(person)
            abm?.save()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

