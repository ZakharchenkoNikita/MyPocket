//
//  BillListTableViewController.swift
//  MyPocket
//
//  Created by Nikita on 21.08.21.
//

import RealmSwift

enum BillCategory: String {
    case bank = "Bank"
    case wallet = "Wallet"
}

class BillListTableViewController: UITableViewController {
    
    // MARK: Private properties
    private var billList: Results<Bill>!
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        billList = StorageManager.shared.realm.objects(Bill.self) // нужен для того, чтобы заполнить из бд.
        navigationItem.rightBarButtonItem = editButtonItem
    }
    

    // MARK: IB Action
    @IBAction func unwindSegue(_ unwindSegue: UIStoryboardSegue) {
    }
    
    // MARK: Private methods

}

// MARK: - Table view data source
extension BillListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        billList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "billsListCell", for: indexPath) as! BillTableViewCell

        let billList = billList[indexPath.row]
        cell.billNameLabel.text = billList.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
}
