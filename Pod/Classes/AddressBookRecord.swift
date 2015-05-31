//
//  AddressBookRecord.swift
//  Pods
//
//  Created by Aadesh Patel on 5/30/15.
//
//

import AddressBook

/**
    Superclass for all types of records
*/
public class AddressBookRecord: NSObject {
    var record: ABRecord!
    
    /**
        Create AddressBookRecord Instance
    
        :param: record ABRecord of the contact
    */
    init(record: ABRecord) {
        super.init()
        
        self.record = record
    }
}

public struct MultiValue<T> {
    public var id: Int
    public var key: String?
    public var value: T?
    
    init(id: Int, key: String, value: T?) {
        self.id = id
        self.key = key
        self.value = value
    }
}