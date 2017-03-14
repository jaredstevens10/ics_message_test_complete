//
//  MessageFunctions.swift
//  ICSmessageTestComplete
//
//  Created by Jared Stevens2 on 12/6/16.
//  Copyright © 2016 Jared Stevens. All rights reserved.
//

import Foundation
import UIKit

func SendMessage(_ toUser: String, fromUser: String, message: String ) -> (Bool) {
    
    
    //we are creating a true or false variable so we will know if the message went through or not
    var WasTheMessageSent = Bool()
    
    var messageTemp = message as! NSString
    
    var messageNew = messageTemp.addingPercentEscapes(using: String.Encoding.utf8.rawValue)!
    
    
    var post:NSString = "toUser=\(toUser)&fromUser=\(fromUser)&message=\(messageNew)" as NSString
    
    
    
  //  var post = post_old.addingPercentEscapes(using: String.Encoding.utf8.rawValue)!
    
    //***The web address of the newMessage.php file we created
    var url:URL = URL(string:"http://clavensolutions.com/Apps/ICSmessageTest/newMessage.php")!
    
    
    
    
    
    var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    var postLength:NSString = String( postData.count ) as NSString
    var request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    
    print("Post Data: \(post)")
    
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")

    var reponseError: NSError?
    var response: URLResponse?
    
    var urlData: Data?
    do {
        urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    } catch let error as NSError {
    
        print(error)
        urlData = nil
    }
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
            
            print("Response: \(responseData)")
            
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            

            
            //***let's find out the value of SUCCESS from the server file we created.
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            
            
            

            print("Success has a value of \(success)")
            
            

            
            if(success == 1)
            {
                WasTheMessageSent = true
                
            } else {
                
                WasTheMessageSent = false
                
                var error_msg:NSString
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                /*
                 
                 var alertView:UIAlertView = UIAlertView()
                 alertView.title = "Sign in Failed!"
                 alertView.message = error_msg as String
                 alertView.delegate = self
                 alertView.addButtonWithTitle("OK")
                 alertView.show()
                 
                 */
                
            }
            
        } else {
            
            WasTheMessageSent = false
            
        }
    } else {
        
        WasTheMessageSent = false
        
    }
    
    return WasTheMessageSent
}



func GetMessages(_ toUser: String) -> (Data) {
    
    var fromUser = String()
    var message = String()
    var date = String()
    
    //we are creating a true or false variable so we will know if the message went through or not
    var WasTheMessageSent = Bool()
    
    
    
    var post:NSString = "username=\(toUser)" as NSString
    

    
    
    //***The web address of the newMessage.php file we created
    var url:URL = URL(string:"http://clavensolutions.com/Apps/ICSmessageTest/getMessages.php")!
    
    
    
    print("post: \(post)")
    
    var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    var postLength:NSString = String( postData.count ) as NSString
    var request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    var reponseError: NSError?
    var response: URLResponse?
    
    var MainData = Data()
    
    var urlData: Data?
    do {
        urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    } catch let error as NSError {
        
        print(error)
        urlData = nil
    }
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
            
            print("response Data: \(responseData)")
            
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            
            //***let's find out the value of SUCCESS from the server file we created.
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            
            
            
            
            print("Success has a value of \(success)")
            
            
            
            
            if(success == 1)
            {
                
                
            MainData = urlData!
                
            } else {
                
                
                
                var error_msg:NSString
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                /*
                 
                 var alertView:UIAlertView = UIAlertView()
                 alertView.title = "Sign in Failed!"
                 alertView.message = error_msg as String
                 alertView.delegate = self
                 alertView.addButtonWithTitle("OK")
                 alertView.show()
                 
                 */
                
            }
            
        } else {
            
            
            
        }
    } else {
        
      
        
    }
    
    return MainData
}

func FilterCommentData(_ urlData: Data) -> [message] {
    
    //  var traits = [NSString]()
    var messageDataTemp = [message]()
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
    
    var json = JSON(jsonData)
    
    //println("Json value: \(jsonData)")
    // println("Json valueJSON: \(json)")
    
    
    
    for result in json["Data"].arrayValue {
        
       // print("Getting message info")
        
        if ( result["id"] != "NA") {
            
            let toUser = result["toUser"].stringValue
            let fromUser = result["fromUser"].stringValue
            
            let commentTemp3 = result["message"].stringValue
            let commentTemp2 = Data(base64Encoded: commentTemp3 as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
            
            let messageTemp = NSString(data: commentTemp2, encoding: String.Encoding.utf8.rawValue)!
            
           // print("message Temp: \(messageTemp)")
            
            
            //let dateTemp = result["datestamp"].stringValue
            let datetimeTemp = result["datetimestamp"].stringValue
            print("Date Time Temp: \(datetimeTemp)")
            let datetimeTempFormated = dateFormatter.date(from: datetimeTemp)
            print("Date Time Stamp: \(datetimeTempFormated)")
            
            messageDataTemp.append(message(message: messageTemp as String, fromUser: fromUser, dateInfo: datetimeTempFormated!))
            
            //let Temp = result["username"].stringValue
            //let userTemp = result["username"].stringValue
            
            
            
        }
    }
    
    
    //  }
    //print("Comment Data count = \(messageDataTemp)")
    return messageDataTemp
}

func RefreshMessage(username: String) -> [message] {
    
    
    var MessageInfoArray = [message]()
    
    let URLData = GetMessages(username)
    
    
    //DispatchQueue.main.async(execute: {
       
    MessageInfoArray = FilterCommentData(URLData)
    
   // print("Message Info Array: \(MessageInfoArray)")
    
       // print("Creating Local Inventory Data")
       // CreateLocalInventory(UserInfoNSData)
        
   // })
    
    
    return MessageInfoArray
    
   // self.TableView.reloadData()
    
    
}
