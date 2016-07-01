//
//  VCSlideMenu.swift
//  HZTB
//
//  Created by Pivotal on 5/25/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import UIKit

class VCSlideMenu : UIViewController {
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
    }
    @IBAction func handleTapOnGroupsGesture(sender: UITapGestureRecognizer) {
        print("VCSlideMenu : handleTapOnGroupsGesture : ")
    }
}








//