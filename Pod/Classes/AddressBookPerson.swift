//
//  AddressBookPerson.swift
//  Pods
//
//  Created by Aadesh Patel on 5/30/15.
//
//

import AddressBook
import UIKit

public class AddressBookPerson: AddressBookRecord {
    public override init(record: ABRecord) {
        super.init(record: record)
    }
    
    public init() {
        super.init(record: ABPersonCreate().takeRetainedValue())
    }
    
    /*
        Getters and setters for person properties
    */
    
    public var firstName: String? {
        get {
            return self.getSingleProperty(kABPersonFirstNameProperty)
        }
        
        set {
            self.setSingleProperty(kABPersonFirstNameProperty, value: newValue)
        }
    }
    
    public var lastName: String? {
        get {
            return self.getSingleProperty(kABPersonLastNameProperty)
        }
        
        set {
            self.setSingleProperty(kABPersonLastNameProperty, value: newValue)
        }
    }
    
    public var nickname: String? {
        get {
            return self.getSingleProperty(kABPersonNicknameProperty)
        }
        
        set {
            self.setSingleProperty(kABPersonNicknameProperty, value: newValue)
        }
    }
    
    public var emails: Array<MultiValue<String>>? {
        get {
            return self.getMultiValueProperty(kABPersonEmailProperty)
        }
        
        set {
            self.setMultiValueProperty(kABPersonEmailProperty, values: self.convertMultiValueToNSString(newValue))
        }
    }
    
    public var phoneNumbers: Array<MultiValue<String>>? {
        get {
            return self.getMultiValueProperty(kABPersonPhoneProperty)
        }
        
        set {
            self.setMultiValueProperty(kABPersonPhoneProperty, values: self.convertMultiValueToNSString(newValue))
        }
    }
    
    public var birthday: NSDate? {
        get {
            return self.getSingleProperty(kABPersonBirthdayProperty)
        }
        
        set {
            self.setSingleProperty(kABPersonBirthdayProperty, value: newValue)
        }
    }
    
    public var organization: String? {
        get {
            return self.getSingleProperty(kABPersonOrganizationProperty)
        }
        
        set {
            self.setSingleProperty(kABPersonOrganizationProperty, value: newValue)
        }
    }
    
    public var jobTitle: String? {
        get {
            return self.getSingleProperty(kABPersonJobTitleProperty)
        }
        
        set {
            self.setSingleProperty(kABPersonJobTitleProperty, value: newValue)
        }
    }
    
    public var department: String? {
        get {
            return self.getSingleProperty(kABPersonDepartmentProperty)
        }
        
        set {
            self.setSingleProperty(kABPersonDepartmentProperty, value: newValue)
        }
    }
    
    public var note: String? {
        get {
            return self.getSingleProperty(kABPersonNoteProperty)
        }
        
        set {
            self.setSingleProperty(kABPersonNoteProperty, value: newValue)
        }
    }
    
    public var urls: Array<MultiValue<String>>? {
        get {
            return self.getMultiValueProperty(kABPersonURLProperty)
        }
        
        set {
            self.setMultiValueProperty(kABPersonURLProperty, values: self.convertMultiValueToNSString(newValue))
        }
    }
    
    public var profilePicture: UIImage? {
        get {
            return UIImage(data: ABPersonCopyImageData(self.record).takeRetainedValue())
        }
        
        set {
            let imageData: NSData = UIImagePNGRepresentation(newValue)
            ABPersonSetImageData(self.record, imageData, nil)
        }
    }
    
    public var prefix: String? {
        get {
            return self.getSingleProperty(kABPersonPrefixProperty)
        }
        
        set {
            self.setSingleProperty(kABPersonPrefixProperty, value: newValue)
        }
    }
    
    public var suffix: String? {
        get {
            return self.getSingleProperty(kABPersonSuffixProperty)
        }
        
        set {
            self.setSingleProperty(kABPersonSuffixProperty, value: newValue)
        }
    }
    
    public var firstNamePhonetic: String? {
        get {
            return self.getSingleProperty(kABPersonFirstNamePhoneticProperty)
        }
        
        set {
            self.setSingleProperty(kABPersonFirstNamePhoneticProperty, value: newValue)
        }
    }
    
    public var lastNamePhonetic: String? {
        get {
            return self.getSingleProperty(kABPersonLastNamePhoneticProperty)
        }
        
        set {
            self.setSingleProperty(kABPersonLastNamePhoneticProperty, value: newValue)
        }
    }
    
    public var middleName: String? {
        get {
            return self.getSingleProperty(kABPersonMiddleNameProperty)
        }
        
        set {
            self.setSingleProperty(kABPersonMiddleNameProperty, value: newValue)
        }
    }
    
    public var middleNamePhonetic: String? {
        get {
            return self.getSingleProperty(kABPersonMiddleNamePhoneticProperty)
        }
        
        set {
            self.setSingleProperty(kABPersonMiddleNamePhoneticProperty, value: newValue)
        }
    }
    
    public var relatedNames: Array<MultiValue<String>>? {
        get {
            return self.getMultiValueProperty(kABPersonRelatedNamesProperty)
        }
        
        set {
            self.setMultiValueProperty(kABPersonRelatedNamesProperty, values: self.convertMultiValueToNSString(relatedNames))
        }
    }
    
    public var dates: Array<MultiValue<NSDate>>? {
        get {
            return self.getMultiValueProperty(kABPersonDateProperty)
        }
        
        set {
            self.setMultiValueProperty(kABPersonDateProperty, values: newValue)
        }
    }
    
    public var addresses: Array<MultiValue<Dictionary<AddressProperty, AnyObject>>>? {
        get {
            return self.getMultiValueDictionaryProperty(kABPersonAddressProperty, convertor: {
                (input: String) -> AddressProperty in
                return AddressProperty(key: input)
            })
        }
        
        set {
            self.setMultiValueProperty(kABPersonAddressProperty, values: self.convertMultiValueToNSDictionary(newValue))
        }
    }
    
    /**
        Converts Dictionary To MultiValue Dictionary
    
        :param: values Dictionary to convert
    
        :returns: Array of MultiValue Dictionaries
    */
    private func convertMultiValueToNSDictionary<T: AnyObject>(values: Array<MultiValue<Dictionary<AddressProperty, T>>>?) -> [MultiValue<NSDictionary>]? {
        var result: [MultiValue<NSDictionary>]?
        
        if values != nil {
            result = []
            for value: MultiValue<Dictionary<AddressProperty, T>> in values! {
                let dictionary = value.value
                
                var ABAddressDictionary = Dictionary<String, AnyObject>()
                for (key: AddressProperty, value: T) in dictionary! {
                    ABAddressDictionary[key.getABAddressPropertyKey] = value
                }
                
                result?.append(MultiValue(id: value.id, key: value.key!, value: NSDictionary(dictionary: ABAddressDictionary)))
            }
        }
        
        return result
    }
    
    /**
        Convert String to NSString
    
        :param: values Array of strings that are to be converted
    
        :returns: Array of MultiValue NSStrings
    */
    private func convertMultiValueToNSString(values: Array<MultiValue<String>>?) -> [MultiValue<NSString>]? {
        var result: [MultiValue<NSString>]?
        
        if values != nil {
            result = []
            for value in values! {
                result?.append(MultiValue(id: value.id, key: value.key!, value: NSString(string: value.value!)))
            }
        }
        
        return result
    }
    
    /**
        Sets single value for address book property
    
        :param: property Property for which value is being set
        :param: value Value of the property
    
        :returns: Error, if one occurs setting a value
    */
    func setSingleProperty(property: ABPropertyID, value: AnyObject?) -> CFError? {
        return AddressBookPropertyManager.setSingleProperty(record: self.record, property: property, value: value)
    }
    
    /**
        Retrieves single value for address book property
    
        :param: property Property for which single value is being retrieved for
    
        :returns: Single value of the property
    */
    func getSingleProperty<T>(property: ABPropertyID) -> T? {
        return AddressBookPropertyManager.getSingleProperty(record: self.record, property: property)
    }
    
    /**
        Sets multi value for address book property
    
        :param: property Property for which multi value is being set
        :param: values Array of MultiValue instances
    */
    func setMultiValueProperty<T: AnyObject>(property: ABPropertyID, values: Array<MultiValue<T>>?) {
        AddressBookPropertyManager.setMultiValueProperty(record: self.record, property: property, values: values)
    }
    
    /**
        Retrieves multi value for address book property
    
        :param: property Property for which multi value is being retrieved for
    
        :returns: Value of property as an array of multi value instances
    */
    func getMultiValueProperty<T>(property: ABPropertyID) -> Array<MultiValue<T>>? {
        return AddressBookPropertyManager.getMultiValueProperty(record: self.record, property: property)
    }
    
    /**
        Retrieves multi value dictionary for address book property
    
        :param: property Property for which multi value dictionary is being retrieved for
        :param: convertor Block to convert from type T to type U
    
        :returns: Value of address book property as an array of multi value dictionaries
    */
    func getMultiValueDictionaryProperty<T,U,V: AnyObject>(
        property: ABPropertyID,
        convertor: (T) -> U) -> Array<MultiValue<Dictionary<U, V>>>?
    {
        return AddressBookPropertyManager.getMultiValueDictionaryProperty(self.record, property: property, convertor: convertor)
    }
    
    /**
        Converts array of ABRecord instances to an array of AddressBookPerson instances
    
        :param: records Array of records to be converted
    
        :returns: Array of converted records to AddressBookPerson
    */
    class func convertToSelf(records: CFArray?) -> [AddressBookPerson]? {
        return (records as? [ABRecord])?.map {(record: ABRecord) -> AddressBookPerson in
            return AddressBookPerson(record: record)
        }
    }
}