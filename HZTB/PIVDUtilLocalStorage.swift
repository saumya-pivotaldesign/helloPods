//
//  PIVDUtilLocalStorage.swift
//  HZTB
//
//  Created by Pivotal on 7/5/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class PIVDUtilLocalStorage {
    
    public static var realmRef:Realm?
    
    /*
    init( withRealm:Realm ){
        self.realmRef = withRealm
    }*/
    
    
    public static func testSave(){
        print("PIVDUtilLocalStorage : testSave :")
        let appInfo = PIVDModel()
        try! realmRef?.write({ 
            realmRef!.add(appInfo)
        })
    }
    public static func testGet(){
        print("PIVDUtilLocalStorage : testGet :")
        let appInfo = realmRef!.objects(PIVDModel.self)
        print(appInfo)
    }
    
    public static func initRealm() -> Bool {
        print("PIVDUtilLocalStorage : initRealm :")
        do {
            PIVDUtilLocalStorage.realmRef = try Realm()
            print("PIVDUtilLocalStorage : initRealm : done:",PIVDUtilLocalStorage.realmRef)
            return true
        } catch let error as NSError {
            print("PIVDUtilLocalStorage : initRealm : ERROR:")
            print(error)
        }
        return false
        
    }
    
}
