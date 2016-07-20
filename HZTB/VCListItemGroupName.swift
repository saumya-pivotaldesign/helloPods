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
        
        let gID = self.dataObj!["groupId"]
        self.selectedID = String(gID)
        
        // Post the notification
        let notification = NSNotification(name: PIVDStaticNames.GROUP_EDIT_ACTION , object: self, userInfo:nil )
        NSNotificationCenter.defaultCenter().postNotification(notification)
        
    }
    @IBAction func onDeleteTap(sender:AnyObject){
        print("VCListItemGroupName:onDeleteTap:")
        
        let gID = self.dataObj!["groupId"]
        self.selectedID = String(gID)
        
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
    internal func getDataObj()->JSON{
        return self.dataObj!
    }
    
   
}


