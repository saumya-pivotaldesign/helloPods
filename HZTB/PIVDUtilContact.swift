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
    class func getContacts(){
        print("getContacts")
        let appDelegate:AppDelegate = AppDelegate.getAppDelegate()
        //appDelegate.showMessage("Hello","World")
        appDelegate.requestForAccess { (accessGranted) in
            if accessGranted {
                //appDelegate.showMessage("Granted","Contact Access")
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
            
            print("Fetching all contacts. Now ============== ")
            try contactStore.enumerateContactsWithFetchRequest(CNContactFetchRequest(keysToFetch:keys)) { (contact, pointer) -> Void in
                print(contact)
            }
            print("Fetching all contacts. Done ============= ")
            
        }catch let error as NSError{
            print(error.description, separator: "", terminator: "\n")
        }
    }
}