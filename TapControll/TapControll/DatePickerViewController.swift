//
//  ViewController.swift
//  DatePicker
//
//  Created by 심재현 on 07/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var selectTime: UILabel!
    
    let timeSelector: Selector = #selector(DatePickerViewController.updateTime)
    let interval = 1.0
    var count = 0
    var currentDate: String?
    var selectDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func datePickerHandler(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        selectDate = formatter.string(from: datePickerView.date)
        selectTime.text = "select Time : " + formatter.string(from: datePickerView.date)
        view.backgroundColor = UIColor.red
    }
    
    @objc func updateTime() {
        let date = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        currentDate = formatter.string(from: date as Date)
        currentTime.text = "now Time : " + formatter.string(from: date as Date)
//        print("currentDate:\(currentDate) ::::::: selectDate:\(selectDate)")
        if(currentDate == selectDate) {
            view.backgroundColor = UIColor.white
        }
    }
    
}

