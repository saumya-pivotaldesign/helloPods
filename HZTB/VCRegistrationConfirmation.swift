//
//  VCRegistrationConfirmation.swift
//  HZTB
//
//  Created by Pivotal on 6/28/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import UIKit

class VCRegistrationConfirmation: UIViewController {
    
    @IBOutlet var bg:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        print("VCRegistrationConfirmation : viewDidLoad : ")
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("VCRegistrationConfirmation : viewWillAppear : ")
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("VCRegistrationConfirmation : viewDidAppear : ")
        
        let url = NSURL(string: "http://lorempixel.com/g/40/620")
        if let data = NSData(contentsOfURL: url!) {
            bg!.image = UIImage(data: data)
        }
        
        //bg?.image = UIImage(data: "http://lorempixel.com/g/400/200")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //
        print("VCRegistrationConfirmation : didReceiveMemoryWarning : ")
    }
}
