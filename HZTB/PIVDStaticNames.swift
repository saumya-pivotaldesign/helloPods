//
//  PIVDEventNames.swift
//  HZTB
//
//  Created by Pivotal on 6/24/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

struct PIVDStaticNames {
    // MARK: Events
    internal static let CONTACT_FETCH_SUCCESS:String = "contactFetchSuccess"
    internal static let REGISTRATION_SUCCESS:String = "registrationSuccess"
    internal static let OTP_SUCCESS:String = "OTPValidationSuccess"
    internal static let PROFILE_UPDATE_SUCCESS:String = "profileUpdateSuccess"
    internal static let GROUP_DELETE_ACTION:String = "groupDeleteAction"
    internal static let GROUP_EDIT_ACTION:String = "groupEditAction"
    
    // Links
    internal static let LINK_PROFILE_TAP:String = "onProfileLinkTap"
    internal static let LINK_SETTINGS_TAP:String = "onSettingsLinkTap"
    internal static let LINK_GROUPS_TAP:String = "onGroupsLinkTap"
    
    // MARK: localstorage keys
    internal static let IS_CONTACT_SAVED:String = "isContactSaved" // saved in storeage as Bool
    internal static let ALL_CONTACTS_AS_STRING:String = "allContactsAsString" 
    
    
    // MARK: Flags
    //internal static let IS_REGISTERED:Bool = false
    
    
}
