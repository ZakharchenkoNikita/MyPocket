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
    }
    
    // MARK: IB Action
    @IBAction func newBillListButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Новый список", message: "Введите название списка", preferredStyle: .alert)
        
        alert.addTextField { nameTextField in
            nameTextField.placeholder = "Название..."
        }
        
        let addAction = UIAlertAction(title: "Добавить", style: .default) { _ in
            guard let nameTextField = alert.textFields?.first else { return }
            guard let name = nameTextField.text, !name.isEmpty else { return }
            
            let newBill = Bill()
            newBill.name = name
            newBill.billCategory = BillCategory.bank.rawValue
            
            DispatchQueue.main.async {
                StorageManager.shared.save(bill: newBill)
                
                let cellIndex = IndexPath(row: self.billList.count - 1, section: 0)
                self.tableView.insertRows(at: [cellIndex], with: .automatic)
            }
        }
        let cancelAction = UIAlertAction(title: "Отменить", style: .destructive)
        
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
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
}
