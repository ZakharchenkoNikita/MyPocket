//
//  BillListTableViewController.swift
//  MyPocket
//
//  Created by Nikita on 21.08.21.
//

import RealmSwift

class BillListTableViewController: UITableViewController {
    
    // MARK: Private properties
    private var billList: Results<Bill>!
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        billList = StorageManager.shared.realm.objects(Bill.self) // нужен для того, чтобы заполнить из бд.
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let newBillTableVC = navigationVC.topViewController as? NewBillTableViewController else { return }
        guard let identifier = segue.identifier else { return }
        
        if identifier == "newBill" {
            newBillTableVC.delegate = self
            newBillTableVC.identifier = identifier
        } else {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let currentBill = billList[indexPath.row]
            
            newBillTableVC.delegate = self
            newBillTableVC.identifier = identifier
            newBillTableVC.bill = currentBill
        }
    }
    
    // MARK: IB Action
    @IBAction func unwindSegue(_ unwindSegue: UIStoryboardSegue) {
    }
    
    // MARK: Private methods
    private func deleteBill(currentBill: Bill, indexPath: IndexPath) {
        StorageManager.shared.delete(bill: currentBill)
        
        let cellIndex = IndexPath(row: indexPath.row, section: 0)
        tableView.deleteRows(at: [cellIndex], with: .automatic)
    }
}

// MARK: - Table view data source
extension BillListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        billList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "billsListCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let billList = billList[indexPath.row]
        
        content.image = UIImage(systemName: "wallet.pass.fill")
        content.imageProperties.tintColor = .gray
        content.text = billList.name
        content.secondaryText = String(billList.balance)
        content.secondaryTextProperties.color = .orange
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let currentBill = billList[indexPath.row]
            deleteBill(currentBill: currentBill, indexPath: indexPath)
        }
    }
}

// MARK: NewBillTableViewControllerDelegate
extension BillListTableViewController: NewBillTableViewControllerDelegate {
    func updateBill() {
        tableView.beginUpdates()
        tableView.reloadRows(at: tableView.indexPathsForVisibleRows!, with: .automatic)
        tableView.endUpdates()
    }
    
    func saveNewBill() {
        let cellIndex = IndexPath(row: billList.count - 1, section: 0)
        tableView.insertRows(at: [cellIndex], with: .automatic)
    }
}
