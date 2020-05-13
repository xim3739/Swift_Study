//
//  ViewController.swift
//  TestProject
//
//  Created by 심재현 on 12/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let locations:[String] = ["synthesize", "busan", "chungbuk", "chungnam", "daegu", "daejeon", "gangwon", "gwangju", "gyeongbuk", "gyeonggi", "gyeongnam", "incheon", "jeju", "jeonbuk", "jeonnam", "sejong", "seoul", "ulsan"]
    
    // request 보낸 locale 과 response 받은 DomesticVO 를 dictionary 로 관리한다.
    var domestics: [String: DomesticVO] = [:]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        locations.forEach { self.callAPI(locale: $0) }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! CustomTableViewCell
        let locale = locations[indexPath.row]
        cell.lblLocale.text = locale
        
        if let domestic = domestics[locale] {
            cell.lblCertified.text = String(domestic.certified)
            cell.lblIsolated.text = String(domestic.increased)
            cell.lblPercentage.text = String(domestic.percentage)
            
        }
        else {
            // api response 보다 먼저 불러진다. loading 중이라는 처리를 미리 한다.
            cell.lblCertified.text = "loading…"
            cell.lblIsolated.text = "loading…"
            cell.lblPercentage.text = "loading…"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locale = locations[indexPath.row]
        let selectAlert = UIAlertController(title: locale, message: <#T##String?#>, preferredStyle: <#T##UIAlertController.Style#>)
    }
    
    func callAPI(locale: String) {
        let header: HTTPHeaders = ["APIKey":"e9c183eb9d3b85ad38c51538ba5a12409a3746306ca4f4c8e6da0440493766c9"]
        let params: Parameters = ["locale":locale]
        Alamofire.request("https://api.dropper.tech/covid19/status/korea", method: .get, parameters:params, encoding: URLEncoding.queryString, headers: header)
            .responseJSON(completionHandler: { resondsData in
                print("Responds API")
                switch resondsData.result {
                case let .success(value as [String: Any]):
                    let tempJson = JSON(value)
                    let resData = tempJson["data"].arrayValue[0]
                    
                    let domestic = DomesticVO()
                    
                    domestic.increased = resData["increased"].object as? Int ?? 0
                    domestic.certified = resData["certified"].object as? Int ?? 0
                    domestic.isolated = resData["isolated"].object as? Int ?? 0
                    domestic.deisolated = resData["deisolated"].object as? Int ?? 0
                    domestic.dead = resData["dead"].object as? Int ?? 0
                    domestic.percentage = resData["percentage"].object as? Double ?? 0
                    
                    //dictionary 에 locale 과 domestic 을 맞춰서 넣은 후 tableView 를 reload 해준다
                    self.domestics[locale] = domestic
                    self.tableView.reloadData()
                    
                default:
                    print("failed")
                }
            })
    }
}



