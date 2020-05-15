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

    @IBOutlet weak var tableView: UITableView!
    
    var getData: DomesticData = DomesticData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        getData = DomesticData.init(params: "locale", tableView: self.tableView, req: "korea", viewController: self)
    
    }
    
    //table View row count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getData.locations.count
    }
    
    //table View make Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! CustomTableViewCell
        let locale = getData.locations[indexPath.row]
        
        cell.lblLocale.text = locale
        
        if let domestic = getData.domestics[locale] {
            cell.lblCertified.text = String(domestic.certified)
            cell.lblIsolated.text = String(domestic.increased)
            cell.lblPercentage.text = String(domestic.percentage)
            
            tableView.allowsSelection = true
            
            return cell
        }
        else {
            // api response 보다 먼저 불러진다. loading 중이라는 처리를 미리 한다.
            cell.lblCertified.text = "loading…"
            cell.lblIsolated.text = "loading…"
            cell.lblPercentage.text = "loading…"
            
            tableView.allowsSelection = false
            
            return cell
        }
    }
    
    //table View Cell Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //table View Selected Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locale = getData.locations[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: false)
        guard let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "CustomAlertView") as? CustomAlertViewController
        else {
            return
        }
        
        if let sendDomestic = getData.domestics[locale] {
            customAlert.receiveLocale = locale
            customAlert.receiveDomestic = sendDomestic
        }
        
        customAlert.modalPresentationStyle = .overCurrentContext
        present(customAlert, animated: true, completion: nil)
        
    }
}
