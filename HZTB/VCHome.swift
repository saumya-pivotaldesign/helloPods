//
//  VCHome.swift
//  HZTB
//
//  Created by Pivotal on 5/25/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import UIKit
import SwiftyJSON

// MARK: VCHome is ViewController
class VCHome: UIViewController {
    
    let interactor = Interactor()
    var sRegisteredMobileNum:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        print("VCHome : viewDidLoad")
        
        //MARK: TopBar Color customisation
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 236/255, green: 30/255, blue: 121/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor() // Font color of the navigation items
        // title color
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        
        //MARK: EventHandler Registrations
        NSNotificationCenter.defaultCenter().addObserver( self, selector:#selector(onRegistrationNotification),
                                                          name: PIVDStaticNames.REGISTRATION_SUCCESS, object: nil )
        NSNotificationCenter.defaultCenter().addObserver( self, selector:#selector(onOTPSuccess),
                                                          name: PIVDStaticNames.OTP_SUCCESS, object: nil )
        NSNotificationCenter.defaultCenter().addObserver( self, selector:#selector(onProfileUpdateSuccess),
                                                          name: PIVDStaticNames.PROFILE_UPDATE_SUCCESS, object: nil )
        //Links
        NSNotificationCenter.defaultCenter().addObserver( self, selector:#selector(onLinkTapProfile),
                                                          name: PIVDStaticNames.LINK_PROFILE_TAP, object: nil )
        NSNotificationCenter.defaultCenter().addObserver( self, selector:#selector(onLinkTapSettings),
                                                          name: PIVDStaticNames.LINK_SETTINGS_TAP, object: nil )
        NSNotificationCenter.defaultCenter().addObserver( self, selector:#selector(onLinkTapGroups),
                                                          name: PIVDStaticNames.LINK_GROUPS_TAP, object: nil )
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print("VCHome : viewWillAppear")
        
    }
    
    
    @objc private func onRegistrationNotification(notification:NSNotification){
        print("VCHome : onRegistrationNotification ================ ")
        print("VCHome : onRegistrationNotification : name=",notification.name)
        print("VCHome : onRegistrationNotification : object=",notification.object)
        
        let a:VCRegistration = notification.object as! VCRegistration
        print("VCHome : onRegistrationNotification : VCRegistration=",a)
        print("VCHome : onRegistrationNotification : sRegisteredNum=",a.sRegisteredNum)
        sRegisteredMobileNum = a.sRegisteredNum
        
        //print(data.object)
        //print((data.object as! VCRegistration).sRegisteredNum)
        print("VCHome : onRegistrationNotification / ================ ")
        self.navigationController?.popViewControllerAnimated(true)
        
        AppDelegate.getAppDelegate().sRegisteredMobileNum = sRegisteredMobileNum
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("sid_registration_confirmation") as! VCRegistrationConfirmation
        navigationController?.pushViewController(vc, animated: true)
        //
    }
    
    
    //MARK: Navigating to Storyboard screens
    // Storyboard id : sid_profile, sid_settings, sid_groups
    @objc private func onLinkTapProfile(notification:NSNotification){
        print("VCHome : onLinkTapProfile   ================ ")
        // Move to Profile View
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("sid_profile") as! VCProfile
        navigationController?.pushViewController(vc, animated: true)
        print("VCHome : onLinkTapProfile / ================ ")
    }
    @objc private func onLinkTapSettings(notification:NSNotification){
        print("VCHome : onLinkTapSettings   ================ ")
        // Move to Settings View
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("sid_settings") as! VCSettings
        navigationController?.pushViewController(vc, animated: true)
        print("VCHome : onLinkTapSettings / ================ ")
    }
    @objc private func onLinkTapGroups(notification:NSNotification){
        print("VCHome : onLinkTapGroups   ================ ")
        // Move to Group View
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("sid_groups") as! VCGroups
        navigationController?.pushViewController(vc, animated: true)
        print("VCHome : onLinkTapGroups / ================ ")
    }
    
    
    
    @objc private func onOTPSuccess(notification:NSNotification){
        print("VCHome : onOTPSuccess   ================ ")
        // 1. Come back to Home
        self.navigationController?.popViewControllerAnimated(true)
        //
        //PIVDUtilLocalStorage.saveUserData(AppDelegate.getAppDelegate().realm!)
        let myViewController:VCRegistrationConfirmation = notification.object as! VCRegistrationConfirmation
        let resultJson:JSON = myViewController.registeredUserInfo!
        
        //print("  ======")
        //print("result", resultJson)
        //print(resultJson["userId"])
        //print(resultJson["mobileNumber"])
        //print(AppDelegate.getAppDelegate().sRegisteredMobileNum)
        
        // 2. Fix: Write a Setter for these things
        // AppDelegate.getAppDelegate().sRegisteredUserId = resultJson["userId"].string!
        // AppDelegate.getAppDelegate().sRegisteredMobileNum = resultJson["mobileNumber"].string!
        
        let sId:String = resultJson["userId"].string!
        let sNum:String = resultJson["mobileNumber"].string!
        AppDelegate.getAppDelegate().updateRegisteredUser(sId, mobileNumber: sNum)
        
        
        
        //print("/ ======")
        
        
        // 3. Move to Profile View
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("sid_profile") as! VCProfile
        navigationController?.pushViewController(vc, animated: true)
 
        print("VCHome : onOTPSuccess / ================ ")
    }
    
    @objc private func onProfileUpdateSuccess(notification:NSNotification){
        print("VCHome : onProfileUpdateSuccess    ================ ")
        // 1. Come back to Home
        self.navigationController?.popViewControllerAnimated(true)
        
        // 2.
        let myViewController:VCProfile = notification.object as! VCProfile
        let resultJson:JSON = myViewController.registeredUserInfo!
        // 3. Fix: Write a Setter for these things
        // AppDelegate.getAppDelegate().sRegisteredUserName = resultJson["name"].string!
        // AppDelegate.getAppDelegate().sRegisteredUserEmail = resultJson["emailAddress"].string!
        
        let sName:String = resultJson["name"].string!
        let sEmail:String = resultJson["emailAddress"].string!
        AppDelegate.getAppDelegate().updateRegisteredUser(sName, email: sEmail)
        
        // 4.
        syncTheAddressbookWithServer()
        print("VCHome : onProfileUpdateSuccess  / ================ ")
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("VCHome : prepareForSegue")
        if let destinationViewController = segue.destinationViewController as? VCSlideMenu {
            destinationViewController.transitioningDelegate = self
            // 2
            destinationViewController.interactor = interactor
        }
    }
    
    // MARK: Expose to Storyboard
    @IBAction func openMenu(sender: AnyObject) {
        performSegueWithIdentifier("openMenu", sender: nil)
    }
    @IBAction func edgePanGesture(sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let progress = MenuHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .Right)
        MenuHelper.mapGestureStateToInteractor( sender.state, progress: progress, interactor: interactor){
            self.performSegueWithIdentifier("openMenu", sender: nil)
        }
    }
    @IBAction func showRegistrationView(sender:AnyObject){
        print("showRegistrationView");
        /*
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *initViewController = [storyboard instantiateViewControllerWithIdentifier:@"sid_registration"];
        */
        
        /*
        let vc = ViewController() //change this to your class name
        self.presentViewController(vc, animated: true, completion: nil)
        */
        
        /*
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("sid_registration")
        //self.presentViewController(vc!, animated: true, completion: nil)
        navigationController?.pushViewController(vc!, animated: true)
        */
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("sid_registration") as! VCRegistration
        //self.presentViewController(vc, animated: true, completion: nil)
        //navigationController?.presentViewController(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onSentReceivedTap(sender:AnyObject){
        print("VCHome : onSentReceivedTap : ")
    }
    @IBAction func onReceivedGivenTap(sender:AnyObject){
        print("VCHome : onReceivedGivenTap : ")
    }
    @IBAction func onInStoreNowTap(sender:AnyObject){
        print("VCHome : onInStoreNowTap : ")
    }
    
}



// MARK: Extension of the VCHome
extension VCHome: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
    // 3
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}

// MARK: Camera button for URLScheme test
extension VCHome {
    @IBAction func onURLSchemeTest(sender:AnyObject){
        print("onURLSchemeTest")
        //let n:NSURL = NSURL(string: "")!
        //UIApplication.sharedApplication().openURL(NSURL(fileURLWithPath: "hztbuddy://test_page/one?token=12345&domain=foo.com"))
    }
}

//MARK: Functional needs
extension VCHome {
    private func syncTheAddressbookWithServer(){
        print("VCHome : syncTheAddressbookWithServer     ================ ")
        print("TODO:")
        //print("PIVDUtilContact.allContacts=",PIVDUtilContact.allContacts)
        //print("PIVDUtilContact.allPIVDContacts=",PIVDUtilContact.allPIVDContacts)
        //let aContacts = PIVDUtilContact.allPIVDContacts
        
        PIVDUtilContact.sendContactsToServer()
        
        print("VCHome : syncTheAddressbookWithServer  /  ================ ")
    }
}

