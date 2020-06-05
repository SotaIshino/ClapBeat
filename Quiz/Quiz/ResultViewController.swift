//
//  ResultViewController.swift
//  Quiz
//
//  Created by Owner on 2020/06/04.
//  Copyright © 2020 asOne. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelImage: UIImageView!
    
    var correctPercentage = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if correctPercentage < 30 {
            levelLabel.text = "猿レベル"
            levelImage.image = UIImage(named: "bad")
        } else if correctPercentage >= 30 && correctPercentage < 90 {
            levelLabel.text = "一般人レベル"
            levelImage.image = UIImage(named: "normal")
        } else {
            levelLabel.text = "天才レベル"
            levelImage.image = UIImage(named: "good")
        }
        
        percentageLabel.text = String(format: "%d %%", correctPercentage)
    }
}
