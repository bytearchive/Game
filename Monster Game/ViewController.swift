//
//  ViewController.swift
//  Monster Game
//
//  Created by Rohit Rajput on 01/09/16.
//  Copyright © 2016 Rohit Rajput. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: Monster!
    @IBOutlet weak var food: DragImg!
    @IBOutlet weak var heart: DragImg!
    
    @IBOutlet weak var penalty1Img: UIImageView!
    @IBOutlet weak var penalty2Img: UIImageView!
    @IBOutlet weak var penalty3Img: UIImageView!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: NSTimer!
    var monsterHappy = false
    var currentItem: UInt32 = 0
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        food.dropTarget = monsterImg
        heart.dropTarget = monsterImg
        
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3" )!))
            
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxSkull.prepareToPlay()
        }
            catch let err as NSError {
            print(err.debugDescription)
        }
        startTimer()
        }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        monsterHappy = true
        startTimer()
        
        food.alpha = DIM_ALPHA
        food.userInteractionEnabled = false
        heart.alpha = DIM_ALPHA
        heart.userInteractionEnabled = false
        
        if currentItem == 0 {
            sfxHeart.play()
        } else {
            
            sfxBite.play()
            }
        }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        
        if !monsterHappy {
            
            penalties += 1
            sfxSkull.play()
            
            if penalties == 1 {
                penalty1Img.alpha = OPAQUE
                penalty2Img.alpha = DIM_ALPHA
            } else if penalties == 2 {
                penalty2Img.alpha = OPAQUE
                penalty3Img.alpha = DIM_ALPHA
            }
            else if penalties >= 3 {
                penalty3Img.alpha = OPAQUE
            } else {
                penalty1Img.alpha = DIM_ALPHA
                penalty2Img.alpha = DIM_ALPHA
                penalty3Img.alpha = DIM_ALPHA
            }
            if penalties > MAX_PENALTIES {
                gameOver()
            }
        }
        
        let rand = arc4random_uniform(2)        // 0 or 1  (because it starts from 0)
        
        if rand == 0 {
            food.alpha = DIM_ALPHA
            food.userInteractionEnabled = false
            
            heart.alpha = OPAQUE
            heart.userInteractionEnabled = true
        } else {
            heart.alpha = DIM_ALPHA
            heart.userInteractionEnabled = false
            
            food.alpha = OPAQUE
            food.userInteractionEnabled = true
        }
        currentItem = rand
        monsterHappy = false
    }
    
    func gameOver() {
        timer.invalidate()
        monsterImg.deathAnimation()
        sfxDeath.play()
    }
}
