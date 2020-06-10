//
//  ViewController.swift
//  testApp
//
//  Created by Owner on 2020/06/10.
//  Copyright © 2020 asOne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var colorName = String()
    var bool = false

    @IBOutlet weak var colorNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func redButton(_ sender: Any) {
        colorNameLabel.textColor = UIColor.red
        colorName = "red"
        bool = true
    }
    
    @IBAction func yellowButton(_ sender: Any) {
        colorNameLabel.textColor = UIColor.yellow
        colorName = "yellow"
        bool = true
    }
    
    @IBAction func blueButton(_ sender: Any) {
        colorNameLabel.textColor = UIColor.blue
        colorName = "blue"
        bool = true
    }
    
    @IBAction func backView(segue: UIStoryboardSegue) {
        if bool == true {
            self.performSegue(withIdentifier: "toResultView", sender: self)
        } else {
            print("色未選択")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultView" {
            let rvc = segue.destination as! ResultViewController
            rvc.color = colorName
        }
    }

}

