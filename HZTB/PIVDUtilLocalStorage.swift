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
    
    private var realmRef:Realm?
    private var pivdModel:PIVDModel?
    
    
    init( withRealm:Realm,andPivdModel:PIVDModel ){
        print("PIVDUtilLocalStorage:init:")
        
        self.realmRef = withRealm
        self.pivdModel = andPivdModel
    }
    
    public func saveUserId(userId:String,AndPhone:String){
        print("PIVDUtilLocalStorage: saveUserId:AndPhone:   ===")
        do{
            self.realmRef?.beginWrite()
            
            self.pivdModel!.registeredUserId = userId
            self.pivdModel!.registeredMobileNumber = AndPhone
            
            try self.realmRef?.commitWrite()
            
            print("Write SUCCESS === ")
            
        }catch let error as NSError{
            print("Write ERROR  === ")
            print(error)
            print("Write ERROR /=== ")
        }
        print("PIVDUtilLocalStorage: saveUserId:AndPhone: / ===")
    }
    
    public func saveName(name:String,Email:String){
        print("PIVDUtilLocalStorage: saveName:Email:   ===")
        do{
            self.realmRef?.beginWrite()
            
            self.pivdModel!.registeredName = name
            self.pivdModel!.registeredEmailAddress = Email
            
            try self.realmRef?.commitWrite()
            
            print("Write SUCCESS === ")
            
        }catch let error as NSError{
            print("Write ERROR  === ")
            print(error)
            print("Write ERROR /=== ")
        }
        print("PIVDUtilLocalStorage: saveName:Email: / ===")
    }
    
}
