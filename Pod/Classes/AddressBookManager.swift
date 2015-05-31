//
//  AddressBookManager.swift
//  Pods
//
//  Created by Aadesh Patel on 5/30/15.
//
//

import Foundation
import UIKit
import AddressBook

//public let addressBookManager: AddressBookManager? = AddressBookManager()

public class AddressBookManager: NSObject {
    /// Global instance of AddressBookManager
    public var addressBook: ABAddressBook!
    
    public override init() {
        super.init()
        
        var error: Unmanaged<CFError>? = nil
        let addressBook = ABAddressBookCreateWithOptions(nil, &error)
        
        if error == nil {
            self.addressBook = addressBook.takeRetainedValue()
        }
    }
    
    /// Returns number of contacts in address book
    public var personCount: Int {
        get {
            return ABAddressBookGetPersonCount(self.addressBook)
        }
    }
    
    /// Returns number of groups in address book
    public var groupCount: Int {
        get {
            return ABAddressBookGetGroupCount(self.addressBook)
        }
    }
    
    /// Returns all contacts as an array of AddressBookPerson instances
    public var allContacts: [AddressBookPerson]? {
        get {
            return AddressBookPerson.convertToSelf(ABAddressBookCopyArrayOfAllPeople(self.addressBook)?.takeRetainedValue())
        }
    }
    
    public func retrieveAllContactsInQueue(
        queue: dispatch_queue_t,
        completion: (([AddressBookPerson]?, CFError?) -> Void)?)
    {
        self.retrieveAllContactsInQueue(queue,
            sort: nil,
            filter: nil,
            completion: completion)
    }
    
    public func retrieveAllContactsInQueue(
        queue: dispatch_queue_t,
        sort: ((AddressBookPerson, AddressBookPerson) -> Bool)?,
        completion: (([AddressBookPerson]?, CFError?) -> Void)?)
    {
        self.retrieveAllContactsInQueue(queue,
            sort: sort,
            filter: nil,
            completion: completion)
    }
    
    public func retrieveAllContactsInQueue(
        queue: dispatch_queue_t,
        filter: ((AddressBookPerson) -> Bool)?,
        completion: (([AddressBookPerson]?, CFError?) -> Void)?)
    {
        self.retrieveAllContactsInQueue(queue,
            sort: nil,
            filter: filter,
            completion: completion)
    }
    
    /**
        Retrieve all contacts in user defined queue

        :param: queue Queue that the completion block will run in
        :param: sort Sorting block to sort the list of contacts
        :param: filter Filtering block to filter the list of contacts
        :param: completion Block that runs after all contacts are retrieved
    */
    public func retrieveAllContactsInQueue(
        queue: dispatch_queue_t,
        sort: ((AddressBookPerson, AddressBookPerson) -> Bool)?,
        filter: ((AddressBookPerson) -> Bool)?,
        completion: (([AddressBookPerson]?, CFError?) -> Void)?) {
        var queue: dispatch_queue_t = dispatch_queue_create("com.addressbookmanager", nil)
        
        dispatch_async(queue) {
            self.requestAuthorizationWithCompletion(
                { (granted: Bool, error: CFError?) -> Void in
                    var peopleArray: [AddressBookPerson]? = []
                    
                    if (granted) {
                        var people: CFArray?
                        
                        dispatch_sync(queue) {
                            people = ABAddressBookCopyArrayOfAllPeople(self.addressBook)?.takeRetainedValue()
                        }
                        
                        peopleArray = AddressBookPerson.convertToSelf(people)
                        
                        if (filter != nil) {
                            peopleArray = peopleArray?.filter(filter!)
                        }
                        
                        if (sort != nil) {
                            peopleArray?.sort(sort!)
                        }
                    }
                    
                    dispatch_async(queue) {
                        completion?(peopleArray, error)
                    }
            })
        }

    }
    
    /**
        Requests authorization to access address book
    
        :param: completion Block that executes after requesting access for address book
    */
    public func requestAuthorizationWithCompletion(completion: (Bool, CFError?) -> Void) {
        ABAddressBookRequestAccessWithCompletion(self.addressBook, completion)
    }
    
    /**
        Add record to address book
    
        :param: record Record that is to be added to the address book
    
        :returns: Error, if one occurs while adding the record
    */
    public func addRecord(record: AddressBookRecord) -> CFError? {
        var error: Unmanaged<CFError>? = nil
        
        ABAddressBookAddRecord(self.addressBook, record.record, &error)
        return error?.takeRetainedValue()
    }
    
    /**
        Removes record from address book
    
        :param: record Record that is to be removed from the address book
    
        :returns: Error, if one occurs while removing the record
    */
    public func removeRecord(record: AddressBookRecord) -> CFError? {
        var error: Unmanaged<CFError>? = nil
        
        ABAddressBookRemoveRecord(self.addressBook, record.record, &error)
        return error?.takeRetainedValue()
    }
    
    /**
        Saves address book and adds applies changes/additions to the actual address book
    
        :returns: Error, if one occurs while saving the address book
    */
    public func save() -> CFError? {
        var error: Unmanaged<CFError>? = nil
        
        ABAddressBookSave(self.addressBook, &error)
        return error?.takeRetainedValue()
    }
    
    /**
        Checks if address book has any unsaved changes/additions
    
        :returns: If address book has any unsaved changes
    */
    public func hasUnsavedChanges() -> Bool {
        return ABAddressBookHasUnsavedChanges(self.addressBook)
    }
    
    /**
        :returns: Current authorization status for address book
    */
    public class func getAuthorizationStatus() -> AddressBookAuthorizationStatus {
        switch (ABAddressBookGetAuthorizationStatus()) {
            case ABAuthorizationStatus.Authorized:
                return .Authorized
            case ABAuthorizationStatus.Denied:
                return .Denied
            case ABAuthorizationStatus.Restricted:
                return .Restricted
            default:
                return .Unknown
        }
    }
}

public enum AddressBookAuthorizationStatus {
    case Authorized
    case Denied
    case Restricted
    case Unknown
}
