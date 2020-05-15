//
//  CustomAlertViewController.swift
//  TestProject
//
//  Created by 심재현 on 13/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit

class CustomAlertViewController: UIViewController {
    @IBOutlet weak var lableLocale: UILabel!
    @IBOutlet weak var lableIncreased: UILabel!
    @IBOutlet weak var lableCertified: UILabel!
    @IBOutlet weak var lableIsolated: UILabel!
    @IBOutlet weak var lableDeisolated: UILabel!
    @IBOutlet weak var lableDead: UILabel!
    @IBOutlet weak var lablePercentage: UILabel!
    @IBOutlet weak var buttonClose: UIButton!
    
    // receive Data
    var receiveLocale: String = ""
    var receiveDomestic: DomesticVO?
    var receiveNation: NationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lableLocale.text = receiveLocale
        lableIncreased?.text = String(receiveDomestic!.increased)
        lableCertified?.text = String(receiveDomestic!.certified)
        lableIsolated?.text = String(receiveDomestic!.isolated)
        lableDeisolated?.text = String(receiveDomestic!.deisolated)
        lableDead?.text = String(receiveDomestic!.dead)
        lablePercentage?.text = String(receiveDomestic!.percentage)
    }
    
    @IBAction func buttonCloseHandler(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
