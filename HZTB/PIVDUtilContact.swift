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
    
    
    class func getContacts(){
        print("getContacts")
        let appDelegate:AppDelegate = AppDelegate.getAppDelegate()
        //appDelegate.showMessage("Hello","World")
        appDelegate.requestForAccess { (accessGranted) in
            if accessGranted {
                //appDelegate.showMessage("Granted","Contact Access")
                //self.onGotRequestGrant(callerRef)
                self.onGotRequestGrant()
            }else{
                appDelegate.showMessage("Not Granted!","Contact Access")
            }
        }
    }
    class func onGotRequestGrant(){
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
            //callerRef.gotContacts()
            
            // Post the notification
            //let notification = NSNotification(name: "contact_fetch_success", object: self, userInfo:nil )
            let notification = NSNotification(name:PIVDStaticNames.CONTACT_FETCH_SUCCESS , object: self, userInfo:nil )
            NSNotificationCenter.defaultCenter().postNotification(notification)
            
            //var P = PIVDEventNames.contact_fetch_success
            
        }catch let error as NSError{
            print(error.description, separator: "", terminator: "\n")
        }
        
        //print("xxxxxxxxxxxxx")
        //print(self.allContacts)
        
        
    }
}