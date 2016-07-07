//
//  VCProfile.swift
//  HZTB
//
//  Created by Pivotal on 6/29/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

// storyboard id : sid_profile

class VCProfile: UIViewController {
    
    @IBOutlet var tName:UITextField?
    @IBOutlet var tEmail:UITextField?
    
    @IBOutlet var imgProfile:UIImageView?
    
    public var registeredUserInfo:JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VCProfile : viewDidLoad : ")
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setStyleCircleForImage(imgProfile!)
        //
        let sName:String = AppDelegate.getAppDelegate().sRegisteredUserName
        let sEmail:String = AppDelegate.getAppDelegate().sRegisteredUserEmail
        
        tName?.text = sName
        tEmail?.text = sEmail
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("VCProfile : didReceiveMemoryWarning : ")
    }
}

//MARK: Custom methods
extension VCProfile {
    @IBAction func onUpdateProfileTap(){
        updateProfile()
    }
    private func updateProfile(){
        print("VCProfile : updateProfile :   ================= ")
        let sName:String = tName!.text! as String
        let sEmail:String = tEmail!.text! as String
        let sPhoneNumber:String = AppDelegate.getAppDelegate().sRegisteredMobileNum
        
        // update profile
        let url = "http://hztb-dev.us-east-1.elasticbeanstalk.com/user/updateUserProfile"
        let headers = [
            "Content-Type":"application/json",
            "Accept":"application/json",
            "Accept-Language":"en-US",
            "REQUEST_ID":"1"
        ]
        //
        let parameters = [
            "mobileNumber" : sPhoneNumber,
            "name" : sName,
            "emailAddress" : sEmail
        ]
        
        Alamofire.request(.POST, url,headers:headers, parameters:parameters , encoding: .JSON)
            .responseJSON { (response) in
                
                //print("post : request=",response.request)
                //print("post : response=",response.response)
                //print("post : data=",response.data)
                //print("post : result=",response.result)
                
                print("result   ===========================================")
                print("post:",response)
                
                // SwiftyJSON
                //let json = JSON(data: dataFromNetworking)
                let jsonOBJ = JSON((response.result.value)!)
                print("jsonOBJ=",jsonOBJ)
                
                self.registeredUserInfo = jsonOBJ
                
                //AppDelegate.getAppDelegate().showMessage("Updated your profile.","Profile")
                
                // Post the notification
                let notification = NSNotification(name: PIVDStaticNames.PROFILE_UPDATE_SUCCESS , object: self, userInfo:nil )
                NSNotificationCenter.defaultCenter().postNotification(notification)
                
                print("result / ===========================================")
        }
        
        print("VCProfile : updateProfile : / ================= ")
    }
    
    private func setStyleCircleForImage(imgView:UIImageView){
        print("VCProfile : setStyleCircleForImage : ")
        
        imgProfile!.clipsToBounds = true
        imgProfile!.layer.cornerRadius = 100
 
        /*
        imgView.layer.cornerRadius = imgView.frame.size.height / 1.3
        //imgView.layer.cornerRadius = imgView.frame.size.width / 2.5
        imgView.clipsToBounds = true
        */
    }
}