//
//  TransactionTableViewController.swift
//  MyPocket
//
//  Created by Nikita on 24.08.21.
//

import RealmSwift

class TransactionTableViewController: UITableViewController {

    var bill: Bill?
    
    private var transactions: Results<Transaction>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transactions = StorageManager.shared.realm.objects(Transaction.self)
        title = bill?.name
    }
}

// MARK: - Table view data source
extension TransactionTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath)
        let transaction = transactions[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = transaction.name
        content.secondaryText = String(transaction.balance)
        
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - Table view delegate
extension TransactionTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
