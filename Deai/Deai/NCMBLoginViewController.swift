//
//  NCMBLoginViewController.swift
//  Deai
//
//  Created by Owner on 2020/06/18.
//  Copyright © 2020 asOne. All rights reserved.
//

//ユーザー新規登録や、"userId","password"以外のデータ入力はNCMBより直接行いました

import UIKit
import NCMB

class NCMBLoginViewController: UIViewController {

    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.isSecureTextEntry = true
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let userId = userIdTextField.text
        let password = passwordTextField.text
        NCMBUser.logInWithUsername(inBackground: userId, password: password, block: ({(user, error) in
            if error != nil {
                print("ログイン失敗")
            } else {
                print("ログイン成功")
                _ = self.navigationController?.popToRootViewController(animated: true)
            }
        }))
    }
    

}
