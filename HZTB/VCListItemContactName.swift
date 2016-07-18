//
//  VCListItemContactName.swift
//  HZTB
//
//  Created by Pivotal on 7/18/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import UIKit

import SwiftyJSON

class VCListItemContactName: UITableViewCell {
    
    private var dataObj:JSON?
    
    @IBOutlet var labelContactName:UILabel?
    @IBOutlet var labelContactNumber:UILabel?
    
    // Setter
    internal func setDataObj(data:JSON){
        print("VCListItemContactName:setData:",data)
        self.dataObj=data
        self.labelContactName?.text = self.dataObj!["name"].string
        self.labelContactNumber?.text = self.dataObj!["mobileNumber"].string
    }
    
    internal func getDataObj()->JSON{
        return self.dataObj!
    }
    
    
}


