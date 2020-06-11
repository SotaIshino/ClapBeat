//
//  Stamp.swift
//  StampCamera
//
//  Created by Owner on 2020/06/11.
//  Copyright © 2020 asOne. All rights reserved.
//

import UIKit

class Stamp: UIImageView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview?.bringSubviewToFront(self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let dx = touch.location(in: self.superview).x - touch.previousLocation(in: self.superview).x
        let dy = touch.location(in: self.superview).y - touch.previousLocation(in: self.superview).y
        self.center = CGPoint(x: self.center.x + dx, y: self.center.y + dy)
    }
}
