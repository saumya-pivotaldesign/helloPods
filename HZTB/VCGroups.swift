//
//  VCGroups.swift
//  HZTB
//
//  Created by Pivotal on 7/1/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class VCGroups: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableViewContacts:UITableView!
    
    var jsonGroups:JSON?
    var aGroups:[JSON]?
    var nGroups:Int = 0
    
    var items: [String] = ["Item 1","Item 2","Item 3", "Item 4", "Item 5"]
    //var serverContacts:[AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VCGroups : viewDidLoad : ")
        
        //print("Realm:",AppDelegate.getAppDelegate().realm)
        
        // self.tableViewContacts.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // print(AppDelegate.getAppDelegate().contactStore)
        
        //print("XXXXX")
        //print(AppDelegate.getAppDelegate().contactsFromServer)
        //print("XXXXX")
        //print(AppDelegate.getAppDelegate().contactsFromServer.count)
        //print("XXXXX")
        //print(AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].count)
        //print("XXXXX")
        //print(AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].array)
        //print("XXXXX")
        
        //PIVDUtilContact.getGroupsFromServer(self)
        
        //MARK: EventHandler Registrations
        NSNotificationCenter.defaultCenter().addObserver( self, selector:#selector(ongroupEditNotification),
                                                          name: PIVDStaticNames.GROUP_EDIT_ACTION, object: nil )
        NSNotificationCenter.defaultCenter().addObserver( self, selector:#selector(ongroupDeleteNotification),
                                                          name: PIVDStaticNames.GROUP_DELETE_ACTION, object: nil )
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("VCGroups : viewWillAppear : ")
        PIVDUtilContact.getGroupsFromServer(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("VCGroups : didReceiveMemoryWarning : ")
    }
    
    internal func onGotGroupsFromServer(result:JSON){
        print("VCGroups : onGotGroupsFromServer :   ===")
        
        self.jsonGroups = result
        self.aGroups = result.array
        self.nGroups = self.aGroups!.count
        
        
        let aGroups = result.array
        //let n = jsonOBJ.array?.count
        for group in aGroups! {
            print("VCGroups : Group   ================= ")
            print(group["groupName"].string)
            print(group)
            print("VCGroups : Group / ================= ")
        }
        print("VCGroups : onGotGroupsFromServer : / ===")
        
        self.tableViewContacts.reloadData()
        
    }// /onGotGroupsFromServer
}

//MARK: TableView delegates
extension VCGroups {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("VCGroups : tableView:numberOfRowsInSection: ")
        //return self.items.count;
        //return AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].count
        
        print("VCGroups : tableView:numberOfRowsInSection: nGroups",nGroups)
        
        return nGroups
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("VCGroups : tableView:cellForRowAtIndexPath: ")
        
        //print(indexPath.row,self.items[indexPath.row])

        //let cell:UITableViewCell = self.tableViewContacts.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
        //cell.textLabel?.text = self.items[indexPath.row]
        
        //print("xxxxx")
        //print(AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].array![indexPath.row]["name"])
        
        /*
        let cell:UITableViewCell = self.tableViewContacts.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        let sName = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].array![indexPath.row]["name"].string
        let sEmailAddress = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].array![indexPath.row]["emailAddress"].string
        let sMobileNumber = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].array![indexPath.row]["mobileNumber"].string
         
        cell.textLabel?.text = sName!+" "+sEmailAddress!+" "+sMobileNumber!
        */
        
        //print(sMobileNumber)
        //print("xxxxx")
        
        //cell.textLabel?.text = sEmailAddress
        //cell.textLabel?.text = sMobileNumber
        
        //cell.textLabel?.text = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].array![indexPath.row]["name"]
        
        /*
        let cell:UITableViewCell = self.tableViewContacts.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        let sGroupName = self.aGroups![indexPath.row]["groupName"].string
        cell.textLabel?.text = sGroupName
        */
        
        let cell:VCListItemGroupName = self.tableViewContacts.dequeueReusableCellWithIdentifier("cell")! as! VCListItemGroupName
        //let sGroupName = self.aGroups![indexPath.row]["groupName"].string
        //cell.labelGroupName?.text = sGroupName
        cell.setDataObj(self.aGroups![indexPath.row])
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("VCGroups : tableView:didSelectRowAtIndexPath: ")
        
        print("You have selected cell #\(indexPath.row)!")
        
        
        let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.redColor()
        
        
        
        print("============================")
        print(self.aGroups![indexPath.row])
        print("============================")
        
        let sb:UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let cv:VCGroupView = (sb.instantiateViewControllerWithIdentifier("sbid_viewGroup") as! VCGroupView)
        cv.setGroupData(self.aGroups![indexPath.row])
        cv.title = self.aGroups![indexPath.row]["groupName"].string
        self.navigationController?.pushViewController(cv, animated: true)
        
        //var serverContacts = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"]
        /*
        let tappedItem = listItems[indexPath.row] as ListItem
        tappedItem.completed = !tappedItem.completed
        
        // Store the updated tappedItem back at the listItems index
        listItems[indexPath.row] = tappedItem
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        */
    }
    
}

//MARK: event handlers
extension VCGroups {
    internal func ongroupEditNotification(notification:NSNotification){
        print("VCGroups : ongroupEditNotification : ")
        
        let myViewController:VCListItemGroupName = notification.object as! VCListItemGroupName
        
        let groupName = myViewController.getDataObj()["groupName"].string
        
        let sb:UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let cv:VCGroupCreate = (sb.instantiateViewControllerWithIdentifier("sbid_createGroup") as! VCGroupCreate)
        
        cv.isOnEditMode = true
        cv.editGroupName = groupName!
        cv.editGroupData = myViewController.getDataObj()
        cv.title = "Edit Group"
        
        //self.view.window?.rootViewController!.presentViewController(cv, animated: true, completion: nil)
        // -- not working -- // self.view.window?.rootViewController?.navigationController?.pushViewController(cv, animated: false)
        self.navigationController?.pushViewController(cv, animated: true)
        
    }
    internal func ongroupDeleteNotification(notification:NSNotification){
        print("VCGroups : ongroupDeleteNotification : ")
        //print("name=",notification.name)
        //print("object=",notification.object)
        //
        let myViewController:VCListItemGroupName = notification.object as! VCListItemGroupName
        //myViewController.someMethod()
        print("selected :",myViewController.selectedID)
        
        //AppDelegate.getAppDelegate().showMessage((myViewController.labelGroupName?.text)!, "Delete Group?")
        let groupName:String = myViewController.labelGroupName!.text!
        let msg = "Group Name - "+groupName
        
        let alert = UIAlertController(title: "Delete Group", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: { action in
            print("Cancel")
        }))
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            print("Ok")
            self.callServerToDeleteGroup(myViewController.selectedID)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
        //callServerToDeleteGroup(myViewController.selectedID)
    }
    internal func callServerToDeleteGroup(groupId:String){
        print("VCGroups : callServerToDeleteGroup : groupId:",groupId)
        // ================= START : removeGroup ==========================
        let url = "http://hztb-dev.us-east-1.elasticbeanstalk.com/group/removeGroup"
        
        let headers = [
            "Content-Type":"application/json",
            "Accept":"application/json",
            "Accept-Language":"en-US",
            "REQUEST_ID":"1",
            "Cache-Control":"no-store"
        ]
        let parameters = [
            "groupId" : groupId,
            "userId" : AppDelegate.getAppDelegate().sRegisteredUserId
        ]
        Alamofire.request(.POST, url,headers:headers, parameters:parameters , encoding: .JSON)
            .responseJSON { (response) in
                
                print("post : request=",response.request)
                print("post : response=",response.response)
                print("post : data=",response.data)
                print("post : result=",response.result)
                // SwiftyJSON
                //let json = JSON(data: dataFromNetworking)
                let jsonOBJ = JSON((response.result.value)!)
                
                print("===========================================")
                print("jsonOBJ=",jsonOBJ)
                print("jsonOBJ.status=",jsonOBJ["status"])
                //print("jsonOBJ[0]=",jsonOBJ[0])
                //print("jsonOBJ[1]=",jsonOBJ[1])
                //print("jsonOBJ['json']=",jsonOBJ["json"])
                //print("jsonOBJ[\"json\"][\"foo\"]=",jsonOBJ["json"]["foo"])
                if(jsonOBJ["status"] == "SUCCESS"){
                    self.onDeleteSuccess()
                }else{
                    self.onDeleteFail()
                }
                print("===========================================")
        }
        // ================= END : removeGroup ==========================
    }
    internal func onDeleteSuccess(){
        print("VCGroups : onDeleteSuccess ")
        PIVDUtilContact.getGroupsFromServer(self)
    }
    internal func onDeleteFail(){
        print("VCGroups : onDeleteFail ")
        AppDelegate.getAppDelegate().showMessage("Delete Group has failed. Try again.", "Fail")
    }
}

