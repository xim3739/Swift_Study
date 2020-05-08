//
//  ViewController.swift
//  PageControl
//
//  Created by 심재현 on 07/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var images = ["pic1.png", "pic2.png", "pic3.png", "pic4.png", "pic5.png", "pic6.png", "pic7.png",
    "pic8.png", "pic9.png"]
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myPageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myPageControl.numberOfPages = images.count
        
        myPageControl.currentPage = 0
        myPageControl.pageIndicatorTintColor = UIColor.green
        myPageControl.currentPageIndicatorTintColor = UIColor.red
        
        myImageView.image = UIImage(named: images[0])
    }

    @IBAction func pageControlHandler(_ sender: UIPageControl) {
        myImageView.image = UIImage(named: images[myPageControl.currentPage])
    }
    
}

