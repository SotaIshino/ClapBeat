//
//  FBLoginViewController.swift
//  Deai
//
//  Created by Owner on 2020/06/17.
//  Copyright © 2020 asOne. All rights reserved.
//

import UIKit
import NCMB
import FBSDKCoreKit
import FBSDKLoginKit

class FBLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginFacebookAction(_ sender: Any) {
        let fbLoginManager:LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self, handler: {(result, error) -> Void in
            if error == nil {
                print("FBログイン成功")
                let fbLoginResult:LoginManagerLoginResult = result!
                if fbLoginResult.grantedPermissions.contains("email") {self.returnUserData()}
            } else {
                print("FBログイン失敗:\(error)")
            }
        })
    }
    
    func returnUserData() {
        let graphRequest:GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, email, gender, link, locale, name, timezone, updated_time, verified, last_name, first_name, middle_name"])
        graphRequest.start(completionHandler: {(connection, result, error) -> Void in
            if error == nil {
                print("FBユーザ情報取得成功:\(result)")
                self.ncmbLogin(result: result as AnyObject)
            } else {
                print("FBユーザ情報取得失敗:\(error)")
            }
        })
    }
    
    func ncmbLogin(result: AnyObject) {
        let userId = result.value(forKey: "id") as! String
        let ud = UserDefaults.standard
        var password = ""
        
        if let passwd = ud.object(forKey: "password") {
            password = passwd as! String
        } else {
            password = NSUUID().uuidString
            ud.set(password, forKey: "password")
        }
        
        NCMBUser.logInWithUsername(inBackground: userId, password: password, block: ({(user, error) in
            if error == nil {
                print("ログイン成功:\(user)")
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                print("ログイン失敗:\(error)")
                self.ncmbUserRegister(result: result, password: password)
            }
        }))
    }
    
    func ncmbUserRegister(result: AnyObject, password: String) {
        let user = NCMBUser()
        
        user.userName = result.value(forKey: "id") as! String
        user.password = password
        user.mailAddress = result.value(forKey: "email") as! String
        //下記、"gender"の取得が20200618現在不可能であったため NCMBから直接genderを入力しました
//        user.setObject(result.value(forKey: "gender") as! String, forKey: "gender")
        user.setObject(result.value(forKey: "name") as! String, forKey: "fullname")
        
        let acl = NCMBACL()
        acl.setPublicReadAccess(true)
        acl.setPublicWriteAccess(true)
        user.acl = acl
        
        user.signUpInBackground({(error) in
            if error == nil {
                print("ユーザ登録完了:\(user)")
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                print("ユーザ登録失敗:\(error)")
            }
        })
    }
    
}
