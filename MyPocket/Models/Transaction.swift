//
//  Transaction.swift
//  MyPocket
//
//  Created by Nikita on 30.08.21.
//

import RealmSwift

class Transaction: Object {
    @objc dynamic var name = ""
    @objc dynamic var balance = 0.0
    @objc dynamic var date = Date()
}
