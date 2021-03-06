//
//  VCRegistrationConfirmation.swift
//  HZTB
//
//  Created by Pivotal on 6/28/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class VCRegistrationConfirmation: UIViewController {
    
    @IBOutlet var bg:UIImageView?
    @IBOutlet var otpField:UITextField!
    
    @IBOutlet var lblPhoneNumber:UILabel?
    
    public var registeredUserInfo:JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        print("VCRegistrationConfirmation : viewDidLoad : ")
        callServerToSendOTP()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("VCRegistrationConfirmation : viewWillAppear : ")
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("VCRegistrationConfirmation : viewDidAppear : ")
        /*
        let s:String = "http://lorempixel.com/g/420/680/fashion/"
        //let s:String = "http://lorempixel.com/g/420/680/"
        let url = NSURL(string:s)
        if let data = NSData(contentsOfURL: url!) {
            bg!.image = UIImage(data: data)
        }
        */
        
        
        self.lblPhoneNumber?.text = AppDelegate.getAppDelegate().sRegisteredCountryCode + " " + AppDelegate.getAppDelegate().sRegisteredMobileNum
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //
        print("VCRegistrationConfirmation : didReceiveMemoryWarning : ")
    }
}

//MARK: Storyboard Actions
extension VCRegistrationConfirmation {
    @IBAction func onConfirmTap(sender:AnyObject){
        print("VCRegistrationConfirmation : onConfirmTap : ")
        print(otpField.text)
        confirmOTPwithServer()
    }
    @IBAction func onSendAgainOTP(sender:AnyObject){
        print("VCRegistrationConfirmation : onSendAgainOTP : ")
        callServerToSendOTP()
    }
    
}
//MARK: Utility Methods
extension VCRegistrationConfirmation {
    internal func callServerToSendOTP(){
        print("VCRegistrationConfirmation : callServerToSendOTP :  === ")
        let sRegisteredMobileNum:String = AppDelegate.getAppDelegate().sRegisteredMobileNum
        print("VCRegistrationConfirmation : callServerToSendOTP : sRegisteredMobileNum=",sRegisteredMobileNum)
        // get OTP
        let url = "http://hztb-dev.us-east-1.elasticbeanstalk.com/user/getUserProfile"
        let headers = [
            "Content-Type":"application/json",
            "Accept":"application/json",
            "Accept-Language":"en-US",
            "REQUEST_ID":"1"
        ]
        let parameters = [
            "mobileNumber" : sRegisteredMobileNum
        ]
        
        Alamofire.request(.POST, url,headers:headers, parameters:parameters , encoding: .JSON)
            .responseJSON { (response) in
                
                let jsonOBJ = JSON((response.result.value)!)
                
                 print("result   ===========================================")
                 print(jsonOBJ)
                 print("result / ===========================================")
                 
                if(jsonOBJ["otpCode"].isExists()==true){
                    AppDelegate.getAppDelegate().showMessage("Check your SMS for OTP.","OTP Sent")
                }else{
                    AppDelegate.getAppDelegate().showMessage("OTP Generation. Try after sometime.","Error")
                }
        }
        print("VCRegistrationConfirmation : callServerToSendOTP : /=== ")
    }
    internal func confirmOTPwithServer(){
        print("VCRegistrationConfirmation : confirmOTPwithServer : ")
        callServerForPing()
    }
    internal func callServerForPing(){
        print("VCRegistrationConfirmation : callServerForPing : === ")
        
        let sOTP:String = otpField.text!
        let sRegisteredMobileNum:String = AppDelegate.getAppDelegate().sRegisteredMobileNum
        
        print("VCRegistrationConfirmation : callServerForPing : sRegisteredMobileNum=",sRegisteredMobileNum)
        
        // validate OTP
        let url = "http://hztb-dev.us-east-1.elasticbeanstalk.com/user/validateOTP"
        let headers = [
            "Content-Type":"application/json",
            "Accept":"application/json",
            "Accept-Language":"en-US",
            "REQUEST_ID":"1"
        ]
        //MARK: TODO: Use actual value instead of Dummy date here
        let parameters = [
            "mobileNumber" : sRegisteredMobileNum,
            "otpCode" : sOTP,
            "imei" : "12345",
            "deviceRegId" : "12345",
            "deviceId" : "12345"
        ]
        
        Alamofire.request(.POST, url,headers:headers, parameters:parameters , encoding: .JSON)
            .responseJSON { (response) in
                
                //print("post : request=",response.request)
                //print("post : response=",response.response)
                //print("post : data=",response.data)
                //print("post : result=",response.result)
                // SwiftyJSON
                //let json = JSON(data: dataFromNetworking)
                let jsonOBJ = JSON((response.result.value)!)
                
                print("===========================================")
                print("jsonOBJ=",jsonOBJ)
                print("isExists=",jsonOBJ["isValidateOTPSuccesful"].isExists())
                //print("jsonOBJ[0]=",jsonOBJ[0])
                //print("jsonOBJ[1]=",jsonOBJ[1])
                //print("jsonOBJ['json']=",jsonOBJ["json"])
                //print("jsonOBJ[\"json\"][\"foo\"]=",jsonOBJ["json"]["foo"])
                
                
                //print("status=",jsonOBJ["header"]["status"])
                //print("errors=",jsonOBJ["header"]["errors"])
                //print("message=",jsonOBJ["header"]["errors"][0]["message"])
                
                //print("===========================================")
                /*
                let s = jsonOBJ["header"]["status"].string
                let n = NSInteger(s!)
                if(n==400){
                    print("ERROR : ====== ")
                    let msg:String = jsonOBJ["header"]["errors"][0]["message"].string!
                    AppDelegate.getAppDelegate().showMessage(msg,"OTP Validation Error")
                }else{
                    print("SUCCESS : ===== ")
                }
                */
                
                
                
                
                if(jsonOBJ["isValidateOTPSuccesful"].isExists()==true){
                    print("SUCCESS")
                    
                    self.registeredUserInfo = jsonOBJ
                    
                    //AppDelegate.getAppDelegate().showMessage("OTP Validation Success","Welcome to HZTB!")
                    self.onOTPSuccess()
                }else{
                    print("message=",jsonOBJ["header"]["errors"][0]["message"])
                    let s:String = jsonOBJ["header"]["errors"][0]["message"].string!
                    AppDelegate.getAppDelegate().showMessage(s,"OTP Error!")
                }
                print("===========================================")
        }
        print("VCRegistrationConfirmation : callServerForPing : /=== ")
    }
    internal func onOTPSuccess(){
        print("VCRegistrationConfirmation : onOTPSuccess : ")
        // Post the notification
        let notification = NSNotification(name: PIVDStaticNames.OTP_SUCCESS , object: self, userInfo:nil )
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
}
