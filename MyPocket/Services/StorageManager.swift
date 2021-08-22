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
        do {
            try realm.write {
                realm.add(bill)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func delete(bill: Bill) {
        do {
            try realm.write{
                realm.delete(bill)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func update(currentBill: Bill, name: String, note: String, balance: Double, type: String) {
        do {
            try realm.write{
                currentBill.name = name
                currentBill.note = note
                currentBill.balance = balance
                currentBill.type = type
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
