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
    
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Work with bill
extension StorageManager {
    func save(bill: Bill) {
        write {
            realm.add(bill)
        }
    }
    
    func delete(bill: Bill) {
        write {
            realm.delete(bill.transactions)
            realm.delete(bill)
        }
    }
    
    func update(currentBill: Bill, name: String, note: String, balance: Double, type: String) {
        write {
            currentBill.name = name
            currentBill.note = note
            currentBill.balance = balance
            currentBill.type = type
        }
    }
}

// MARK: - Work with transactions
extension StorageManager {
    func save(transaction: Transaction) {
        write {
            realm.add(transaction)
        }
    }
    
    func add(with bill: Bill, and transaction: Transaction) {
        write {
            bill.transactions.append(transaction)
        }
    }
}
