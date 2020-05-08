//
//  ViewController.swift
//  HelloWorld
//
//  Created by 심재현 on 07/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbHello: UILabel!
    @IBOutlet weak var textName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnSend(_ sender: UIButton) {
        lbHello.text = "Hello, " + textName.text!
    }
    
}

