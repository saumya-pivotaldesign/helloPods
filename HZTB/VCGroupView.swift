//
//  VCGroupView.swift
//  HZTB
//
//  Created by Pivotal on 7/20/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON


class VCGroupView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableViewContacts:UITableView!
    
    var jGroupItems:JSON?
    var aGroupItems:[JSON]?
    var nGroupMembersCount:Int = 0
    
    var items: [String] = ["Item 1","Item 2","Item 3", "Item 4", "Item 5"] 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //
    }
    
}

//MARK: tableView protocol confirmation
extension VCGroupView {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("VCGroupView : tableView:numberOfRowsInSection: ")
        //return self.items.count
        //return (self.aGroupItems?.count)!
        return nGroupMembersCount
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("VCGroupView : tableView:cellForRowAtIndexPath: ")
        
        //let cell:UITableViewCell = self.tableViewContacts.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        let cell:VCListItemContactName = self.tableViewContacts.dequeueReusableCellWithIdentifier("cell")! as! VCListItemContactName
        //cell.setDataObj(self.aContacts![indexPath.row])
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("VCGroupView : tableView:didSelectRowAtIndexPath: ")
        
    }
}

//MARK: API extensions
extension VCGroupView {
    func setGroupData(jData:JSON){
        print("VCGroupView : setGroupData : ")
        self.jGroupItems = jData
        self.aGroupItems = jData["groupMembers"].array
        self.nGroupMembersCount = (self.aGroupItems!.count)
        
        print("= ================")
        print(jData)
        print(aGroupItems?.count)
        print(aGroupItems)
        print("/ ================")
        //print("VCGroupView : setGroupData : nGroupMembersCount",nGroupMembersCount)
        
        //self.tableViewContacts.reloadData()
    }
}