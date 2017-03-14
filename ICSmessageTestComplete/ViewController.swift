//
//  ViewController.swift
//  ICSmessageTestComplete
//
//  Created by Jared Stevens2 on 12/6/16.
//  Copyright © 2016 Jared Stevens. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var username = String()

    @IBOutlet weak var saveUserNameBTN: UIButton!
    
    @IBOutlet weak var messageText: UITextField!
    
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var toUserText: UITextField!
    
    
    @IBOutlet weak var helloUserLBL: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
        
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
       // self.saveUserNameBTN.layer.backgroundColor = UIColor.black.cgColor
        
        
        if UserDefaults.standard.value(forKey: "MyUserName") != nil {
            
            self.username = UserDefaults.standard.value(forKey: "MyUserName") as! String
            
            
            helloUserLBL.text = "Hello, \(self.username)"
            
        } else {
            
            helloUserLBL.isHidden = true
            //self.username = "guest"
        }

        
    }
    
    @IBAction func saveUserName(_ sender: Any) {
        
       
        
        
        
        if usernameText.text == "" {
            
        
            
            let alertController = UIAlertController(title: "Uh Oh", message: "You forgot to enter a message", preferredStyle: .alert)
            
            // Initialize Actions
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) -> Void in
               print("Ok, just closing this alert")
            }
            
    
            // Add Actions
            alertController.addAction(okAction)
            
            // Present Alert Controller
            self.present(alertController, animated: true, completion: nil)
            
            
            
            
            
        } else {
            
            
            username = usernameText.text!
           
            UserDefaults.standard.set(usernameText.text, forKey: "MyUserName")
            
            helloUserLBL.text = "Hello, \(username)"
            
            
            let alertController = UIAlertController(title: "Success", message: "username: \((usernameText.text!)) saved.", preferredStyle: .alert)
            
            // Initialize Actions
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) -> Void in
               print("Ok, just closing this alert")
            }
            
            
            // Add Actions
            alertController.addAction(okAction)
            
            // Present Alert Controller
            self.present(alertController, animated: true, completion: nil)
            
            
            
            
            
            
        }
        
        
        
        
    }
    
    
    
    
    
    
    @IBAction func sendMessage(_ sender: Any) {
        
        if messageText.text == "" {
            
            let alertController = UIAlertController(title: "Uh Oh", message: "You forgot to enter a message", preferredStyle: .alert)
            
            // Initialize Actions
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) -> Void in
                print("Ok, just closing this alert")
            }
            
            
            // Add Actions
            alertController.addAction(okAction)
            
            // Present Alert Controller
            self.present(alertController, animated: true, completion: nil)
            
            
        } else {
            
          
            
          let messageSent = SendMessage(toUserText.text!, fromUser: username, message: messageText.text!)
            
            
            let alertController = UIAlertController(title: "Message Status", message: "Was the message sent? \(messageSent)", preferredStyle: .alert)
            
            // Initialize Actions
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) -> Void in
                print("Ok, just closing this alert")
            }
            
            
            // Add Actions
            alertController.addAction(okAction)
            
            // Present Alert Controller
            self.present(alertController, animated: true, completion: nil)
        
            
            
            
        }
      
        
        
  
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func DismissKeyboard(){
        view.endEditing(true)
    }


}

