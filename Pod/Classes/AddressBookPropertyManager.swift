//
//  AddressBookPropertyManager.swift
//  Pods
//
//  Created by Aadesh Patel on 5/30/15.
//
//

import Foundation
import AddressBook

class AddressBookPropertyManager: NSObject {
    /**
        Sets single value for address book property
    
        :param: property Property for which value is being set
        :param: value Value of the property
    
        :returns: Error, if one occurs setting a value
    */
    class func setSingleProperty(record record: ABRecord, property: ABPropertyID, value: AnyObject?) -> CFError? {
        var error: Unmanaged<CFError>? = nil
        
        ABRecordSetValue(record, property, value, &error)
        return error?.takeRetainedValue()
    }
    
    /**
        Retrieves single value for address book property
    
        :param: property Property for which single value is being retrieved for
    
        :returns: Single value of the property
    */
    class func getSingleProperty<T>(record record: ABRecord, property: ABPropertyID) -> T? {
        let propertyValue: AnyObject? = ABRecordCopyValue(record, property)?.takeRetainedValue()
        return propertyValue as? T
    }
    
    /**
        Sets multi value for address book property
    
        :param: property Property for which multi value is being set
        :param: values Array of MultiValue instances
    */
    class func setMultiValueProperty<T: AnyObject>(record record: ABRecord, property: ABPropertyID, values: Array<MultiValue<T>>?) {
        let multiValueRef: ABMutableMultiValueRef = ABMultiValueCreateMutable(ABPersonGetTypeOfProperty(property)).takeRetainedValue()
        
        for m: MultiValue in values! {
            ABMultiValueAddValueAndLabel(multiValueRef, m.value, m.key, nil)
        }
        
        ABRecordSetValue(record, property, multiValueRef, nil)
    }
    
    /**
        Retrieves multi value for address book property
    
        :param: property Property for which multi value is being retrieved for
    
        :returns: Value of property as an array of multi value instances
    */
    class func getMultiValueProperty<T>(record record: ABRecord, property: ABPropertyID) -> Array<MultiValue<T>>? {
        var propertyValues: Array<MultiValue<T>>?
        let values: ABMultiValue? = self.getSingleProperty(record: record, property: property)
        
        propertyValues = []
        for i: Int in 0..<(ABMultiValueGetCount(values)) {
            if let value: T? = ABMultiValueCopyValueAtIndex(values, i)?.takeRetainedValue() as? T {
                let _: Int = Int(ABMultiValueGetIdentifierAtIndex(values, i))
                let key: String? = ABMultiValueCopyLabelAtIndex(values, i).takeRetainedValue() as String
                let multiValue: MultiValue<T> = MultiValue(key: key!, value: value)
                
                propertyValues?.append(multiValue)
            }
        }
        
        return propertyValues
    }
    
    /**
        Retrieves multi value dictionary for address book property
    
        :param: property Property for which multi value dictionary is being retrieved for
        :param: convertor Block to convert from type T to type U
    
        :returns: Value of address book property as an array of multi value dictionaries
    */
    class func getMultiValueDictionaryProperty<T, U, V: AnyObject>(
        record record: ABRecord,
        property: ABPropertyID,
        convertor: (T) -> U) -> Array<MultiValue<Dictionary<U, V>>>?
    {
        var propertyValues: Array<MultiValue<Dictionary<U, V>>>?
        let values: ABMultiValue? = self.getSingleProperty(record: record, property: property)
        
        propertyValues = []
        for i: Int in 0..<(ABMultiValueGetCount(values)) {
            if let value: Dictionary<String, V>? = ABMultiValueCopyValueAtIndex(values, i).takeRetainedValue() as? Dictionary<String, V> {
                let _: Int = Int(ABMultiValueGetIdentifierAtIndex(values, i))
                let key: String? = ABMultiValueCopyLabelAtIndex(values, i).takeRetainedValue() as String
                
                var newValue = Dictionary<U, V>()
                for (k, v) in value! {
                    newValue[convertor(k as! T) as U] = v
                }
                
                let multiValue: MultiValue<Dictionary<U, V>> = MultiValue(key: key!, value: newValue)
                propertyValues?.append(multiValue)
            }
        }
        
        return propertyValues
    }
}

/**
    AddressPropertys to access components of an address
*/
public enum AddressProperty {
    case Street
    case City
    case State
    case ZipCode
    case Country
    case CountryCode

    
    /**
        Get AddressProperty value from kABPersonAddressKey String input

        :param: key kABPersonAddressKey to convert
    */
    init(key: String) {
        switch (key) {
        case String(kABPersonAddressCityKey):
            self = .City
        case String(kABPersonAddressStateKey):
            self = .State
        case String(kABPersonAddressZIPKey):
            self = .ZipCode
        case String(kABPersonAddressCountryKey):
            self = .Country
        case String(kABPersonAddressCountryCodeKey):
            self = .CountryCode
        default:
            self = .Street
        }
    }
    
    /**
        Get kABPersonAddressKey From Self Value

        :returns: kABPersonAddressKey that the self value corresponds to
    */
    var getABAddressPropertyKey: String {
        get {
            switch (self) {
            case .City:
                return String(kABPersonAddressCityKey)
            case .State:
                return String(kABPersonAddressStateKey)
            case .ZipCode:
                return String(kABPersonAddressZIPKey)
            case .Country:
                return String(kABPersonAddressCountryKey)
            case .CountryCode:
                return String(kABPersonAddressCountryCodeKey)
            default:
                return String(kABPersonAddressStreetKey)
            }
        }
    }
}