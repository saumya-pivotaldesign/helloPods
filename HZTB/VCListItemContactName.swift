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
    @IBOutlet var imgProfilePic:UIImageView!
    
    
    override func didMoveToWindow() {
        print("VCListItemContactName:didMoveToWindow")
    }
    override func didMoveToSuperview() {
        print("VCListItemContactName:didMoveToSuperview")
        
        //self.imgProfilePic.layer.masksToBounds = true
        //self.contentView.addSubview(imgProfilePic)
        /*
        self.imgProfilePic.setNeedsDisplay()
        self.imgProfilePic.setNeedsLayout()
        self.setNeedsDisplay()
        self.setNeedsLayout()
        
        self.layoutSubviews()
        */
    }
    
    // Setter
    internal func setDataObj(data:JSON){
        print("VCListItemContactName:setData:",data)
        print("VCListItemContactName:setData:   ==========")
        
        
        self.dataObj=data
        self.labelContactName?.text = self.dataObj!["name"].string
        self.labelContactNumber?.text = self.dataObj!["mobileNumber"].string
        
        print("dataObj![name]",dataObj!["name"])
        print("dataObj![mobileNumber]",dataObj!["mobileNumber"])
        self.labelContactName?.text = "Dummy Name"
        self.labelContactNumber?.text = "0010000000"
        
        
        //self.imgProfilePic.image = UIImage(named: "Profile-Pic-2200x2200.jpg") // working
        self.imgProfilePic.image = UIImage(named: "delete") // Set an image : works
        
        //circular image
        // ref : https://stackoverflow.com/questions/28074679/how-to-set-image-in-circle-in-swift
        /*
        imgProfilePic.layer.cornerRadius = imgProfilePic.frame.size.height/2
        imgProfilePic.layer.borderWidth = 1
        imgProfilePic.layer.borderColor = UIColor.blueColor().CGColor
        imgProfilePic.clipsToBounds = true
        */
        
        /*
         // circular image
        let radius = CGRectGetWidth(imgProfilePic.frame) / 2
        imgProfilePic.layer.cornerRadius = radius
        //imgProfilePic.layer.cornerRadius = imgProfilePic.frame.size.height/2
        imgProfilePic.layer.borderWidth = 1
        imgProfilePic.layer.masksToBounds = true
        */
        
        //let radius = CGRectGetWidth(imgProfilePic.frame) / 2
        //imgProfilePic.layer.cornerRadius = radius
        //imgProfilePic.layer.cornerRadius = imgProfilePic.frame.size.height/2
        //imgProfilePic.layer.borderWidth = 1
        //imgProfilePic.layer.masksToBounds = true
        //imgProfilePic.clipsToBounds = true
        
        
        let radius = CGRectGetWidth(imgProfilePic.frame) / 2
        imgProfilePic.layer.cornerRadius = radius
        imgProfilePic.layer.borderWidth = 2
        imgProfilePic.layer.borderColor = UIColor.blueColor().CGColor
        //imgProfilePic.layer.masksToBounds = true // Fix this
        //imgProfilePic.contentMode = .ScaleAspectFit
        //imgProfilePic.contentMode = .ScaleAspectFill
        //imgProfilePic.clipsToBounds = true // Fix this.
        
        //
        
        /*
        self.imgProfilePic.setNeedsDisplay()
        self.imgProfilePic.setNeedsLayout()
        self.setNeedsDisplay()
        self.setNeedsLayout()
        
        self.layoutSubviews()
        */
        
        print("VCListItemContactName:setData: / ==========")
    }
    
    internal func getDataObj()->JSON{
        return self.dataObj!
    }
    
    
}


