//
//  ViewController.swift
//  firebaseDemo
//
//  Created by ddonselaar on 21/09/2017.
//  Copyright © 2017 ddonselaar. All rights reserved.
//

import Firebase
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageInput: UITextField!
    
    private let appId = "1234567890"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        app.observe(DataEventType.value, with: { (snapshot) -> Void in
            let incommingMsg = snapshot.value as? [String : String] ?? [:]
            if let message = incommingMsg["msg"] {
                self.messageLabel.text = message
            }
        })
    }

    @IBAction func sendMessage(_ sender: UIButton) {
        if let inputMessage = messageInput.text {
            send(message: inputMessage)
            messageInput.text = "" // clear the text field after sending msg
        }
    }
    
    // Send a message to firebase
    private func send(message: String)
    {
        appMsg.setValue(message)
    }
    
    // Get the app message in firebase
    private var appMsg: DatabaseReference
    {
        return app.child("msg")
    }
    
    // Get the app by appId in firebase
    private var app: DatabaseReference
    {
        return db.child("app").child(appId)
    }
    
    // Get the database reference of firebase
    private var db: DatabaseReference!
    {
        return Database.database().reference()
    }

}

