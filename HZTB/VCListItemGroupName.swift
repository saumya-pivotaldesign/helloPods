//
//  VCListItemGroupName.swift
//  HZTB
//
//  Created by Pivotal on 7/8/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import UIKit

import SwiftyJSON

class VCListItemGroupName: UITableViewCell {
    
    private var dataObj:JSON?
    
    @IBOutlet var labelGroupName:UILabel?
    
    internal var selectedID:String = ""
    
    
    @IBAction func onEditTap(sender:AnyObject){
        print("VCListItemGroupName:onEditTap:")
        print(dataObj)
    }
    @IBAction func onDeleteTap(sender:AnyObject){
        print("VCListItemGroupName:onDeleteTap:")
        print("VCListItemGroupName:onDeleteTap:dataObj:",dataObj)
        
        let gID = dataObj!["groupId"]
        print("VCListItemGroupName:onDeleteTap:selected Id:",gID)
        
        self.selectedID = String(gID)
        
        //let uID = AppDelegate.getAppDelegate().sRegisteredUserId
        // delete the group
        //print(gID,uID)
        //GROUP_DELETE_ACTION
        // Post the notification
        let notification = NSNotification(name: PIVDStaticNames.GROUP_DELETE_ACTION , object: self, userInfo:nil )
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    
    // Setter
    internal func setDataObj(data:JSON){
        print("VCListItemGroupName:setData:",data)
        self.dataObj=data
        
        //self.labelGroupName = self.aGroups![indexPath.row]["groupName"].string
        //cell.labelGroupName?.text = sGroupName
        self.labelGroupName?.text = self.dataObj!["groupName"].string
    }
    
   
}


