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
    
    func saveObject<O: Object>(object: O) {
        write {
            realm.add(object)
        }
    }
    
    func deleteObject<O: Object>(object: O) {
        write {
            realm.delete(object)
        }
    }
    
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
    
}

// MARK: - Work with transactions
extension StorageManager {
}
