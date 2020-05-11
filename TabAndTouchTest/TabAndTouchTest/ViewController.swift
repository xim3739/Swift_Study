//
//  ViewController.swift
//  TabAndTouchTest
//
//  Created by 심재현 on 11/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblTapCount: UILabel!
    @IBOutlet weak var lblTouchCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        
        lblMessage.text = "Touches Begain"
        lblTapCount.text = String(touch.tapCount)
        lblTouchCount.text = String(touches.count)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        
        lblMessage.text = "Touches Moved"
        lblTapCount.text = String(touch.tapCount)
        lblTouchCount.text = String(touches.count)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        
        lblMessage.text = "Touches Ended"
        lblTapCount.text = String(touch.tapCount)
        lblTouchCount.text = String(touches.count)
    }

}

