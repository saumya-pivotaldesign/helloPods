//
//  VCRegistration.swift
//  HZTB
//
//  Created by Pivotal on 6/14/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import UIKit

class VCRegistration: UIViewController {
    
    @IBOutlet var uName:UITextField!
    @IBOutlet var uPass:UITextField!
    @IBOutlet var uEmail:UITextField!
    
    @IBOutlet var uPhone:UITextField!
    
    private var utilREST:PIVDUtilREST
    private var registrationResult:String = ""
    
    required init?(coder aDecoder: NSCoder) {
        utilREST = PIVDUtilREST()
        //
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        getContacts()
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Storyboard actions
    @IBAction func onRegistrationClick(sender:AnyObject){
        print("TODO: registration call")
        print(uName.text)
        print(uPass.text)
        print(uEmail.text)
        print(uPhone.text)
        
        //callServiceToRegister()
        
        //utilREST.callRESTtestWith_dataTaskWithRequest()
        //utilREST.callRESTtestWith_dataTaskWithUrl()
        
        //utilREST.test_GET()
        //utilREST.test_POST()
        
        utilREST.callServerForRegistration(self,sPhone: uPhone.text!)
        //utilREST.callServerForPing()
        
    }
    
    internal func onRegistrationCallResult(sResult:String){
        print("onRegistrationCallResult:",sResult)
        registrationResult = sResult;
        
        // Post the notification
        let notification = NSNotification(name: "reg_success", object: self, userInfo:nil )
        NSNotificationCenter.defaultCenter().postNotification(notification)
        // Finally go back
        self.navigationController?.popViewControllerAnimated(true)
    }
    internal func getRegistrationResult()->String{
        print("getRegistrationResult",registrationResult)
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
    private func getContacts(){
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
    private func onGotRequestGrant(){
        print("onGotRequestGrant")
    }
}
