//
//  ViewController.swift
//  PickerView
//
//  Created by 심재현 on 07/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let MAX_ARRAY_NUM = 9
    let PICKER_VIEW_COLUMN = 2
    let PICKER_VIEW_HEIGHT:CGFloat = 80
    
    var imageArray = [UIImage?]()
    var imageFileNames = [ "pic1.png", "pic2.png", "pic3.png", "pic4.png", "pic5.png"
        , "pic6.png", "pic7.png", "pic8.png", "pic9.png" ]
    
    @IBOutlet weak var pickerImage: UIPickerView!
    @IBOutlet weak var textImg: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for i in 0 ..< MAX_ARRAY_NUM {
            let image = UIImage(named: imageFileNames[i])
            imageArray.append(image)
        }
        
        textImg.text = imageFileNames[0]
        imgView.image = imageArray[0]

    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileNames.count
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imageFileNames[row]
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: imageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        
        return imageView
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 0) {
            textImg.text = imageFileNames[row]
        } else {
            imgView.image = imageArray[row]
        }
    }
}

