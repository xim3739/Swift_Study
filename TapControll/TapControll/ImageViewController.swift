//
//  ViewController.swift
//  imageView
//
//  Created by 심재현 on 07/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnZoom: UIButton!
    
    var isZoom = false
    var imgOn: UIImage?
    var imgOff: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgOn = UIImage(named: "pic1.png")
        imgOff = UIImage(named: "pic2.png")
        
        imgView.image = imgOn
    }
    @IBAction func btnZoomHandler(_ sender: Any) {
        let scale:CGFloat = 2.0
        var newWidth:CGFloat, newHeight:CGFloat
        
        if(isZoom) {
            newWidth = imgView.frame.width / scale
            newHeight = imgView.frame.height / scale
            imgView.frame.size = CGSize(width: newWidth, height: newHeight)
            btnZoom.setTitle("Zoom In", for: .normal)
        } else {
            newWidth = imgView.frame.width * scale
            newHeight = imgView.frame.height * scale
            imgView.frame.size = CGSize(width: newWidth, height: newHeight)
            btnZoom.setTitle("Zoom Out", for: .normal)
        }
        isZoom = !isZoom
    }
    
    @IBAction func switchHandler(_ sender: UISwitch) {
        if sender.isOn {
            imgView.image = imgOn
        } else {
            imgView.image = imgOff
        }
    }
    
}

