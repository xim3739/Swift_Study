//
//  TestVO.swift
//  CustomTable
//
//  Created by 심재현 on 12/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import RealmSwift

final class TestVO: Object {
    @objc dynamic var id: String? = ""
    @objc dynamic var name: String? = ""
    @objc dynamic var email: String? = ""
    @objc dynamic var gender: String? = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
