//
//  VCRegistration.swift
//  HZTB
//
//  Created by Pivotal on 6/14/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import Foundation
import UIKit
import Contacts
import SwiftyJSON

class VCRegistration: UIViewController {
    
    /*
    @IBOutlet var uName:UITextField!
    @IBOutlet var uPass:UITextField!
    @IBOutlet var uEmail:UITextField!
    */
    
    @IBOutlet var bg:UIImageView?
    @IBOutlet var uPhone:UITextField!
    
    private var utilREST:PIVDUtilREST
    private var registrationResult:String = ""
    
    public var sRegisteredNum:String = ""
    
    required init?(coder aDecoder: NSCoder) {
        utilREST = PIVDUtilREST()
        //
        super.init(coder: aDecoder)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("VCRegistration : viewDidAppear : ")
        /*
        let s:String = "http://lorempixel.com/g/420/680/fashion/"
        //let s:String = "http://lorempixel.com/g/420/680/"
        let url = NSURL(string:s)
        if let data = NSData(contentsOfURL: url!) {
            bg!.image = UIImage(data: data)
        }
        */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        //NSNotificationCenter.defaultCenter().addObserver( self, selector:#selector(onGotContacts), name: "contact_fetch_success", object: nil )
        NSNotificationCenter.defaultCenter().addObserver( self,
                                                          selector:#selector(onGotContacts),
                                                          name: PIVDStaticNames.CONTACT_FETCH_SUCCESS , object: nil )
        NSNotificationCenter.defaultCenter().addObserver( self,
                                                          selector: #selector(addressBookDidChange),
                                                          name: CNContactStoreDidChangeNotification, object: nil)
        
        //
        print("============== viewDidLoad = ")
        
        //let defaults = NSUserDefaults.standardUserDefaults()
        //defaults.setValue(true, forKey: PIVDStaticNames.IS_CONTACT_SAVED) // just a trick to make the address sync again
        
        PIVDUtilContact.getContacts()
        
        /*
        if let switchValue = defaults.stringForKey(PIVDStaticNames.IS_CONTACT_SAVED){
            print("============== switchValue = ",switchValue);
            if(Int(switchValue) == 1){
                print(" === SAVED =========== ")
                let savedContacts = defaults.stringForKey(PIVDStaticNames.ALL_CONTACTS_AS_STRING)
                print(savedContacts)
                print(" === / SAVED =========== ")
            }else{
                print("NOT SAVED ========")
                PIVDUtilContact.getContacts()
            }
        }else{
            print("============== viewDidLoad = ELSE = ")
            PIVDUtilContact.getContacts()
        }*/
 
        
        // Get the contacts
        //PIVDUtilContact.getContacts()
        //

        //
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Storyboard actions
    @IBAction func onRegistrationClick(sender:AnyObject){
        print("VCRegistration : onRegistrationClick : ")
        /*
        print(uName.text)
        print(uPass.text)
        print(uEmail.text)
        print(uPhone.text)
        */
        /*
        //callServiceToRegister()
        
        //utilREST.callRESTtestWith_dataTaskWithRequest()
        //utilREST.callRESTtestWith_dataTaskWithUrl()
        
        //utilREST.test_GET()
        //utilREST.test_POST()
        */
        
        //MARK: REST call for registration
        utilREST.callServerForRegistration(self,sPhone: uPhone.text!)
        //utilREST.callServerForPing()
    }
    
    internal func onRegistrationCallResult(sResult:String,resultMessage:String=""){
        print("VCRegistration : onRegistrationCallResult : result=",sResult)
        registrationResult = sResult;
        
        if(sResult == "ERROR"){
            print("VCRegistration : onRegistrationCallResult : message=",resultMessage)
            AppDelegate.getAppDelegate().showMessage(resultMessage,"Registration Error!")
        }else{
            //MARK: Saves the Registered PhoneNumber
            self.sRegisteredNum = uPhone.text!
            // Post the notification
            let notification = NSNotification(name: PIVDStaticNames.REGISTRATION_SUCCESS, object: self, userInfo:nil )
            NSNotificationCenter.defaultCenter().postNotification(notification)
            
            // Finally go back, Now its done form the parent VC as part of above Notification Handler
            //print("VCRegistration : onRegistrationCallResult : TODO : navigating back to previous screen")
            //self.navigationController?.popViewControllerAnimated(true)
        }
        //
    }
    internal func getRegistrationResult()->String{
        print("VCRegistration : getRegistrationResult : ",registrationResult)
        return registrationResult
    }
    
    private func dictionaryToQueryString(dict: [String : String]) -> String {
        var parts = [String]()
        for (key, value) in dict {
            let part: String = key + "=" + value
            parts.append(part);
        }
        return parts.joinWithSeparator("&")
    }
    
    /*
    //MARK: REST call - Not used now
    private func callServiceToRegister(){
        print("callServiceToRegister")
        
        //let sURL:NSURL = NSURL(string: "http://hztb-dev.us-east-1.elasticbeanstalk.com/user/register")!; // register
        let sURL:NSURL = NSURL(string: "http://hztb-dev.us-east-1.elasticbeanstalk.com/user/ping")!; // ping
        
        let session:NSURLSession = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: sURL)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        //let paramString = "mobileNumber=11479874489" // register
        let paramString = "mobileNumber=11479874489&imei=dummyimei" // ping
        
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        //request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var dataTask:NSURLSessionDataTask = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) in
            print("json data")
            do {
                print("do")
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as!NSDictionary
                // use jsonData
                print(" ==================== SUCCESS ==================== ")
                NSLog("%@", jsonData)
                print(" ==================== / SUCCESS ==================== ")
            } catch {
                print(" ==================== ERROR ==================== ")
                print(error)
                print(" ==================== / ERROR ==================== ")
            }
        }
        
        // finally call this
        dataTask.resume()
        //
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("VCRegistration:prepareForSegue")
    }
    
}

//MARK: Contacts API extension
extension VCRegistration {
    /*
    private func getContacts(){
        print("getContacts")
        let appDelegate:AppDelegate = AppDelegate.getAppDelegate()
        //appDelegate.showMessage("Hello","World")
        appDelegate.requestForAccess { (accessGranted) in
            if accessGranted {
                //appDelegate.showMessage("Granted","Contact Access")
                //self.onGotRequestGrant()
                PIVDUtilContact.onGotRequestGrant()
            }else{
                appDelegate.showMessage("Not Granted!","Contact Access")
            }
        }
    }
    private func onGotRequestGrant(){
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
    */
    internal func gotContacts(){
        print("VCRegistrastion : gotContacts")
        //print(PIVDUtilContact.allContacts)
        
        //let notification = NSNotification(name: "contact_fetch_success", object: self, userInfo:nil )
        //NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    internal func onGotContacts(data:NSObject){
        print("VCRegistrastion : onGotContacts")
        //print(PIVDUtilContact.allContacts)
        //print("TODO: Save the contacts")
        /*
        var a:String = ""
        for contact in PIVDUtilContact.allPIVDContacts {
            let s = String(contact.identifier) + "|"
            a.appendContentsOf(s)
        }
        print(PIVDUtilContact.allPIVDContacts)
        */
        /*
        // save flag
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(a, forKey: PIVDStaticNames.ALL_CONTACTS_AS_STRING)
        //defaults.setValue("", forKey: PIVDStaticNames.ALL_CONTACTS_AS_STRING) // Reset the data
        defaults.setValue(true, forKey: PIVDStaticNames.IS_CONTACT_SAVED)
        */
        
        let a = PIVDUtilContact.getAllContactNumbersAsStringArray()
        let b = Dictionary(dictionaryLiteral: ("userProfileRequests",a))
        let json = JSON(b)
        
        print("VCRegistrastion : onGotContacts : allAddress:")
        print(json)
        // TODO: Redy to go for the server call
        print("VCRegistrastion : onGotContacts : TODO:Sync with server ")
    }
    
    internal func addressBookDidChange(){
        print("VCRegistrastion : addressBookDidChange")
        PIVDUtilContact.getContacts()
    }
}

