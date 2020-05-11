//
//  ViewController.swift
//  SwipeTest
//
//  Created by 심재현 on 11/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let numOfTouchs = 2

    @IBOutlet weak var imgViewUp: UIImageView!
    @IBOutlet weak var imgViewRight: UIImageView!
    @IBOutlet weak var imgViewDown: UIImageView!
    @IBOutlet weak var imgViewLeft: UIImageView!
    
    var imgLeft = [UIImage()]
    var imgRight = [UIImage()]
    var imgUp = [UIImage()]
    var imgDown = [UIImage()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgUp.append(UIImage(named: "pic1.png")!)
        imgUp.append(UIImage(named: "pic6.png")!)
        imgUp.append(UIImage(named: "pic7.png")!)
        imgDown.append(UIImage(named: "pic3.png")!)
        imgDown.append(UIImage(named: "pic8.png")!)
        imgDown.append(UIImage(named: "pic9.png")!)
        imgLeft.append(UIImage(named: "pic4.png")!)
        imgLeft.append(UIImage(named: "pic5.png")!)
        imgLeft.append(UIImage(named: "pic6.png")!)
        imgRight.append(UIImage(named: "pic2.png")!)
        imgRight.append(UIImage(named: "pic8.png")!)
        imgRight.append(UIImage(named: "pic9.png")!)
        
        imgViewUp.image = imgUp[0]
        imgViewRight.image = imgRight[0]
        imgViewDown.image = imgDown[0]
        imgViewLeft.image = imgLeft[0]
        
        let swipeUP = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeUP.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUP)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUpMulti = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGestureMulti(_:)))
        swipeUpMulti.direction = UISwipeGestureRecognizer.Direction.up
        swipeUpMulti.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeUpMulti)
        let swipeRightMulti = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGestureMulti(_:)))
        swipeRightMulti.direction = UISwipeGestureRecognizer.Direction.right
        swipeRightMulti.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeRightMulti)
        let swipeDownMulti = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGestureMulti(_:)))
        swipeDownMulti.direction = UISwipeGestureRecognizer.Direction.down
        swipeDownMulti.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeDownMulti)
        let swipeLeftMulti = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGestureMulti(_:)))
        swipeLeftMulti.direction = UISwipeGestureRecognizer.Direction.left
        swipeLeftMulti.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeLeftMulti)
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            imgViewUp.image = imgUp[0]
            imgViewRight.image = imgRight[0]
            imgViewDown.image = imgDown[0]
            imgViewLeft.image = imgLeft[0]
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.up :
                imgViewUp.image = imgUp[1]
            case UISwipeGestureRecognizer.Direction.right :
                imgViewRight.image = imgRight[1]
            case UISwipeGestureRecognizer.Direction.down :
                imgViewDown.image = imgDown[1]
            case UISwipeGestureRecognizer.Direction.left :
                imgViewLeft.image = imgLeft[1]
            default:
                break
            }
        }
    }
    
    @objc func respondToSwipeGestureMulti(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            imgViewUp.image = imgUp[0]
            imgViewRight.image = imgRight[0]
            imgViewDown.image = imgDown[0]
            imgViewLeft.image = imgLeft[0]
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.up :
                imgViewUp.image = imgUp[2]
            case UISwipeGestureRecognizer.Direction.right :
                imgViewRight.image = imgRight[2]
            case UISwipeGestureRecognizer.Direction.down :
                imgViewDown.image = imgDown[2]
            case UISwipeGestureRecognizer.Direction.left :
                imgViewLeft.image = imgLeft[2]
            default:
                break
            }
        }
    }


}

