//
//  ResultViewController.swift
//  alj100M
//
//  Created by Owner on 2020/06/08.
//  Copyright © 2020 asOne. All rights reserved.
//

import UIKit
import Social

class ResultViewController: UIViewController {
    
    @IBOutlet weak var Kirokukousin: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TimerLabel.text = NSString(format: "%.2f秒", CountTimer) as String
    }
    
    @IBAction func FacebookButton(sender: Any) {
        let text = "結果タイム" + TimerLabel.text!
        let composeViewController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)!
        composeViewController.setInitialText(text)
        self.present(composeViewController, animated: true, completion: nil)
    }
    
    @IBAction func TweetButton(sender: Any) {
        let text = "結果タイム" + TimerLabel.text!
        let composeViewController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
        composeViewController.setInitialText(text)
        self.present(composeViewController, animated: true, completion: nil)
    }
    
    @IBAction func LineButton(sender: Any) {
        let text: String! = "結果タイム" + TimerLabel.text!
        let encodeMessage: String! = text.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let messageURL: NSURL! = NSURL(string: "line://msg/text/" + encodeMessage)
        if (UIApplication.shared.canOpenURL(messageURL as URL)) {
            UIApplication.shared.openURL(messageURL as URL)
        }
    }
    
}
