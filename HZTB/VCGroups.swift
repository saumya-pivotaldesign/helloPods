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
    
    var items: [String] = ["Item 1","Item 2","Item 3", "Item 4", "Item 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VCGroups : viewDidLoad : ")
        
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
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("VCGroups : didReceiveMemoryWarning : ")
    }
}

//MARK: TableView delegates
extension VCGroups {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("VCGroups : tableView:numberOfRowsInSection: ")
        //return self.items.count;
        
        return AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("VCGroups : tableView:cellForRowAtIndexPath: ")
        //print(indexPath.row,self.items[indexPath.row])
        
        //let cell:UITableViewCell = self.tableViewContacts.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
        
        let cell:UITableViewCell = self.tableViewContacts.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        //cell.textLabel?.text = self.items[indexPath.row]
        
        //print("xxxxx")
        //print(AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].array![indexPath.row]["name"])
        
        let sName = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].array![indexPath.row]["name"].string
        let sEmailAddress = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].array![indexPath.row]["emailAddress"].string
        let sMobileNumber = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].array![indexPath.row]["mobileNumber"].string
        
        //print(sMobileNumber)
        //print("xxxxx")
        
        
        //cell.textLabel?.text = sEmailAddress
        //cell.textLabel?.text = sMobileNumber
        
        cell.textLabel?.text = sName!+" "+sEmailAddress!+" "+sMobileNumber!
        
        //cell.textLabel?.text = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].array![indexPath.row]["name"]
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("VCGroups : tableView:didSelectRowAtIndexPath: ")
        
        print("You have selected cell #\(indexPath.row)!")
    }
    
}