//
//  AppDelegate.swift
//  HZTB
//
//  Created by Pivotal on 5/17/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import UIKit
import Contacts

import SwiftyJSON
import Realm
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var contactStore:CNContactStore = CNContactStore()
    var sRegisteredMobileNum:String = ""
    //
    var contactsFromServer:JSON = []
    //
    var realm:Realm?
    //var pvdUtilLocalStorage:PIVDUtilLocalStorage?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        print("AppDelegate : application:didFinishLaunchingWithOptions:   ======== ")
        /*
        do {
            self.realm = try Realm()
            print("initRealm : done :",self.realm)
            
        } catch let error as NSError {
            print("initRealm : ERROR :")
            print(error)
        }
        */
        //self.pvdUtilLocalStorage = PIVDUtilLocalStorage.init(withRealm: self.realm!)
        
        if(PIVDUtilLocalStorage.initRealm()){
            print("initRealm : done : PIVDUtilLocalStorage.realmRef=", PIVDUtilLocalStorage.realmRef )
            self.realm = PIVDUtilLocalStorage.realmRef
        }else{
           print("initRealm : ERROR :")
        }
        
        
        print("AppDelegate : application:didFinishLaunchingWithOptions: / ======== ")
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        print("AppDelegate : applicationWillResignActive:")
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("AppDelegate : applicationDidEnterBackground:")
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        print("AppDelegate : applicationWillEnterForeground:")
        
        //self.window?.rootViewController?.navigationController?.viewControllers.removeAll();
        //self.window?.rootViewController?.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("AppDelegate : applicationDidBecomeActive:")
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("AppDelegate : applicationWillTerminate:")
    }
    
    // MARK: External URL handler delegate
    // Ref: http://www.idev101.com/code/Objective-C/custom_url_schemes.html
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        print("AppDelegate : handleOpenURL");
        print(url)
        print(url.query)
        print(url.host)
        print(url.path)
        
        // Type 1
        let w:UIWindow = UIApplication.sharedApplication().keyWindow!
        let r:UIViewController = w.rootViewController!
        let s:UIStoryboard = r.storyboard!
        //let cv = s.instantiateViewControllerWithIdentifier("sbid_newRequest")
        let cv:VCNewRequest = (s.instantiateViewControllerWithIdentifier("sbid_newRequest") as! VCNewRequest)
        cv.setProductID(url.host!)
        // working
        r.presentViewController(cv, animated: false, completion: nil)
 
        
        /*
        // Type 2
        let sb:UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let vc:VCNewRequest = sb.instantiateViewControllerWithIdentifier("sbid_newRequest") as! VCNewRequest
        vc.setProductID(url.host!)
        self.window?.rootViewController?.presentViewController(vc, animated: true, completion: nil)
        */
        
        /*
        // Type 3 : NotWorking
        let w:UIWindow = UIApplication.sharedApplication().keyWindow!
        let r:UIViewController = w.rootViewController!
        r.performSegueWithIdentifier("segue_newRequest", sender: self)
        */
        
        // Not working
        //r.presentedViewController?.removeFromParentViewController()
        //r.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
        //r.presentViewController(cv, animated: false, completion: nil)
        
        //ref : https://stackoverflow.com/questions/24854802/presenting-a-view-controller-modally-from-an-action-sheets-delegate-in-ios8-ios
        /*
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self presentViewController:vc animated:YES completion:nil];
            });

        */
        /*
        // TODO: Fix the bug. Its still not going to different viewcontrollers
        let nc:UINavigationController = UINavigationController(rootViewController: cv)
        w.rootViewController = nc
        w.makeKeyAndVisible()
        */
        
        //r.navigationController?.pushViewController(cv, animated: false)
        //r.navigationController?.presentViewController(cv, animated: false, completion: nil)
        
        //r.performSegueWithIdentifier("segue_newRequest", sender: self)
        //r.navigationController?.performSegueWithIdentifier("segue_newRequest", sender: self)
        
        
        
        //
        return true
    }
    

}

// MARK: Utility
extension AppDelegate{
    // Class method
    class func getAppDelegate()->AppDelegate{
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    // Instance method
    func showMessage(message: String,_ title:String="Note") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let dismissAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
        }
        
        alertController.addAction(dismissAction)
        
        let pushedViewControllers = (self.window?.rootViewController as! UINavigationController).viewControllers
        let presentedViewController = pushedViewControllers[pushedViewControllers.count - 1]
        
        presentedViewController.presentViewController(alertController, animated: true, completion: nil)
    }
    // MARK: Contacts Request Access
    func requestForAccess(completionHandler: (accessGranted: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatusForEntityType(CNEntityType.Contacts)
        
        switch authorizationStatus {
        case .Authorized:
            completionHandler(accessGranted: true)
            
        case .Denied, .NotDetermined:
            self.contactStore.requestAccessForEntityType(CNEntityType.Contacts, completionHandler: { (access, accessError) -> Void in
                if access {
                    completionHandler(accessGranted: access)
                }
                else {
                    if authorizationStatus == CNAuthorizationStatus.Denied {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let message = "\(accessError!.localizedDescription)\n\nPlease allow the app to access your contacts through the Settings."
                            self.showMessage(message)
                        })
                    }
                }
            })
            
        default:
            completionHandler(accessGranted: false)
        }
    }
}




