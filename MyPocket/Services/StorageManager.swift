//
//  StorageManager.swift
//  MyPocket
//
//  Created by Nikita on 21.08.21.
//

import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    
    let realm = try! Realm()
    
    private init() {}
    
    func save(bill: Bill) {
        try! realm.write {
            realm.add(bill)
        }
    }
    
    func delete(bill: Bill) {
        try! realm.write{
            realm.delete(bill)
        }
    }
    
    func update(name: String, note: String) {
        let bill = realm.objects(Bill.self)
        
        try! realm.write{
            bill.forEach { bill in
                bill.name = name
                bill.note = note
            }
        }
    }
}
