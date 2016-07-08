//
//  VCGroups.swift
//  HZTB
//
//  Created by Pivotal on 7/1/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class VCGroups: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableViewContacts:UITableView!
    
    var jsonGroups:JSON?
    var aGroups:[JSON]?
    var nGroups:Int = 0
    
    var items: [String] = ["Item 1","Item 2","Item 3", "Item 4", "Item 5"]
    //var serverContacts:[AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VCGroups : viewDidLoad : ")
        
        //print("Realm:",AppDelegate.getAppDelegate().realm)
        
        // self.tableViewContacts.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // print(AppDelegate.getAppDelegate().contactStore)
        
        //print("XXXXX")
        //print(AppDelegate.getAppDelegate().contactsFromServer)
        //print("XXXXX")
        //print(AppDelegate.getAppDelegate().contactsFromServer.count)
        //print("XXXXX")
        //print(AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].count)
        //print("XXXXX")
        //print(AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].array)
        //print("XXXXX")
        
        PIVDUtilContact.getGroupsFromServer(self)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("VCGroups : didReceiveMemoryWarning : ")
    }
    
    internal func onGotGroupsFromServer(result:JSON){
        print("VCGroups : onGotGroupsFromServer :   ===")
        
        self.jsonGroups = result
        self.aGroups = result.array
        self.nGroups = self.aGroups!.count
        
        
        let aGroups = result.array
        //let n = jsonOBJ.array?.count
        for group in aGroups! {
            print("VCGroups : Group   ================= ")
            print(group["groupName"].string)
            print(group)
            print("VCGroups : Group / ================= ")
        }
        print("VCGroups : onGotGroupsFromServer : / ===")
        
        self.tableViewContacts.reloadData()
        
    }// /onGotGroupsFromServer
}

//MARK: TableView delegates
extension VCGroups {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("VCGroups : tableView:numberOfRowsInSection: ")
        //return self.items.count;
        //return AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].count
        
        print("VCGroups : tableView:numberOfRowsInSection: nGroups",nGroups)
        
        return nGroups
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("VCGroups : tableView:cellForRowAtIndexPath: ")
        
        //print(indexPath.row,self.items[indexPath.row])

        //let cell:UITableViewCell = self.tableViewContacts.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
        //cell.textLabel?.text = self.items[indexPath.row]
        
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
        
        let cell:VCListItemGroupName = self.tableViewContacts.dequeueReusableCellWithIdentifier("cell")! as! VCListItemGroupName
        //let sGroupName = self.aGroups![indexPath.row]["groupName"].string
        //cell.labelGroupName?.text = sGroupName
        cell.setDataObj(self.aGroups![indexPath.row])
        
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