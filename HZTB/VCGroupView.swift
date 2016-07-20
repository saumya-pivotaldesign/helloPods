//
//  VCGroupView.swift
//  HZTB
//
//  Created by Pivotal on 7/20/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import Foundation
import UIKit


class VCGroupView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableViewContacts:UITableView!
    
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
        return self.items.count
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