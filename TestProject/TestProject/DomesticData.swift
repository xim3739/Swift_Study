//
//  Data.swift
//  TestProject
//
//  Created by 심재현 on 14/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DomesticData {
    //국내 위지
    let locations:[String] = ["synthesize", "busan", "chungbuk", "chungnam", "daegu", "daejeon", "gangwon", "gwangju", "gyeongbuk", "gyeonggi", "gyeongnam", "incheon", "jeju", "jeonbuk", "jeonnam", "sejong", "seoul", "ulsan"]
    //국외 위치
    let foreignLocations:[String] = ["synthesize", "china", "hongkong", "taiwan", "macau", "japan", "russia", "israel", "usa", "canada", "brasil", "mexico", "italiana", "germany", "france", "england", "spain", "portugal", "turkey"]
    let toastAlert = UIAlertController(title: "Loading...", message: "Not Finish Loading", preferredStyle: .alert)
    //국내 정보
    var domestics: [String: DomesticVO] = [:]
    //국외 정보
    var nations: [String: NationModel] = [:]
    var check: Bool = false
    // 초기화
    init() {
        
    }
    // 초기화 (Call API & Get Data & Table View reloadData())
    init(params: String, tableView: UITableView, req: String, viewController: UIViewController) {
        
        if params == "locale" {
            if !(self.check) {
                self.toastAlert.view.backgroundColor = UIColor.black
                self.toastAlert.view.alpha = 0.6
                self.toastAlert.view.layer.cornerRadius = 15
                
                DispatchQueue.main.async(execute: {
//                    print("locale Alert")
                    viewController.present(self.toastAlert, animated: true)
                })
            }
            locations.forEach{ self.callAPI(locale: $0, requestParam: params, tableView: tableView, req: req, viewController: viewController)}
        } else if params == "nation" {
            if !(self.check) {
                self.toastAlert.view.backgroundColor = UIColor.black
                self.toastAlert.view.alpha = 0.6
                self.toastAlert.view.layer.cornerRadius = 15
                
                DispatchQueue.main.async(execute: {
//                    print("nation Alert")
                    viewController.present(self.toastAlert, animated: true)
                })
            }
            foreignLocations.forEach{ self.callAPI(locale: $0, requestParam: params, tableView: tableView, req: req, viewController: viewController)}
        }
    }
    func callAPI(locale: String, requestParam: String, tableView: UITableView, req: String, viewController: UIViewController) {
        let header: HTTPHeaders = ["APIKey":"e9c183eb9d3b85ad38c51538ba5a12409a3746306ca4f4c8e6da0440493766c9"]
        let params: Parameters = [requestParam:locale]
        Alamofire.request("https://api.dropper.tech/covid19/status/\(req)", method: .get, parameters:params, encoding: URLEncoding.queryString, headers: header)
            .responseJSON(completionHandler: { resondsData in
                switch resondsData.result {
                case let .success(value as [String: Any]):
                    let tempJson = JSON(value)
                    let resData = tempJson["data"].arrayValue[0]
                    
                    self.check = true
                    
                    if requestParam == "locale" {
                        let domesticModel = DomesticVO()
                        
                        domesticModel.increased = resData["increased"].object as? Int ?? 0
                        domesticModel.certified = resData["certified"].object as? Int ?? 0
                        domesticModel.isolated = resData["isolated"].object as? Int ?? 0
                        domesticModel.deisolated = resData["deisolated"].object as? Int ?? 0
                        domesticModel.dead = resData["dead"].object as? Int ?? 0
                        domesticModel.percentage = resData["percentage"].object as? Double ?? 0
                        
                        //dictionary 에 locale 과 domestic 을 맞춰서 넣은 후 tableView 를 reload 해준다
                        self.domestics[locale] = domesticModel
                        tableView.reloadData()
                        
                        if(self.locations.count == self.domestics.count) {
//                            print("locale Alert Close")
                            DispatchQueue.main.async {
                                self.toastAlert.dismiss(animated: true, completion: nil)
                            }
                        }
                        
                    } else if requestParam == "nation" {
                        let nationModel = NationModel()
                        
                        nationModel.increased = resData["increased"].object as? Int ?? 0
                        nationModel.certified = resData["certified"].object as? Int ?? 0
                        nationModel.dead = resData["dead"].object as? Int ?? 0
                        
                        self.nations[locale] = nationModel
                        tableView.reloadData()
                        
                        if(self.foreignLocations.count == self.nations.count) {
//                            print("nations Alert Close")
                            DispatchQueue.main.async {
                                self.toastAlert.dismiss(animated: true, completion: nil)
                            }
                        }
                    }
                default:
                    print("failed")
                }
            })
    }
}
