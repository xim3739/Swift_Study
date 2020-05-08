//
//  ViewController.swift
//  Alert
//
//  Created by 심재현 on 07/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let imgOn: UIImage = UIImage(named: "pic7.png")!
    let imgOff: UIImage = UIImage(named: "pic8.png")!
    let imgDel: UIImage = UIImage(named: "pic9.png")!
    var isLampOn = true
    
    @IBOutlet weak var imagView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagView.image = imgOn
    }

    @IBAction func btnOnHandler(_ sender: UIButton) {
        if(isLampOn == true) {
            let lampOnAlert = UIAlertController(title: "warnning", message: "Lamp is ON", preferredStyle: UIAlertController.Style.alert)
            let onAction = UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: nil)
            lampOnAlert.addAction(onAction)
            present(lampOnAlert, animated: true, completion: nil)
        } else {
            imagView.image = imgOn
            isLampOn = true
        }
    }
    
    @IBAction func btnOffHandler(_ sender: UIButton) {
        if(isLampOn) {
            let lampOffAlert = UIAlertController(title: "Lamp Off", message: "Lamp Off is OK?", preferredStyle: UIAlertController.Style.alert)
            let offAction = UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: {
                ACTION in self.imagView.image = self.imgOff
                self.isLampOn = false
            })
            let cancelAction = UIAlertAction(title: "NO", style: UIAlertAction.Style.default, handler: nil)
            
            lampOffAlert.addAction(offAction)
            lampOffAlert.addAction(cancelAction)
            
            present(lampOffAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnDelHandler(_ sender: UIButton) {
        let lampDeleteAlert = UIAlertController(title: "Delete Lamp", message: "Delete lamp is OK?", preferredStyle: UIAlertController.Style.alert)
        
        let offAction = UIAlertAction(title: "NO, Turn Off Lamp", style: UIAlertAction.Style.default, handler: {
            ACTION in self.imagView.image = self.imgOff
            self.isLampOn = false
        })
        let onAction = UIAlertAction(title: "NO, Turn On Lamp", style: UIAlertAction.Style.default, handler: {
            ACTION in self.imagView.image = self.imgOn
            self.isLampOn = true
        })
        let deleteAction = UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: {
            ACTION in self.imagView.image = self.imgDel
            self.isLampOn = false
        })
        
        lampDeleteAlert.addAction(offAction)
        lampDeleteAlert.addAction(onAction)
        lampDeleteAlert.addAction(deleteAction)
        
        present(lampDeleteAlert, animated: true, completion: nil)
    }
}

