//
//  ResultViewController.swift
//  GestureFlash
//
//  Created by Owner on 2020/06/05.
//  Copyright © 2020 asOne. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var newHighScoreLabel: UILabel!
    
    var time = TimeInterval()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = String(format: "%.3f 秒", time)
        self.checkHighScore()
    }
    
    func checkHighScore() {
        var newHighScore = false
        newHighScoreLabel.isHidden = true
        
        let defaults = UserDefaults.standard
        var highScore1 = defaults.double(forKey: "highScore1")
        var highScore2 = defaults.double(forKey: "highScore2")
        var highScore3 = defaults.double(forKey: "highScore3")
        
        if highScore1 != 0 && time <= highScore1 {
            highScore3 = highScore2
            highScore2 = highScore1
            highScore1 = time
            newHighScore = true
        } else if highScore2 != 0 && time <= highScore2 {
            highScore3 = highScore2
            highScore2 = time
            newHighScore = true
        } else if highScore3 != 0 && time <= highScore3 {
            highScore3 = time
            newHighScore = true
        } else if highScore1 == 0 {
            highScore1 = time
            newHighScore = true
        } else if highScore2 == 0 && time >= highScore1 {
            highScore2 = time
            newHighScore = true
        } else if highScore3 == 0 && time >= highScore2 {
            highScore3 = time
            newHighScore = true
        }
        
        defaults.set(highScore1, forKey: "highScore1")
        defaults.set(highScore2, forKey: "highScore2")
        defaults.set(highScore3, forKey: "highScore3")
        
        if newHighScore == true {newHighScoreLabel.isHidden = false}
    }
    
}
