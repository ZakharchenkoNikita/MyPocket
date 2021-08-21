//
//  Bill.swift
//  MyPocket
//
//  Created by Nikita on 21.08.21.
//

import RealmSwift

class Bill: Object {
    @objc dynamic var billCategory = ""
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
}
