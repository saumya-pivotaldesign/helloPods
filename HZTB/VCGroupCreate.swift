//
//  VCGroupCreate.swift
//  HZTB
//
//  Created by Pivotal on 7/18/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class VCGroupCreate: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableViewContacts:UITableView!
    
    var jsonGroups:JSON?
    var aGroups:[JSON]?
    var nGroups:Int = 0
    
    var items: [String] = ["Item 1","Item 2","Item 3", "Item 4", "Item 5"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        print("VCGroupCreate : viewDidLoad :")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //
    }
}

//MARK: tableView protocol confirmation
extension VCGroupCreate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("VCGroups : tableView:numberOfRowsInSection: ")
        return self.items.count;
        
        //return AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].count
        
        //print("VCGroups : tableView:numberOfRowsInSection: nGroups",nGroups)
        
        //return nGroups
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("VCGroups : tableView:cellForRowAtIndexPath: ")
        
        //print(indexPath.row,self.items[indexPath.row])
        
        let cell:UITableViewCell = self.tableViewContacts.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.text = self.items[indexPath.row]
        
        //print("xxxxx")
        //print(AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].array![indexPath.row]["name"])
        
        /*
         let cell:UITableViewCell = self.tableViewContacts.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
         
         let sName = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].array![indexPath.row]["name"].string
         let sEmailAddress = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].array![indexPath.row]["emailAddress"].string
         let sMobileNumber = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].array![indexPath.row]["mobileNumber"].string
         
         cell.textLabel?.text = sName!+" "+sEmailAddress!+" "+sMobileNumber!
         */
        
        //print(sMobileNumber)
        //print("xxxxx")
        
        //cell.textLabel?.text = sEmailAddress
        //cell.textLabel?.text = sMobileNumber
        
        //cell.textLabel?.text = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].array![indexPath.row]["name"]
        
        /*
         let cell:UITableViewCell = self.tableViewContacts.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
         let sGroupName = self.aGroups![indexPath.row]["groupName"].string
         cell.textLabel?.text = sGroupName
         */
        
        /*
        let cell:VCListItemGroupName = self.tableViewContacts.dequeueReusableCellWithIdentifier("cell")! as! VCListItemGroupName
        //let sGroupName = self.aGroups![indexPath.row]["groupName"].string
        //cell.labelGroupName?.text = sGroupName
        cell.setDataObj(self.aGroups![indexPath.row])
        */
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("VCGroups : tableView:didSelectRowAtIndexPath: ")
        
        print("You have selected cell #\(indexPath.row)!")
        
        
        let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.redColor()
        
        //var serverContacts = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"]
        /*
         let tappedItem = listItems[indexPath.row] as ListItem
         tappedItem.completed = !tappedItem.completed
         
         // Store the updated tappedItem back at the listItems index
         listItems[indexPath.row] = tappedItem
         
         tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
         */
    }
}