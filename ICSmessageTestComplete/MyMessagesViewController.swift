//
//  MyMessagesViewController.swift
//  ICSmessageTestComplete
//
//  Created by Jared Stevens2 on 1/9/17.
//  Copyright © 2017 Jared Stevens. All rights reserved.
//

import UIKit

class MyMessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var username = String()
    
    
    var AllMessages = [message]()
    
    
    @IBOutlet weak var TableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.username = UserDefaults.standard.value(forKey: "MyUserName") as! String
        
        TableView.delegate = self
        TableView.dataSource = self
        
        self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.value(forKey: "MyUserName") != nil {
        
           self.username = UserDefaults.standard.value(forKey: "MyUserName") as! String
            
        } else {
            
            self.username = "guest"
        }
        
        AllMessages = RefreshMessage(username: username)
        self.TableView.reloadData()
        //GetMessages(username)
        
    }
    
    
    @IBAction func closeBTn(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return AllMessages.count
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
        
        var messageInfo: message?
        
        messageInfo = AllMessages[indexPath.row]
        
        cell.messageLBL.layer.borderWidth = 1
        
        cell.messageLBL.text = (messageInfo?.message)! as String
        cell.dateLBL.text = (messageInfo?.dateInfo.description)! as String
        cell.userLBL.text = (messageInfo?.fromUser)! as String
        
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



