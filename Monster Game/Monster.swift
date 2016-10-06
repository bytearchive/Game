//
//  Monster.swift
//  Monster Game
//
//  Created by Rohit Rajput on 17/09/16.
//  Copyright © 2016 Rohit Rajput. All rights reserved.
//

import Foundation
import UIKit

class Monster: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        idleAnimation()
    }
    
    func idleAnimation() {
        
        self.image = UIImage(named: "idle1.png")
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        
        for var x in 1...4 {
            
            let img = UIImage(named: "idle\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0       // 0 stands for infinity
        self.startAnimating()
    }
    
    func deathAnimation() {
        
        self.image = UIImage(named: "dead5.png")
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        
        for var x in 1...5 {
            
            let img = UIImage(named: "dead\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
        
    }
}