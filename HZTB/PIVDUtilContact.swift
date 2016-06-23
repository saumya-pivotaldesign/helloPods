//
//  PIVDUtilContact.swift
//  HZTB
//
//  Created by Pivotal on 6/23/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import Foundation
import Contacts

class PIVDUtilContact {
    
    static var hasContactsFetched:Bool = false
    static var allContacts:Array = [AnyObject]()
    
    
    class func getContacts(callerRef:VCRegistration){
        print("getContacts")
        let appDelegate:AppDelegate = AppDelegate.getAppDelegate()
        //appDelegate.showMessage("Hello","World")
        appDelegate.requestForAccess { (accessGranted) in
            if accessGranted {
                //appDelegate.showMessage("Granted","Contact Access")
                self.onGotRequestGrant(callerRef)
            }else{
                appDelegate.showMessage("Not Granted!","Contact Access")
            }
        }
    }
    class func onGotRequestGrant(callerRef:VCRegistration){
        print("onGotRequestGrant")
        
        do{
            let contactStore:CNContactStore = AppDelegate.getAppDelegate().contactStore;
            let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactNamePrefixKey, CNContactMiddleNameKey, CNContactPhoneNumbersKey]
            //let ccr:CNContactFetchRequest = CNContactFetchRequest(keysToFetch:keys)
            
            //print("Fetching all contacts. Now ============== ")
            try contactStore.enumerateContactsWithFetchRequest(CNContactFetchRequest(keysToFetch:keys)) { (contact, pointer) -> Void in
                //print(contact)
                allContacts.append(contact)
                hasContactsFetched = true
            }
            //print("Fetching all contacts. Done ============= ")
            callerRef.gotContacts()
            
        }catch let error as NSError{
            print(error.description, separator: "", terminator: "\n")
        }
        
        //print("xxxxxxxxxxxxx")
        //print(self.allContacts)
        
        
    }
}