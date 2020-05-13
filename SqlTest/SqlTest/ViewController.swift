//
//  ViewController.swift
//  SqlTest
//
//  Created by 심재현 on 12/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var db: OpaquePointer?
    var testList = Array<Test>()
    @IBOutlet weak var txfId: UITextField!
    @IBOutlet weak var txfName: UITextField!
    @IBOutlet weak var txfPhone: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        openDb()
        readValue()
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    @IBAction func btnDeleteHandler(_ sender: UIButton) {
    }
    @IBAction func btnInsertHandler(_ sender: UIButton) {
        let check = emptyCheck()
        if check {
            var stmt: OpaquePointer?
            let sql = "INSERT INTO Test (name, phone) VALUES (?, ?)"
            
            if sqlite3_prepare(db, sql, -1, &stmt, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print(errmsg)
                return
            }
            let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
            
            if sqlite3_bind_text(stmt, 1,  txfName.text, -1, SQLITE_TRANSIENT) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print(errmsg)
                return
            }
            if sqlite3_bind_text(stmt, 2, txfPhone.text, -1, SQLITE_TRANSIENT) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print(errmsg)
                return
            }
            
            if sqlite3_step(stmt) != SQLITE_DONE {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print(errmsg)
                return
            }
            txfId.text = ""
            txfName.text = ""
            txfPhone.text = ""
            
            print("Insert Success")
        }
    }
    @IBAction func btnSelectHandler(_ sender: UIButton) {
        readValue()
    }
    
    func readValue() {
        testList.removeAll()
        let sql = "SELECT * FROM Test"
        
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(db, sql, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print(errmsg)
            return
        }
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let phone = String(cString: sqlite3_column_text(stmt, 2))
            print(id)
            print(name)
            print(phone)
            testList.append(Test(id: Int(id), name: String(describing: name), phone: String(describing: phone)))
            print(testList[0].id)
        }
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        let data: Test
        data = testList[indexPath.row]
        print("data : \(data)")
        cell.textLabel?.text = data.name
        return cell
        
    }
    
    func openDb() {
        let path: String = {
            let fm = FileManager.default
            return fm.urls(for: .libraryDirectory, in: .userDomainMask).last!.appendingPathComponent("db.sqlite").path
        }()
        if sqlite3_open(path, &db) != SQLITE_OK {
           print(path)
        }
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Test (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone TEXT)", nil, nil, nil) != SQLITE_OK {
            let errorMsg = String(cString: sqlite3_errmsg(db)!)
            print(errorMsg)
        }
    }
    
    func emptyCheck() -> Bool {
        if ((txfId.text == "") && (txfName.text == "") && (txfPhone.text == "")) {
            return false
        } else {
            return true
        }
    }

}

