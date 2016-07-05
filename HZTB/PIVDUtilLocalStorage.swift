//
//  PIVDUtilLocalStorage.swift
//  HZTB
//
//  Created by Pivotal on 7/5/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import Foundation
import Realm

class PIVDUtilLocalStorage {
    public static func testSave(){
        print("PIVDUtilLocalStorage : testSave :")
    }
    public static func testGet(){
        print("PIVDUtilLocalStorage : testGet :")
    }
    
    public static func initRealm() -> RLMRealm {
        print("PIVDUtilLocalStorage : initRealm :")
        let RealmRef:RLMRealm
        
        do {
            RealmRef = try RLMRealm()
            
            print("PIVDUtilLocalStorage : initRealm : done:",RealmRef)
            
        } catch let error as NSError {
            print("PIVDUtilLocalStorage : initRealm : ERROR:")
            print(error)
        }
        
        return RealmRef
    }
    
}
