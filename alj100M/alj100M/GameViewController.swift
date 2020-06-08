//
//  GameViewController.swift
//  alj100M
//
//  Created by Owner on 2020/06/08.
//  Copyright © 2020 asOne. All rights reserved.
//


import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var CountLabel: UILabel!
    @IBOutlet weak var Cara1: UIImageView!
    @IBOutlet weak var Cara2: UIImageView!
    @IBOutlet weak var ase1: UIImageView!
    @IBOutlet weak var ase2: UIImageView!
    @IBOutlet weak var ganba1: UIImageView!
    @IBOutlet weak var ganba2: UIImageView!
    @IBOutlet weak var goal: UIImageView!
    
    var CountInt:Int = 0
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CountLabel.text = CountInt.description
        
        Cara1.isHidden = true
        Cara2.isHidden = false
        ase1.isHidden = true
        ase2.isHidden = true
        ganba1.isHidden = true
        ganba2.isHidden = true
        goal.isHidden = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.onUpdate(timer:)), userInfo: nil, repeats: true)
    }
    
    @objc func onUpdate(timer : Timer) {
        CountTimer = CountTimer + 0.1
    }
    
    @IBAction func rendaButton(sender: Any) {
        if Cara1.isHidden == true {
            Cara1.isHidden = false
            Cara2.isHidden = true
        } else {
            Cara1.isHidden = true
            Cara2.isHidden = false
        }
        
        CountInt += 1
        
        CountLabel.text = CountInt.description
        
        if CountInt > 90 {
            if ase1.isHidden == false {
                ase1.isHidden = true
                ase2.isHidden = false
            } else {
                ase1.isHidden = false
                ase2.isHidden = true
            }
            
            if ganba1.isHidden == false {
                ganba1.isHidden = true
                ganba2.isHidden = false
            } else {
                ganba1.isHidden = false
                ganba2.isHidden = true
            }
            
            if goal.isHidden == true {
                goal.isHidden = false
            }
        }

        
        if CountInt == 100 {
            timer.invalidate()
            
            self.performSegue(withIdentifier: "toResult", sender: nil)
        }
    }
    
}
