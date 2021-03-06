//
//  VCGroupCreate.swift
//  HZTB
//
//  Created by Pivotal on 7/18/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class VCGroupCreate: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var isOnEditMode:Bool = false // Used for Edit Group
    var editGroupName:String = "" // Used for Edit Group
    var editGroupData:JSON? // Used for Edit Group
    
    @IBOutlet var tableViewContacts:UITableView!
    @IBOutlet var groupNameTextField:UITextField!
    
    var jsonContacts:JSON?
    var aContacts:[JSON]?
    var nContacts:Int = 0
    
    var items: [String] = ["Item 1","Item 2","Item 3", "Item 4", "Item 5"]
    var itemsJSONArray:[JSON] = [JSON("name:one,mobileNumber:111111222222"),JSON("name:one,mobileNumber:111111222222")]
    var selectedIds:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        print("VCGroupCreate : viewDidLoad :")
        
        self.jsonContacts = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"]
        self.aContacts = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].array
        self.nContacts = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].count
        self.tableViewContacts.reloadData()
        
        print("VCGroupCreate : viewDidLoad : ===================================== ")
        print("VCGroupCreate : viewDidLoad : self.nContacts",self.nContacts)
        print("VCGroupCreate : viewDidLoad : self.jsonContacts",self.jsonContacts)
        print("VCGroupCreate : viewDidLoad : self.aContacts",self.aContacts)
        print("VCGroupCreate : viewDidLoad : ===================================== ")
        
        if(isOnEditMode){
            groupNameTextField.text = editGroupName
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //
    }
    
    @IBAction func onDone(sender:AnyObject){
        print("VCGroupCreate : onDone : ")
        if(self.isOnEditMode){
            print("TODO: Update the Group : ")
            print("For the timebeing its calling the CreateGroup API")
            callServerForCreateGroup()
        }else{
            callServerForCreateGroup()
        }
    }
}

//MARK: tableView protocol confirmation
extension VCGroupCreate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("VCGroupCreate : tableView:numberOfRowsInSection: ")
        print("nContacts : ",self.nContacts)
        
        //return self.items.count
        
        //return AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"].count
        
        //print("VCGroups : tableView:numberOfRowsInSection: nGroups",nGroups)
        
        return nContacts
        //return self.itemsJSONArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("VCGroupCreate : tableView:cellForRowAtIndexPath: ")
        
        //print(indexPath.row,self.items[indexPath.row])
        /*
        let cell:UITableViewCell = self.tableViewContacts.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.text = self.aContacts![indexPath.row]["name"].string
        */
        
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
        
        
        let cell:VCListItemContactName = self.tableViewContacts.dequeueReusableCellWithIdentifier("cell")! as! VCListItemContactName
        cell.setDataObj(self.aContacts![indexPath.row])
        
        //cell.setDataObj(self.itemsJSONArray[indexPath.row])
        //cell.imgProfilePic.image = UIImage(named: "delete")
        
        print("VCGroupCreate : tableView:cellForRowAtIndexPath: self.isOnEditMode ===== ")
        if(self.isOnEditMode){
            print("===============")
            //print(self.aContacts![indexPath.row])
            //print("==")
            //print(self.editGroupData)
            //print("---------")
            for item in self.editGroupData!["groupMembers"] {
                let j = item.1
                let userID1 = j["userId"]
                let userID2 = self.aContacts![indexPath.row]["userId"]
                
                //print("userID1",userID1)
                //print(self.aContacts![indexPath.row]["userId"])
                
                //print(userID1,userID2)
                //print(userID1.rawValue,userID2.rawValue)
                //print(userID1.intValue,userID2.stringValue)
                
                let a1 = Int(userID1.intValue)
                let a2 = Int(userID2.stringValue)
                
                //print( Int(a1)==Int(a2) )
                
                if (a1 == a2) {
                    //print("Mark it Selected")
                    self.selectedIds.append(userID2.string!)
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
            }
            //print("---------")
            
            //cell.contentView.setNeedsDisplay()
            //cell.layoutSubviews()
            //cell.setNeedsDisplay()
            //cell.setNeedsLayout()
            
            //cell.setSelected(true, animated: true)
            //cell.setSelected(false, animated: true)
            
            //tableViewContacts.scrollsToTop = true
            //tableViewContacts.flashScrollIndicators()
            
            print("===============")
        }
        print("VCGroupCreate : tableView:cellForRowAtIndexPath: self.isOnEditMode /===== ")
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("VCGroupCreate : tableView:didSelectRowAtIndexPath: ")
        //print("You have selected cell #\(indexPath.row)!")
        
        
        //let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        //selectedCell.contentView.backgroundColor = UIColor.redColor()
        //selectedCell.accessoryType = UITableViewCellAccessoryType.Checkmark
        
        let selectedCell:VCListItemContactName = tableView.cellForRowAtIndexPath(indexPath)! as! VCListItemContactName
        
        //print("data:",selectedCell.getDataObj())
        let userId:String = selectedCell.getDataObj()["userId"].string!
        //print("userId:",userId)
        //print("myId:",AppDelegate.getAppDelegate().sRegisteredUserId)
        
        //select/de-select
        if (selectedCell.accessoryType == UITableViewCellAccessoryType.Checkmark) {
            selectedCell.accessoryType = UITableViewCellAccessoryType.None
            //print("xxxxxxxxxx Remove xxxxxxxxxx",userId)
            let i = self.selectedIds.indexOf(userId)
            //print("index",i)
            self.selectedIds.removeAtIndex(i!)
        }else{
            selectedCell.accessoryType = UITableViewCellAccessoryType.Checkmark
            self.selectedIds.append(userId)
        }
        
        print(self.selectedIds)
        
        
        
        
        //var serverContacts = AppDelegate.getAppDelegate().contactsFromServer["userProfileResponses"]
        /*
         let tappedItem = listItems[indexPath.row] as ListItem
         tappedItem.completed = !tappedItem.completed
         
         // Store the updated tappedItem back at the listItems index
         listItems[indexPath.row] = tappedItem
         
         tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
         */
    }
    
    /*
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        print("VCGroupCreate : tableView:willDisplayCell:cell:forRowAtIndexPath:    ===== ")
        
        print("indexPath.row",indexPath.row)
        print("cell",cell)
        
        let cell:VCListItemContactName = self.tableViewContacts.dequeueReusableCellWithIdentifier("cell")! as! VCListItemContactName
        
        cell.contentView.setNeedsDisplay()
        cell.layoutSubviews()
        cell.setNeedsDisplay()
        cell.setNeedsLayout()
        
        // imgProfilePic.image = UIImage(named: "Bg")
        //cell.imgProfilePic.image = UIImage(named: "Bg")
        //cell.setNeedsDisplay()
        
        print("VCGroupCreate : tableView:willDisplayCell:cell:forRowAtIndexPath:  / ===== ")
    }*/
}

//MARK: server call
extension VCGroupCreate {
    private func callServerForCreateGroup(){
        print("VCGroupCreate:callServerForCreateGroup:")
        print(self.selectedIds)
        print(AppDelegate.getAppDelegate().sRegisteredUserId)
        print(self.groupNameTextField.text)
        
        // ================= START : createGroup ==========================
        let url = "http://hztb-dev.us-east-1.elasticbeanstalk.com/group/createGroup"
        
        let headers = [
            "Content-Type":"application/json",
            "Accept":"application/json",
            "Accept-Language":"en-US",
            "REQUEST_ID":"1",
            "Cache-Control":"no-store"
        ]
        let parameters = [
            "groupName" : self.groupNameTextField.text! as String,
            "userId" : AppDelegate.getAppDelegate().sRegisteredUserId,
            "addMembers":self.selectedIds
        ]
        Alamofire.request(.POST, url,headers:headers, parameters:parameters as? [String : AnyObject] , encoding: .JSON)
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
                print("===========================================")
                
                if(jsonOBJ["status"] == "SUCCESS"){
                    AppDelegate.getAppDelegate().showMessage("New Group Created.", "Success")
                }
        }
        // ================= END : createGroup ==========================
    }
    
    
    
}
