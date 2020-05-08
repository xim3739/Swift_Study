//
//  ViewController.swift
//  AlertDatePicker
//
//  Created by 심재현 on 07/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let timeSelector: Selector = #selector(ViewController.updateTime)
    let interval = 1.0
    var checkDate: String = ""
    
    @IBOutlet weak var labelNow: UILabel!
    @IBOutlet weak var labelSelect: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func datePickerHandler(_ sender: UIDatePicker) {
        let datePicker = sender
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        
        checkDate = formatter.string(from: datePicker.date)
        labelSelect.text = checkDate
    }
    
    @objc func updateTime() {
        let date = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        
        labelNow.text = formatter.string(from: date as Date)
        
        if(labelNow.text == checkDate) {
            let selectAlert = UIAlertController(title: "SELECT TIME", message: "Check Time", preferredStyle: UIAlertController.Style.alert)
            let selectAction = UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: nil)
            selectAlert.addAction(selectAction)
            
            present(selectAlert, animated: true, completion: nil)
        }
    }
}

