//
//  UtilREST.swift
//  HZTB
//
//  Created by Pivotal on 6/16/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import Foundation
import Alamofire

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
        Alamofire.request(.POST, "https://httpbin.org/post",parameters: ["foo": "bar"])
            .response { (request, response, data, error) in
                print("post : request=",request)
                print("post : response=",response)
                print("post : error=",error)
        }
    }
//MARK: Alamofire END
}
