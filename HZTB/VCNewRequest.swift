//
//  VCNewRequest.swift
//  HZTB
//
//  Created by Pivotal on 5/23/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import UIKit
import ContactsUI

public class VCNewRequest: UIViewController, CNContactPickerDelegate,
                    UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Profile Image
    @IBOutlet var imageView:UIImageView!
    @IBOutlet var productIdField:UILabel!
    
    private var pidFromExternal:String = "000000"
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        //
        print("VCNewRequest : initialisation : ")
        //
        productIdField.text = pidFromExternal
    }
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("VCNewRequest : viewWillAppear : ")
    }
    
    @IBAction func onViewContacts(sender: AnyObject){
        showNativeContactsUI()
    }
    
    // displaying Native Contacts UI
    private func showNativeContactsUI(){
        let contactPickerViewController = CNContactPickerViewController()
        
        // Filter the contacts
        //contactPickerViewController.predicateForEnablingContact = NSPredicate(format: "birthday != nil")
        
        contactPickerViewController.delegate = self
        
        // Display only what you need
        //contactPickerViewController.displayedPropertyKeys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey, CNContactBirthdayKey, CNContactImageDataKey]
        
        // Finally present the UI
        presentViewController(contactPickerViewController, animated: true, completion: nil)
    }
    
    
    // MARK: Delegate Methods : Contacts
    /*
     // single selection
     func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
     print("contactPicker : didSelectContact")
     //delegate.didFetchContacts([contact])
     print(contact)
     }*/
    
    // multi select
    public func contactPicker(picker: CNContactPickerViewController, didSelectContacts contacts: [CNContact]){
        print("contactPicker : didSelectContacts")
        print(contacts)
    }
    
    // MARK: Delegate Methods : Camera
    public func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Storyboard Expose for Photos/Camera
    @IBAction func onShowExistingPhotosFromPhotoLib(sender:AnyObject){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        self.presentViewController(picker, animated: true, completion: nil)
    }
    @IBAction func onShowExistingPhotosFromCamera(sender:AnyObject){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        self.presentViewController(picker, animated: true, completion: nil)
    }
    @IBAction func onInvitation(sender:AnyObject){
        print("onInvitation")
        
        // move back to rootViewController
        //self.view.window!.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
        //
        /*
        // When came from Weblink
        self.view.window!.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
        // When came from UI
        self.navigationController?.popToRootViewControllerAnimated(true)
        */
        
        // Currently we are just checking the value,but a better fix would be to use another variable for identification
        if(self.pidFromExternal=="000000"){
            // from webLink
            self.navigationController?.popToRootViewControllerAnimated(true)
        }else{
            // from UI
            self.view.window!.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
}

//MARK: Public API
extension VCNewRequest{
    public func setProductID(pid:String){
        //self.productIdField.text = pid
        print("setProductID")
        print(pid)
        self.pidFromExternal = pid
    }
}
