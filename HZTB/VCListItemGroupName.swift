//
//  VCListItemGroupName.swift
//  HZTB
//
//  Created by Pivotal on 7/8/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import UIKit


class VCListItemGroupName: UITableViewCell {
    
    @IBOutlet var labelGroupName:UILabel?
    
    @IBAction func onEditTap(sender:AnyObject){
        print("VCListItemGroupName:onEditTap:")
        print(sender)
    }
    @IBAction func onDeleteTap(sender:AnyObject){
        print("VCListItemGroupName:onDeleteTap:")
        print(sender)
    }
    
   
}


