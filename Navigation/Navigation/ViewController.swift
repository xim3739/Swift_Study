//
//  ViewController.swift
//  Navigation
//
//  Created by 심재현 on 08/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, EditDelegate {
    var imgOn = UIImage(named: "pic1.png")
    var imgOff = UIImage(named: "pic2.png")
    
    var isOn = true
    var isZoom = false
    
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgView.image = imgOn
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editViewController = segue.destination as! EditViewController
        
        if segue.identifier == "editButton" {
            editViewController.textWayValue = "segue : use button"
        } else if segue.identifier == "editBarButton" {
            editViewController.textWayValue = "segue : use Bar button"
        }
        
        editViewController.textMessage = txtMessage.text!
        editViewController.isOn = isOn
        editViewController.isZoom = isZoom
        editViewController.delegate = self
    }
    
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        txtMessage.text = message
    }
    
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool) {
        if isOn {
            imgView.image = imgOn
            self.isOn = true
        } else {
            imgView.image = imgOff
            self.isOn = false
        }
    }
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool) {
        if (self.isZoom == isZoom) {
            return
        }
        
        self.isZoom = isZoom
        
        let scale: CGFloat = 2.0
        var newWidth: CGFloat, newHeight: CGFloat
        
        if isZoom {
            newWidth = imgView.frame.width * scale
            newHeight = imgView.frame.height * scale
            imgView.frame.size = CGSize(width: newWidth, height: newHeight)
        } else {
            newWidth = imgView.frame.width / scale
            newHeight = imgView.frame.height / scale
            imgView.frame.size = CGSize(width: newWidth, height: newHeight)
        }
    }
    

}

