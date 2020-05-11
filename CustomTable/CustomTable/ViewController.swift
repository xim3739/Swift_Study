//
//  ViewController.swift
//  CustomTable
//
//  Created by 심재현 on 11/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let height:CGFloat = 100
    
    var page = 1
    
    lazy var list: [MovieVO] = {
        var dataList = [MovieVO]()
        return dataList
    }()
    
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var customCellTableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.callMovieAPI()
        customCellTableView.delegate = self
        customCellTableView.dataSource = self
        callMovieAPI()
    }

    @IBAction func btnMoreHandler(_ sender: UIButton) {
        self.page += 1
        
//        self.tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCellTableViewCell
        
        cell.lblTitle.text = row.title
        cell.lblText.text = row.description
        cell.lblRating.text = "\(row.rating!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height
    }
    
    func callMovieAPI() {
        Alamofire.request("https://api.github.com/users", method: .get, parameters: [:], encoding: URLEncoding.default, headers: ["Content_Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON{(response) in
                if let MyJSON = response.result.value {
                    print(MyJSON)
                }
        }
    }
}
