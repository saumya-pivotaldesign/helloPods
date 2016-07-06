//
//  VCSlideMenu.swift
//  HZTB
//
//  Created by Pivotal on 5/25/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import UIKit

class VCSlideMenu : UIViewController {
    
    //MARK: circular Image
    @IBOutlet var profileImage:UIImageView?
    
    
    // 1
    var interactor:Interactor? = nil
    // 2
    @IBAction func handleGesture(sender: UIPanGestureRecognizer) {
        // 3
        let translation = sender.translationInView(view)
        // 4
        let progress = MenuHelper.calculateProgress(
            translation,
            viewBounds: view.bounds,
            direction: .Left
        )
        // 5
        MenuHelper.mapGestureStateToInteractor(
            sender.state,
            progress: progress,
            interactor: interactor){
                // 6
                self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func closeMenu(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

//MARK: Menu Items Gesture Handlers
extension VCSlideMenu {
    @IBAction func handleTapOnProfileGesture(sender: UITapGestureRecognizer) {
        print("VCSlideMenu : handleTapOnProfileGesture : ")
        closeMenu(self)
        // Post the notification
        let notification = NSNotification(name: PIVDStaticNames.LINK_PROFILE_TAP , object: self, userInfo:nil )
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    @IBAction func handleTapOnSettingsGesture(sender: UITapGestureRecognizer) {
        print("VCSlideMenu : handleTapOnSettingsGesture : ")
        closeMenu(self)
        // Post the notification
        let notification = NSNotification(name: PIVDStaticNames.LINK_SETTINGS_TAP , object: self, userInfo:nil )
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    @IBAction func handleTapOnGroupsGesture(sender: UITapGestureRecognizer) {
        print("VCSlideMenu : handleTapOnGroupsGesture : ")
        closeMenu(self)
        // Post the notification
        let notification = NSNotification(name: PIVDStaticNames.LINK_GROUPS_TAP , object: self, userInfo:nil )
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
}

//MARK: Circular Image
extension VCSlideMenu {
    override func viewWillAppear(animated: Bool) {
        print("VCSlideMenu : viewWillAppear : ")
        super.viewWillAppear(animated)
        setStyleCircleForImage(profileImage!)
    }

    private func setStyleCircleForImage(imgView:UIImageView){
        print("VCSlideMenu : setStyleCircleForImage : ")
        imgView.layer.cornerRadius = imgView.frame.size.height / 1.3
        //imgView.layer.cornerRadius = imgView.frame.size.width / 2.5
        imgView.clipsToBounds = true
    }
    
}








//