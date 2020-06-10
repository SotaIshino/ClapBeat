//
//  ResultViewController.swift
//  testApp
//
//  Created by Owner on 2020/06/10.
//  Copyright © 2020 asOne. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var color = String()
    
    @IBOutlet weak var colorNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch color {
        case "red":
            colorNameLabel.text = "red"
            colorNameLabel.textColor = UIColor.red
        case "yellow":
            colorNameLabel.text = "yellow"
            colorNameLabel.textColor = UIColor.yellow
        case "blue":
            colorNameLabel.text = "blue"
            colorNameLabel.textColor = UIColor.blue
        default:
            print("その他")
        }
    }
    

}
