//
//  UserDetailViewController.swift
//  Deai
//
//  Created by Owner on 2020/06/18.
//  Copyright © 2020 asOne. All rights reserved.
//

import UIKit
import NCMB
import MessageUI

class UserDetailViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mailLabel: UILabel!
    
    var user = NCMBUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mailLabel.text = user.object(forKey: "mailAddress") as? String
        let fbPictureUrl = "https://ca.slack-edge.com/TMX0CSJFP-U011AQ9SDKK-90df2b714085-512"
//        let fbPictureUrl = "https://graph.facebook.com/" + user.userName + "/picture?type=large"
        if let fbpicUrl = NSURL(string: fbPictureUrl) {
            if let data = NSData(contentsOf: fbpicUrl as URL) {
                self.imageView.image = UIImage(data: data as Data)
            }
        }
    }
    
    @IBAction func contact(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() == false {
            print("email send failed")
            return
        }
        
        let mailViewController = MFMailComposeViewController()
        let toRecipients = [user.object(forKey: "mailAddress") as? String]
        mailViewController.mailComposeDelegate = self
        mailViewController.setSubject("「出会いアプリ」メール通知")
        mailViewController.setToRecipients(toRecipients as? [String])
        mailViewController.setMessageBody("", isHTML: false)
        
        let fbPictureUrl = "https://graph.facebook.com/" + NCMBUser.current().userName + "/picture?type=large"
        if let fbpicUrl = NSURL(string: fbPictureUrl) {
            if let data = NSData(contentsOf: fbpicUrl as URL) {
                mailViewController.addAttachmentData(data as Data, mimeType: "image/png", fileName: "image")
            }
        }
        
        self.present(mailViewController, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case MFMailComposeResult.cancelled:
            print("メール送信キャンセル")
        case MFMailComposeResult.saved:
            print("メールドラフト保存")
        case MFMailComposeResult.sent:
            print("メール送信完了")
        case MFMailComposeResult.failed:
            print("メール送信失敗")
        default:
            break
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
