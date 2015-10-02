# AddressBookManager

[![CI Status](http://img.shields.io/travis/aadesh/AddressBookManager.svg?style=flat)](https://travis-ci.org/aadesh/AddressBookManager)
[![Version](https://img.shields.io/cocoapods/v/AddressBookManager.svg?style=flat)](http://cocoapods.org/pods/AddressBookManager)
[![License](https://img.shields.io/cocoapods/l/AddressBookManager.svg?style=flat)](http://cocoapods.org/pods/AddressBookManager)
[![Platform](https://img.shields.io/cocoapods/p/AddressBookManager.svg?style=flat)](http://cocoapods.org/pods/AddressBookManager)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

##### Create Instance Of AddressBookManager
```swift
import AddressBookManager
...

var abManager: AddressBookManager? = AddressBookManager()
```

##### Authorization Status

```swift
switch (AddressBookManager.getAuthorizationStatus()) {
    case .Authorized:
        // Authorized To Use AddressBook
    case .Denied:
        // Denied Access To AddressBook
    case .Restricted:
        // Restricted Access To AddressBook
    case .Unknown:
        // Access To AddressBook Unknown, Most Likely AddressBook Authorization Has Not Been Requested Yet
}
```

##### Retrieving Contacts

```swift
// Option 1
abManager?.requestAuthorizationWithCompletion({ (granted: Bool, error: CFError?) -> Void in
            if (error) {
              // Handle Error 
            } else if (granted) {
              var people = abManager?.allContacts
              // Do Something With Contacts
            }
        })
        
// Option 2 - If you want to use a specific queue for retrieval
abManager?.retrieveAllContactsInQueue(dispatch_get_main_queue(),
            completion: { (contacts: [AddressBookPerson]?, error: CFError?) -> Void in
                if (error) {
                  // Handle Error
                } else {
                  // Do Something With Contacts
                }
        })
```

###### Sorting Contacts
```swift
// Sort Contacts In Ascending Order By First Name
abManager?.retrieveAllContactsInQueue(dispatch_get_main_queue(),
            sort: { $0.firstName < $1.firstName },
            completion: { (contacts: [AddressBookPerson]?, error: CFError?) -> Void in
                if (error) {
                  // Handle Error
                } else {
                  // Do Something With Contacts
                }
        })
```

###### Filtering Contacts
```swift
// Retrieve Contacts That Have Atleast One Email
abManager?.retrieveAllContactsInQueue(dispatch_get_main_queue(),
            filter: { count($0.emails!) > 0 },
            completion: { (contacts: [AddressBookPerson]?, error: CFError?) -> Void in
                if (error) {
                  // Handle Error
                } else {
                  // Do Something With Contacts
                }
        })
```

###### Sorting And Filtering Contacts
```swift
// Retrieve Only Contacts That Have Atleast One Email And Sort Those Contacts In Ascending Order By First Name
abManager?.retrieveAllContactsInQueue(dispatch_get_main_queue(),
            sort: { $0.firstName < $1.firstName },
            filter: { count($0.emails!) > 0 },
            completion: { (contacts: [AddressBookPerson]?, error: CFError?) -> Void in
                if (error) {
                  // Handle Error
                } else {
                  // Do Something With Contacts
                }
        })
```

##### Adding Contacts
```swift
abm.requestAuthorizationWithCompletion { (granted: Bool, error: CFError?) -> Void in
    let person = AddressBookPerson()
    person.firstName = "Bob"
    person.lastName = "Smith"
            
    let personalEmail = MultiValue(key: "personal", value: "bob@mail.com")
    person.emails = [personalEmail]
            
    let homePhoneNumber = MultiValue(key: "home", value: "5555555555")
    let mobilePhoneNumber = MultiValue(key: "mobile", value: "1234567890")
    person.phoneNumbers = [homePhoneNumber, mobilePhoneNumber]
            
    person.profilePicture = UIImage(named: "bob.png")
            
    var homeAddress = Dictionary<AddressProperty, AnyObject>()
    homeAddress[AddressProperty.Street] = "123 Maple Street"
    homeAddress[AddressProperty.City] = "Miami"
    homeAddress[AddressProperty.State] = "FL"
    homeAddress[AddressProperty.ZipCode] = "00000"
    homeAddress[AddressProperty.Country] = "USA"
            
    let homeAddressValue = MultiValue(key: "home", value: homeAddress)
    person.addresses = [homeAddressValue]
            
    let dateFormatter: NSDateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    let birthday: NSDate? = dateFormatter.dateFromString("01/01/1970")
    person.birthday = birthday
            
    person.organization = "Some Huge Organization"
    person.jobTitle = "Developer"
    person.department = "Software"
    person.note = "Some Note Here"
            
    let personalURL = MultiValue(key: "personal", value: "https://somewebsite")
    person.urls = [personalURL]
            
    person.prefix = "Mr"
    person.suffix = "Jr"
    person.middleName = "Roger"
            
    let anniversaryDate = MultiValue(key: "anniversary", value: dateFormatter.dateFromString("02/02/2000"))
    person.dates = [anniversaryDate]
            
    abm?.addRecord(person)
    abm?.save()
}
```
![Contact-Screenshot](https://cloud.githubusercontent.com/assets/8670066/7900550/55c84ffe-072d-11e5-8b2e-3d3dadf9f6c5.png)

##### Miscellaneous Methods

- personCount - returns number of contacts in the address book
- groupCount - returns number of groups in the address book
- removeRecord - removes the record (AddressBookRecord) from the address book
- hasUnsavedChanges - if there were any changes to the address book (additions, removal, etc...) that have not yet been saved

## Installation

AddressBookManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AddressBookManager"
```
OR

You can simply clone this repository and drag the files into your project.

## Author

Aadesh Patel, aadeshp95@gmail.com

## License

AddressBookManager is available under the MIT license. See the LICENSE file for more info.
