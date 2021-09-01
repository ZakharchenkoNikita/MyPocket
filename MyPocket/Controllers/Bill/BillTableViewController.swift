//
//  BillTableViewController.swift
//  MyPocket
//
//  Created by Nikita on 21.08.21.
//

import RealmSwift

class BillTableViewController: UITableViewController {
    
    // MARK: Private properties
    private var billList: Results<Bill>!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        billList = StorageManager.shared.realm.objects(Bill.self)
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let transactionVC = segue.destination as? TransactionTableViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        transactionVC.bill = billList[indexPath.row]
    }
    
    // MARK: IB Action
    @IBAction func unwindSegue(_ unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func newBillButtonPressed(_ sender: UIBarButtonItem) {
        presentNewBillTableViewController(storyboardName: "Main", storyboardIdentifier: "navigationVC", identifier: "newBill")
    }
}

// MARK: Private methods
extension BillTableViewController {
    private func deleteBill(currentBill: Bill, indexPath: IndexPath) {
        StorageManager.shared.delete(bill: currentBill)
        
        let cellIndex = IndexPath(row: indexPath.row, section: 0)
        tableView.deleteRows(at: [cellIndex], with: .automatic)
    }
    
    private func presentNewBillTableViewController(storyboardName: String, storyboardIdentifier: String, identifier: String, currentBill: Bill? = nil) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let navigationVC = storyboard.instantiateViewController(identifier: storyboardIdentifier) as? UINavigationController else { return }
        guard let newBillTableVC = navigationVC.topViewController as? NewBillTableViewController else { return }
        
        newBillTableVC.delegate = self
        newBillTableVC.identifier = identifier
        newBillTableVC.bill = currentBill

        present(navigationVC, animated: true, completion: nil)
    }
}

// MARK: - Table view data source
extension BillTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        billList.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "test"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "billsListCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let billList = billList[indexPath.row]
        
        content.image = UIImage(named: billList.type)
        content.text = billList.name
        content.secondaryText = String(billList.balance)
        content.secondaryTextProperties.color = .orange
        
        cell.contentConfiguration = content
        
        return cell
    }
}

// MARK: - Table view delegate
extension BillTableViewController {
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
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let currentBill = billList[indexPath.row]
        presentNewBillTableViewController(storyboardName: "Main",
                                          storyboardIdentifier: "navigationVC",
                                          identifier: "currentBill",
                                          currentBill: currentBill)
    }
}

// MARK: NewBillTableViewControllerDelegate
extension BillTableViewController: NewBillTableViewControllerDelegate {
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
