//
//  UtilREST.swift
//  HZTB
//
//  Created by Pivotal on 6/16/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

class PIVDUtilREST {
    
//MARK: Test calls
    // Test API call
    internal func callRESTtestWith_dataTaskWithUrl(){
        print("callRESTtestWith_dataTaskWithUrl")
        
        let sURL:NSURL = NSURL(string: "https://httpbin.org/get")!
        let session:NSURLSession = NSURLSession.sharedSession()
        let dataTask:NSURLSessionDataTask = session.dataTaskWithURL(sURL) { (data:NSData?, response:NSURLResponse?, error:NSError?) in
            
            do {
                print("Success")
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as!NSDictionary
                // use jsonData
                NSLog("%@", jsonData)
            } catch {
                // report error
                print("ERROR")
            }
        }
        // finally call this
        dataTask.resume()
        //
    }
    // REST call with POST
    internal func callRESTtestWith_dataTaskWithRequest(){
        // uses : dataTaskWithRequest
        print("callRESTtestWith_dataTaskWithRequest")
        
        let sURL:NSURL = NSURL(string: "https://httpbin.org/post")!; // post - request
        let session:NSURLSession = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: sURL)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        let paramString = "data=Hello"
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let dataTask:NSURLSessionDataTask = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) in
            print("json data")
            do {
                print("do")
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as!NSDictionary
                // use jsonData
                NSLog("%@", jsonData)
            } catch {
                // report error
                print("ERROR")
            }
        }
        
        // finally call this
        dataTask.resume()
        //
    }
//MARK: Alamofire START
    internal func test_GET(){
        print("test_GET : AlamofireVersionNumber =",AlamofireVersionNumber)
        Alamofire.request(.GET, "http://httpbin.org/get")
            .response { (request, response, data, error) in
                print("get : request=",request)
                print("get : response=",response)
                print("get : data=",data)
                print("get : error=",error)
            }
        /*
        Alamofire.request(.GET, "http://httpbin.org/get")
            .responseString { (string) in
                print(string)
            }
        Alamofire.request(.GET, "http://httpbin.org/get")
            .responseJSON {(JSON) in
                print(JSON)
            }
        */
    }
    internal func test_POST(){
        print("test_POST : AlamofireVersionNumber =",AlamofireVersionNumber)
        // ref : https://resttesttest.com/
        /*
        Alamofire.request(.POST, "https://httpbin.org/post",parameters: ["foo": "bar"], encoding: .JSON)
            .response { (request, response, data, error) in
                print("post : request=",request)
                print("post : response=",response)
                print("post : data=",data)
                print("post : error=",error)
        }
        */
        
        
        Alamofire.request(.POST, "https://httpbin.org/post", parameters: ["foo": "bar"], encoding: .JSON)
            .responseJSON { (response) in
                print("post : request=",response.request)
                print("post : response=",response.response)
                print("post : data=",response.data)
                print("post : result=",response.result)
                /*
                if let JSON1 = response.result.value {
                    print("JSON1: \(JSON1)")
                }*/
                
                // SwiftyJSON
                //let json = JSON(data: dataFromNetworking)
                let jsonOBJ = JSON((response.result.value)!)

                print("===========================================")
                print("jsonOBJ=",jsonOBJ)
                print("jsonOBJ[0]=",jsonOBJ[0])
                print("jsonOBJ[1]=",jsonOBJ[1])
                print("jsonOBJ['json']=",jsonOBJ["json"])
                print("jsonOBJ[\"json\"][\"foo\"]=",jsonOBJ["json"]["foo"])
                print("===========================================")
        }
    }
    internal func callServerForRegistration(vcRef:VCRegistration,sPhone:String){
        print("PIVDUtilREST : callServerForRegistration : ")
        
        // register
        let url = "http://hztb-dev.us-east-1.elasticbeanstalk.com/user/register"
        let headers = [
            "Content-Type":"application/json",
            "Accept":"application/json",
            "Accept-Language":"en-US",
            "REQUEST_ID":"1"
        ]
        let parameters = [
            "mobileNumber":sPhone
        ]
        Alamofire.request(.POST, url,headers:headers, parameters:parameters , encoding: .JSON)
            .responseJSON { (response) in
                /*
                print("post : request=",response.request)
                print("post : response=",response.response)
                print("post : data=",response.data)
                print("post : result=",response.result)
                
                if let JSON1 = response.result.value {
                 print("JSON1: \(JSON1)")
                }
                */
                
                var s = String(response.result)
                var sResultMessage:String = ""
                
                if(s == "SUCCESS"){
                    // SwiftyJSON
                    //let json = JSON(data: dataFromNetworking)
                    let jsonOBJ = JSON((response.result.value)!)
                    //let mobileNum = jsonOBJ["mobileNumber"]
                    
                    print("PIVDUtilREST : callServerForRegistration : =========================================== SUCCESS ")
                    print("jsonOBJ=",jsonOBJ)
                    print("jsonOBJ[\"mobileNumber\"]=",jsonOBJ["mobileNumber"]) // SUCCESS
                    //print("jsonOBJ.header.errors.message=",jsonOBJ["header"]["errors"][0]["message"]) // FAIL
                    // Success: will get MobileNumber
                    // Fail: will get error message
                    // print("====== mobileNum ====",mobileNum.isEmpty)
                    
                    print("================ jsonOBJ[\"mobileNumber\"].string=",jsonOBJ["mobileNumber"].string)
                    
                    if(jsonOBJ["mobileNumber"].string==nil){
                        print("===== IF =====")
                        s = "ERROR"
                        sResultMessage = jsonOBJ["header"]["errors"][0]["message"].string!
                    }
                    
                    print("PIVDUtilREST : callServerForRegistration : =========================================== /SUCCESS ")
                }else{
                    print("PIVDUtilREST : callServerForRegistration : =========================================== ERROR ")
                    print("response=",response.response)
                    print("data=",response.data)
                    print("description=",response.description)
                    print("PIVDUtilREST : callServerForRegistration : =========================================== /ERROR ")
                }
                // callback
                vcRef.onRegistrationCallResult(s, resultMessage: sResultMessage)
                //
        }
    }
    internal func callServerForPing(){
        // ping
        let url = "http://hztb-dev.us-east-1.elasticbeanstalk.com/user/ping"
        let headers = [
            "Content-Type":"application/json",
            "Accept":"application/json",
            "Accept-Language":"en-US",
            "REQUEST_ID":"1212"
        ]
        let parameters = [
            "mobileNumber" : "18479874489",
            "imei" : "dummyimei"
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
                print("jsonOBJ[0]=",jsonOBJ[0])
                print("jsonOBJ[1]=",jsonOBJ[1])
                print("jsonOBJ['json']=",jsonOBJ["json"])
                print("jsonOBJ[\"json\"][\"foo\"]=",jsonOBJ["json"]["foo"])
                print("===========================================")
        }
    }
//MARK: Alamofire END
}
