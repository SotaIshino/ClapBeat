//
//  MessageViewController.swift
//  Messenger
//
//  Created by Owner on 2020/06/12.
//  Copyright © 2020 asOne. All rights reserved.
//

import UIKit
import NCMB

class MessageViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate {
    
    var room = NCMBObject()
    var messages = NSArray()
    
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        messageTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchMessages()
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let msg = messages.object(at: indexPath.row) as! NCMBObject
        cell.textLabel!.text = msg.object(forKey: "text") as? String
        return cell
    }
    
    
    func fetchMessages() {
        let query = NCMBQuery(className: "Message")
        query?.whereKey("room", equalTo: room)
        query?.order(byAscending: "createDate")
        query?.findObjectsInBackground({(objects, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if objects!.count > 0 {
                    self.messages = objects as! NSArray
                    self.tableView.reloadData()
                } else {
                    print("エラー")
                }
            }
        })
    }
    
    
    
    @IBAction func sendMessageButtonTapped(_ sender: Any) {
        let msgStr = messageTextField.text
        
        if msgStr!.count > 0 {
            let msg = NCMBObject(className: "Message")
            msg?.setObject(msgStr, forKey: "text")
            msg?.setObject(room, forKey: "room")
            msg?.saveInBackground({(error) in
                if error != nil {
                    print("Message:保存失敗:\(error)")
                } else {
                    print("Message:保存成功:\(msg)")
                    self.fetchMessages()
                    self.messageTextField.text = ""
                }
            })
        }
        
        messageTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
