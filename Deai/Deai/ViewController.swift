//
//  ViewController.swift
//  Deai
//
//  Created by Owner on 2020/06/17.
//  Copyright © 2020 asOne. All rights reserved.
//

import UIKit
import NCMB

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var interestedInWomen: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        ncmbLoginCheck()
    }
    
    func ncmbLoginCheck() {
        if NCMBUser.current() != nil {
            print("ログイン済み")
            self.setMyPicture()
        } else {
            print("未ログイン")
            //Cloneしてのrun時、コメントアウトを用い 使用したいsegue先を切り替えてください
            self.performSegue(withIdentifier: "toLogin", sender: nil)
//            self.performSegue(withIdentifier: "toNCMBLogin", sender: nil)
        }
    }
    
    func setMyPicture() {
        let user = NCMBUser.current()
        print("user:\(user)")
        
        let fbPictureUrl = "https://graph.facebook.com/" + (user?.userName)! + "/picture?type=large"
        if let fbpicUrl = NSURL(string: fbPictureUrl) {
            if let data = NSData(contentsOf: fbpicUrl as URL) {
                self.imageView.image = UIImage(data: data as Data)
            }
        }
    }

    @IBAction func logoutButtonTapped(_ sender: Any) {
        NCMBUser.logOut()
        ncmbLoginCheck()
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        let user = NCMBUser.current()
        user?.setObject(interestedInWomen.isOn, forKey: "interestedInWomen")
        user?.saveEventually({(error) in
            if error == nil {
                print("保存成功:\(user)")
                self.performSegue(withIdentifier: "toTinder", sender: nil)
            } else {
                print("保存失敗:\(error)")
            }
        })
    }
    
}

