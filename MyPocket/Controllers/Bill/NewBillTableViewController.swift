//
//  NewBillTableViewController.swift
//  MyPocket
//
//  Created by Nikita on 21.08.21.
//

import UIKit

class NewBillTableViewController: UITableViewController {
    
    // MARK: IB Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    
    @IBOutlet weak var billTypeCell: UITableViewCell!
    @IBOutlet weak var billBalanceCell: UITableViewCell!
    
    @IBOutlet weak var balanceTextField: UITextField!
    
    var delegate: NewBillTableViewControllerDelegate!
    var bill: Bill!
    var identifier: String!
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let billTypeVC = segue.destination as? BillTypeTableViewController else { return }
        billTypeVC.billType = billTypeCell.textLabel?.text
        billTypeVC.delegate = self
    }
    
    // MARK: IB Actions
    @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
        save()
    }
}

// MARK: BillTypeTableViewControllerDelegate
extension NewBillTableViewController: BillTypeTableViewControllerDelegate {
    func getBillType(type: String) {
        billTypeCell.textLabel?.text = type
        tableView.reloadData()
    }
}

// MARK: Private methods
extension NewBillTableViewController {
    private func save() {
        guard let nameTF = nameTextField.text, !nameTF.isEmpty else { return }
        guard let noteTF = noteTextField.text else { return }
        guard let balanceTF = balanceTextField.text else { return }
        guard let type = billTypeCell.textLabel?.text else { return }
        
        let newTransaction = Transaction(value: ["Balance adjustment", Double(balanceTF) ?? 0.0])
        
        switch identifier {
        case "currentBill":
            DispatchQueue.main.async {
                StorageManager.shared.update(currentBill: self.bill,
                                             name: nameTF,
                                             note: noteTF,
                                             balance: Double(balanceTF) ?? 0.0,
                                             type: type)
            }
            addTransaction(newTransaction: newTransaction)
            dismiss(animated: true) {
                self.delegate.updateBill()
            }
        default:
            let newBill = Bill(value:
                                [
                                    nameTF,
                                    billTypeCell.textLabel?.text ?? "Bank",
                                    Double(balanceTF) ?? 0.0, noteTF
                                ]
            )
            
            newBill.transactions.append(newTransaction)
            
            saveTransaction(newTransaction: newTransaction)
            saveBill(newBill: newBill)
        }
    }
    
    private func saveBill(newBill: Bill) {
        DispatchQueue.main.async {
            StorageManager.shared.save(bill: newBill)
        }
        dismiss(animated: true) {
            self.delegate.saveNewBill()
        }
    }
    
    private func saveTransaction(newTransaction: Transaction) {
        DispatchQueue.main.async {
            StorageManager.shared.save(transaction: newTransaction)
        }
    }
    
    private func addTransaction(newTransaction: Transaction) {
        DispatchQueue.main.async {
            StorageManager.shared.add(with: self.bill, and: newTransaction)
        }
    }
    
    private func setupTableView() {
        billBalanceCell.textLabel?.text = "Balance"
        
        switch identifier {
        case "currentBill":
            title = bill.name
            nameTextField.text = bill.name
            noteTextField.text = bill.note
            
            billTypeCell.textLabel?.text = bill.type
            balanceTextField.text = String(bill.balance)
        default:
            nameTextField.text = BillType.bank.rawValue
            billTypeCell.textLabel?.text = BillType.bank.rawValue
        }
    }
}
