//
//  ViewController.swift
//  CustomTable
//
//  Created by 심재현 on 11/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class ViewController:IViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let testVO = TestVO()
    let height:CGFloat = 100
    let realm = try! Realm()
    
    var page = 1
    var arrRes = [[String: AnyObject]]()
    
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var customCellTableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        callMovieAPI()
        addTestData()
        setUpUI()
        customCellTableView.delegate = self
        customCellTableView.dataSource = self
        self.customCellTableView.tableFooterView = UIView()
    }

    func setUpUI() {
        title = "TestVO"
        customCellTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CustomCell")
    }
    
    @IBAction func btnMoreHandler(_ sender: UIButton) {
        self.page += 1
        
//        self.tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = arrRes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCellTableViewCell
        
        cell.lblTitle?.text = row["name"] as? String
        cell.lblText?.text = row["email"] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height
    }
    
    func addTestData() {
        
        for index in 0..<arrRes.count {
            var getData = arrRes[index]
            testVO.id = getData["id"] as? String
            testVO.name = getData["name"] as? String
            testVO.email = getData["email"] as? String
            testVO.gender = getData["gender"] as? String
            
           realm.add(testVO)
        }
        
        
    }
    
    func callMovieAPI() {
        Alamofire.request("https://api.androidhive.info/contacts/").responseJSON{ (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["contacts"].arrayObject {
                    self.arrRes = resData as! [[String: AnyObject]]
                }
                if self.arrRes.count > 0 {
                    self.customCellTableView.reloadData()
                }
                print(self.arrRes)
            }
        }
    }
}
