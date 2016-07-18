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
    
    var jsonContacts:JSON?
    var aContacts:[JSON]?
    var nContacts:Int = 0
    
    var items: [String] = ["Item 1","Item 2","Item 3", "Item 4", "Item 5"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        print("VCGroupCreate : viewDidLoad :")
        
        self.jsonContacts = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"]
        self.aContacts = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].array
        self.nContacts = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].count
        self.tableViewContacts.reloadData()
        
        print("VCGroupCreate : viewDidLoad : ===================================== ")
        print("VCGroupCreate : viewDidLoad : self.nContacts",self.nContacts)
        print("VCGroupCreate : viewDidLoad : self.jsonContacts",self.jsonContacts)
        print("VCGroupCreate : viewDidLoad : self.aContacts",self.aContacts)
        print("VCGroupCreate : viewDidLoad : ===================================== ")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //
    }
}

//MARK: tableView protocol confirmation
extension VCGroupCreate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("VCGroupCreate : tableView:numberOfRowsInSection: ")
        print("nContacts : ",self.nContacts)
        
        //return self.items.count
        
        //return AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].count
        
        //print("VCGroups : tableView:numberOfRowsInSection: nGroups",nGroups)
        
        return nContacts
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("VCGroupCreate : tableView:cellForRowAtIndexPath: ")
        
        //print(indexPath.row,self.items[indexPath.row])
        /*
        let cell:UITableViewCell = self.tableViewContacts.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.text = self.aContacts![indexPath.row]["name"].string
        */
        
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
        
        
        let cell:VCListItemContactName = self.tableViewContacts.dequeueReusableCellWithIdentifier("cell")! as! VCListItemContactName
        cell.setDataObj(self.aContacts![indexPath.row])
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("VCGroupCreate : tableView:didSelectRowAtIndexPath: ")
        
        print("You have selected cell #\(indexPath.row)!")
        
        
        //let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        //selectedCell.contentView.backgroundColor = UIColor.redColor()
        //selectedCell.accessoryType = UITableViewCellAccessoryType.Checkmark
        
        let selectedCell:VCListItemContactName = tableView.cellForRowAtIndexPath(indexPath)! as! VCListItemContactName
        
        //select/de-select
        if (selectedCell.accessoryType == UITableViewCellAccessoryType.Checkmark) {
            selectedCell.accessoryType = UITableViewCellAccessoryType.None
        }else{
            selectedCell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        //print("data:",selectedCell.getDataObj())
        let userId:String = selectedCell.getDataObj()["userId"].string!
        print("userId:",userId)
        
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