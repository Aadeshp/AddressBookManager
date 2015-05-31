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
        
        var abm: AddressBookManager = AddressBookManager()
        abm.retrieveAllContactsInQueue(dispatch_get_main_queue(),
            sort: { $0.firstName > $1.firstName },
            filter: nil,
            completion: { (contacts: [AddressBookPerson]?, error: CFError?) -> Void in
                for contact: AddressBookPerson in contacts! {
                    println(contact.firstName!)
                }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

