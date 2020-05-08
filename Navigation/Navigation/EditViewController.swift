//
//  EditViewController.swift
//  Navigation
//
//  Created by 심재현 on 08/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit

protocol EditDelegate {
    func didMessageEditDone(_ controller: EditViewController, message: String)
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool)
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool)
}

class EditViewController: UIViewController {
    
    var textWayValue: String = ""
    var textMessage: String = ""
    var isOn = false
    var isZoom = false
    var delegate: EditDelegate?
    
    @IBOutlet weak var lblWay: UILabel!
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var swIsOn: UISwitch!
    @IBOutlet weak var btnResize: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblWay.text = textWayValue
        txtMessage.text = textMessage
        swIsOn.isOn = isOn
        
        if isZoom == false {
            btnResize.setTitle("축소", for: .normal)
        } else {
            btnResize.setTitle("확대", for: .normal)
        }
    }
    
    @IBAction func btnResizeHandler(_ sender: UIButton) {
        if isZoom == false {
            sender.setTitle("확대", for: .normal)
            isZoom = true
        } else {
            sender.setTitle("축소", for: .normal)
            isZoom = false
        }
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didMessageEditDone(self, message: txtMessage.text!)
            delegate?.didImageOnOffDone(self, isOn: isOn)
            delegate?.didImageZoomDone(self, isZoom: isZoom)
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func swLmageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            isOn = true
        } else {
            isOn = false
        }
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
