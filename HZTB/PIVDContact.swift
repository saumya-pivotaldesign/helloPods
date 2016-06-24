//
//  PIVDContact.swift
//  HZTB
//
//  Created by Pivotal on 6/24/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//


// Maps CNContact to Application Contact
// if contact:CNContact then
// contact.identifier,contact.givenName,contact.familyName,contact.phoneNumbers.count
// contact.phoneNumbers[0].value as! CNPhoneNumber).valueForKey("digits") as! String


import Foundation

struct PIVDContact {
    //print(contact.identifier,contact.givenName,contact.familyName,contact.phoneNumbers.count)
    //print ( (contact.phoneNumbers[0].value as! CNPhoneNumber).valueForKey("digits") as! String)
    var identifier:String = ""
    var givenName:String = ""
    var familyName:String = ""
    var phoneNumber_digits:String = ""
    var countryCode:String = ""
}