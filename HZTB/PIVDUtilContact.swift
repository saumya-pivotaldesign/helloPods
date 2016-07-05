//
//  PIVDUtilContact.swift
//  HZTB
//
//  Created by Pivotal on 6/23/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import Foundation
import Contacts
import SwiftyJSON
import Alamofire

class PIVDUtilContact {
    
    static var hasContactsFetched:Bool = false
    static var allContacts:Array = [CNContact]()
    static var allPIVDContacts:Array = [PIVDContact]()
    
    
    class func getContacts(){
        print("PIVDUtilContact : getContacts :")
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
        print("PIVDUtilContact : onGotRequestGrant :")
        //MARK: Get the Contact store
        do{
            let contactStore:CNContactStore = AppDelegate.getAppDelegate().contactStore;
            let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactNamePrefixKey, CNContactMiddleNameKey, CNContactPhoneNumbersKey]
            //let ccr:CNContactFetchRequest = CNContactFetchRequest(keysToFetch:keys)
            
            //reset the data
            PIVDUtilContact.allContacts = [CNContact]()
            PIVDUtilContact.allPIVDContacts = [PIVDContact]()
            
            //print("Fetching all contacts. Now ============== ")
            try contactStore.enumerateContactsWithFetchRequest(CNContactFetchRequest(keysToFetch:keys)) { (contact, pointer) -> Void in
                //print(contact)
                //let s:String = String(contact)
                /*
                print(contact.identifier,contact.givenName,contact.familyName,contact.phoneNumbers.count)
                print ( (contact.phoneNumbers[0].value as! CNPhoneNumber).valueForKey("digits") as! String)
                print(" ==================== xxxxxxxxxx ================= ")
 
                print(" =========== xxx ============ ")
                print ( (contact.phoneNumbers[0].value as! CNPhoneNumber) )
                print ( (contact.phoneNumbers[0].value as! CNPhoneNumber).valueForKey("countryCode") as! String)
                print ( (contact.phoneNumbers[0].value as! CNPhoneNumber).valueForKey("digits") as! String)
                print(" =========== xxx ============ ")
                */
                
                // MARK: Save the raw CNContact data
                
                allContacts.append(contact)
                
                // MARK: Parsing CNContact to PIVDContact
                // Parsing and storing for application
                var pivdContact:PIVDContact = PIVDContact()
                pivdContact.identifier = contact.identifier
                pivdContact.givenName = contact.givenName
                pivdContact.familyName = contact.familyName
                // taken the first phone number only
                pivdContact.phoneNumber_digits = (contact.phoneNumbers[0].value as! CNPhoneNumber).valueForKey("digits") as! String
                pivdContact.countryCode = (contact.phoneNumbers[0].value as! CNPhoneNumber).valueForKey("countryCode") as! String
                // MARK: Saving all PIVDContact in local Array
                allPIVDContacts.append(pivdContact)
                
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
    
    static func getAllContactNumbersAsStringArray()->Array<AnyObject>{
        
        var a:Array<AnyObject> = [AnyObject]()
        //var a = Dictionary<String, String>()
        //var a:Dictionary = [String:String]()
        
        for contact in PIVDUtilContact.allPIVDContacts {
            //let s = String(contact.phoneNumber_digits)
            
            let s1 = "mobileNumber"
            let s2 = String(contact.phoneNumber_digits)
            //let s3 = "{"+s1+" : "+s2+" }"
            //a.append(s3)
            let d = Dictionary(dictionaryLiteral: (s1,s2))
            a.append(d)
            
            //var d = []
            //d.updateValue(contact.phoneNumber_digits, forKey: "mobileNumber")
        }
        
        print("PIVDUtilContact ====== getAllContactNumbers")
        print(a)
        print("PIVDUtilContact ====== / getAllContactNumbers")
        
        return a
    }
    
    static func sendContactsToServer(){
        print("PIVDUtilContact : sendContactsToServer     ================ ")
        
        var a:Array<AnyObject> = [AnyObject]()
        for contact in self.allPIVDContacts {
            let s1 = "mobileNumber"
            let s2 = String(contact.phoneNumber_digits)
            let d = Dictionary(dictionaryLiteral: (s1,s2))
            a.append(d)
        }
        //print(a)
        //let d1 = Dictionary(dictionaryLiteral: ("userProfileRequests", a))
        //print(d1)
        
        // ======================
        let url = "http://hztb-dev.us-east-1.elasticbeanstalk.com/user/registeredUsers"
        let headers = [
            "Content-Type":"application/json",
            "Accept":"application/json",
            "Accept-Language":"en-US",
            "REQUEST_ID":"1212"
        ]
        let parameters = [
            "userProfileRequests" : a
        ]
        Alamofire.request(.POST, url,headers:headers, parameters:parameters , encoding: .JSON)
            .responseJSON { (response) in
                /*
                print("post : request=",response.request)
                print("post : response=",response.response)
                print("post : data=",response.data)
                print("post : result=",response.result)
                // SwiftyJSON
                //let json = JSON(data: dataFromNetworking)
                let jsonOBJ = JSON((response.result.value)!)
                
                print("===========================================")
                print("jsonOBJ=",jsonOBJ)
                print("jsonOBJ[0]=",jsonOBJ[0])
                print("jsonOBJ[1]=",jsonOBJ[1])
                print("jsonOBJ['json']=",jsonOBJ["json"])
                print("jsonOBJ[\"json\"][\"foo\"]=",jsonOBJ["json"]["foo"])
                print("===========================================")
                */
                print("PIVDUtilContact : sendContactsToServer : result  ===========================================")
                let jsonOBJ = JSON((response.result.value)!)
                print(jsonOBJ)
                //AppDelegate.getAppDelegate().contactsFromServer = jsonOBJ
                AppDelegate.getAppDelegate().gotContactsFromServer(jsonOBJ)
                print("PIVDUtilContact : sendContactsToServer : result / ===========================================")
        }
    }
    
    
    
    
}