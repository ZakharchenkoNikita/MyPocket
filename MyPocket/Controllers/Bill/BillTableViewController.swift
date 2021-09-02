//
//  BillTableViewController.swift
//  MyPocket
//
//  Created by Nikita on 02.09.21.
//

import RealmSwift

class BillTableViewController: UITableViewController {
    
    // MARK: - Properties
    var billList: Results<Bill>!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        billList = StorageManager.shared.realm.objects(Bill.self)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let newBillVC = navigationVC.topViewController as? NewBillTableViewController else { return }
        newBillVC.delegate = self
    }

    @IBAction func unwindSegue(_ unwindSegue: UIStoryboardSegue) {
    }
    
    private func getTotalBalance() -> String {
        var totalBalance = 0.00
        billList.forEach { bill in
            totalBalance += bill.balance
        }
        return String(totalBalance)
    }
}

// MARK: - Table view data source
extension BillTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        billList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "billsListCell", for: indexPath)
        let bill = billList[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = bill.name
        content.secondaryText = String(bill.balance)
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        getTotalBalance()
    }
}

// MARK: - Table view delegate
extension BillTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension BillTableViewController: NewBillTableViewControllerDelegate {
    func updateTableView() {
        tableView.reloadData()
    }
}
