//
//  Bill.swift
//  MyPocket
//
//  Created by Nikita on 21.08.21.
//

import RealmSwift

class Bill: Object {
    @objc dynamic var name = ""
    @objc dynamic var balance = 0.00
    @objc dynamic var note = ""
    @objc dynamic var currency = ""
    @objc dynamic var date = Date()
    
    let transactions = List<Transaction>()
}
