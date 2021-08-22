//
//  Bill.swift
//  MyPocket
//
//  Created by Nikita on 21.08.21.
//

import RealmSwift

class Bill: Object {
    @objc dynamic var name = ""
    @objc dynamic var type = BillCategory.bank.rawValue
    @objc dynamic var balance = 0.0
    @objc dynamic var note = ""
    @objc dynamic var currency = ""
    @objc dynamic var date = Date()
    
    let transactions = List<Transaction>()
}

class Transaction: Object {
    @objc dynamic var name = ""
    @objc dynamic var balance = 0.0
    @objc dynamic var date = Date()
    @objc dynamic var bill: Bill?
}

enum BillCategory: String, CaseIterable {
    case bank = "Банк"
    case wallet = "Кошелек"
    case assets = "Активы"
}
