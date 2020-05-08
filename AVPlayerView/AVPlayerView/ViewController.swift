//
//  ViewController.swift
//  AVPlayerView
//
//  Created by 심재현 on 08/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func playViedo(url: NSURL) {
        let playController = AVPlayerViewController()
        let player = AVPlayer(url: url as URL)
        playController.player = player
        
        self.present(playController, animated: true) {
            player.play()
        }
    }

    @IBAction func btnPlayInternalMovie(_ sender: UIButton) {
        let filePaht: String? = Bundle.main.path(forResource: "text", ofType: "mp4")
        let url = NSURL(fileURLWithPath: filePaht!)
        
        playViedo(url: url)
    }
    
    @IBAction func btnPlayExternalMovie(_ sender: UIButton) {
        let url = NSURL(string: "https://dl.dropboxusercontent.com/s/e38auz050w2mvud/Fileworks.mp4")!
        playViedo(url: url)
    }
}

