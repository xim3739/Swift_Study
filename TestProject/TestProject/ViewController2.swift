//
//  ViewController2.swift
//  TestProject
//
//  Created by 심재현 on 12/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var getData: DomesticData = DomesticData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        getData = DomesticData.init(params: "nation", tableView: self.tableView, req: "global", viewController: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getData.foreignLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "globalTableViewCell", for: indexPath) as! CustomTableViewCell2
        let locale = getData.foreignLocations[indexPath.row]
        
        cell.labelGlobalLocale.text = locale
        
        if let nationModel = getData.nations[locale] {
            cell.labelGlobalCrtified.text = String(nationModel.certified)
            cell.labelGlobalDead.text = String(nationModel.dead)
            
            tableView.allowsSelection = true
            
            return cell
        } else {
            cell.labelGlobalCrtified.text = "loading…"
            cell.labelGlobalDead.text = "loading…"
            
            tableView.allowsSelection = false
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
