//
//  PIVDModel.swift
//  HZTB
//
//  Created by Pivotal on 7/5/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

// import Foundation

import RealmSwift

class PIVDModel: Object {
    dynamic var appName:String = "How is this Buddy"
    dynamic var appVersion:String = "1.0.0"
    dynamic var isDataSaved:Bool = false
}
