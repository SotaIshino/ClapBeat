//
//  PlayViewController.swift
//  GestureFlash
//
//  Created by Owner on 2020/06/05.
//  Copyright © 2020 asOne. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var completedGestureLabel: UILabel!
    @IBOutlet weak var gestureImage: UIImageView!
    
    var startTime = NSDate()
    var completedGestures = Int()
    var currentGesture = Int()
    var timer = Timer()
    var timerCount = Double()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        completedGestures = 0
        
        var swipeRightSelector = #selector(self.swipeRightDetected(sender:))
        var swipeRightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: swipeRightSelector)
        var swipeLeftSelecter = #selector(self.swipeLeftDetected(sender:))
        var swipeLeftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: swipeLeftSelecter)
        var swipeUpSelector = #selector(self.swipeUpDetected(sender:))
        var swipeUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: swipeUpSelector)
        var swipeDownSelector = #selector(self.swipeDownDetected(sender:))
        var swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: swipeDownSelector)
        var pinchSelector = #selector(self.pinchDetected(sender:))
        var pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: pinchSelector)
        var rotateSelector = #selector(self.rotateDetected(sender:))
        var rotateGestureRecognizer = UIRotationGestureRecognizer(target: self, action: rotateSelector)
        self.view.addGestureRecognizer(swipeRightGestureRecognizer)
        self.view.addGestureRecognizer(swipeLeftGestureRecognizer)
        self.view.addGestureRecognizer(swipeUpGestureRecognizer)
        self.view.addGestureRecognizer(swipeDownGestureRecognizer)
        self.view.addGestureRecognizer(pinchGestureRecognizer)
        self.view.addGestureRecognizer(rotateGestureRecognizer)
        
        self.nextProblem()
        
        timerCount = 0
        timer = Timer.scheduledTimer(timeInterval: 0.1,
                                     target: self,
                                     selector: #selector(PlayViewController.onTimer(timer:)),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var elapsedTime = startTime.timeIntervalSinceNow
        elapsedTime = -(elapsedTime)
        
        if segue.identifier == "toResultView" {
            let rvc = segue.destination as! ResultViewController
            rvc.time = elapsedTime
        }
    }
    
    func nextProblem() {
        if completedGestures == 30 {
            self.performSegue(withIdentifier: "toResultView", sender: self)
        } else {
            var gestureIcons = [UIImage(named: "swipe-right"),
                                UIImage(named: "swipe-left"),
                                UIImage(named: "swipe-up"),
                                UIImage(named: "swipe-down"),
                                UIImage(named: "pinch-in"),
                                UIImage(named: "pinch-out"),
                                UIImage(named: "rotate-right"),
                                UIImage(named: "rotate-left")
            ]
            
            currentGesture = Int(arc4random() % 8)
            NSLog("got new gesture current: %d", currentGesture)
            gestureImage.image = gestureIcons[currentGesture]
            completedGestureLabel.text = String(format: "%d", completedGestures)
        }
    }
    
    @objc func onTimer(timer: Timer) {
        timerCount = timerCount + 0.1
        timeLabel.text = String(format: "%.1f", timerCount)
    }
    
    @objc func swipeRightDetected(sender: UISwipeGestureRecognizer) {
        NSLog("swipe-right")
        NSLog("current: %d", currentGesture)
        if currentGesture == 0 {
            NSLog("next")
            completedGestures += 1
            self.nextProblem()
        }
    }
    
    @objc func swipeLeftDetected(sender: UISwipeGestureRecognizer) {
        NSLog("swipe-left")
        NSLog("current: %d", currentGesture)
        if currentGesture == 1 {
            NSLog("next")
            completedGestures += 1
            self.nextProblem()
        }
    }
    
    @objc func swipeUpDetected(sender: UISwipeGestureRecognizer) {
        NSLog("swipe-up")
        NSLog("current: %d", currentGesture)
        if currentGesture == 2 {
            NSLog("next")
            completedGestures += 1
            self.nextProblem()
        }
    }
    
    @objc func swipeDownDetected(sender: UISwipeGestureRecognizer) {
        NSLog("swipe-down")
        NSLog("current: %d", currentGesture)
        if currentGesture == 3 {
            NSLog("next")
            completedGestures += 1
            self.nextProblem()
        }
    }
    
    @objc func pinchDetected(sender: UIPinchGestureRecognizer) {
        let scale = sender.scale
        if scale < 0.4 {
            NSLog("pinch-in scale: %f", scale)
            NSLog("current: %d", currentGesture)
            if currentGesture == 4 {
                NSLog("next")
                completedGestures += 1
                self.nextProblem()
            }
        } else if scale > 2.4 {
            NSLog("pinch-out scale: %f", scale)
            NSLog("current: %d", currentGesture)
            if currentGesture == 5 {
                NSLog("next")
                completedGestures += 1
                self.nextProblem()
            }
        }
    }
    
    @objc func rotateDetected(sender: UIRotationGestureRecognizer) {
        let radians = sender.rotation
        let degrees = radians * CGFloat(100 / M_PI)
        if degrees > 90 {
            NSLog("rotate-right degrees: %f", degrees)
            NSLog("current: %d", currentGesture)
            if currentGesture == 6 {
                NSLog("next")
                completedGestures += 1
                self.nextProblem()
            }
        } else if degrees < -90 {
            NSLog("rotate-left degrees: %f", degrees)
            NSLog("current: %d", currentGesture)
            if currentGesture == 7 {
                NSLog("next")
                completedGestures += 1
                self.nextProblem()
            }
        }
    }

}
