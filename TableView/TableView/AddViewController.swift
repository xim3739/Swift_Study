//
//  AddViewController.swift
//  TableView
//
//  Created by 심재현 on 08/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let MAX_ARRAY_NUM = 3
    let PICKER_VIEW_HEIGHT:CGFloat = 50
    let PICKER_VIEW_COLUMN = 1
    
    var selectedImageName = ""
    var imageList = ["day1.png", "month1.png", "thema.png"]
    
    @IBOutlet weak var tfAddItem: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = UIImage(named: imageList[0])
        selectedImageName = imageList[0]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return MAX_ARRAY_NUM
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: UIImage(named: imageList[row]))
        imageView.frame = CGRect(x: 0, y: 0, width: PICKER_VIEW_HEIGHT, height: PICKER_VIEW_HEIGHT)
        
        return imageView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        imageView.image = UIImage(named: imageList[row])
        selectedImageName = imageList[row]
    }
    
    @IBAction func btnAddItem(_ sender: UIButton) {
        items.append(tfAddItem.text!)
        itemsImageFile.append("month1.png")
        tfAddItem.text = ""
        _ = navigationController?.popViewController(animated: true)
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
