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
        billTypeVC.delegate = self
    }
    
    // MARK: IB Actions
    @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
        guard let nameTF = nameTextField.text, !nameTF.isEmpty else { return }
        guard let noteTF = noteTextField.text else { return }
        guard let balanceTF = balanceTextField.text else { return }
        guard let type = billTypeCell.textLabel?.text else { return }
        
        switch identifier {
        case "currentBill":
            DispatchQueue.main.async {
                StorageManager.shared.update(currentBill: self.bill,
                                             name: nameTF,
                                             note: noteTF,
                                             balance: Double(balanceTF) ?? 0.0,
                                             type: type)
            }
            
            dismiss(animated: true) {
                self.delegate.updateBill()
            }
        default:
            let newBill = Bill()
            newBill.name = nameTF
            newBill.note = noteTF
            newBill.type = billTypeCell.textLabel?.text ?? "Банк"
            newBill.balance = Double(balanceTF) ?? 0.0
            
            saveBill(newBill: newBill)
        }
    }
    
    // MARK: Private methods
    private func saveBill(newBill: Bill) {
        DispatchQueue.main.async {
            StorageManager.shared.save(bill: newBill)
        }
        
        dismiss(animated: true) {
            self.delegate.saveNewBill()
        }
    }
    
    private func setupTableView() {
        billBalanceCell.textLabel?.text = "Баланс"
        
        if identifier == "currentBill" {
            title = bill.name
            nameTextField.text = bill.name
            noteTextField.text = bill.note
            
            billTypeCell.textLabel?.text = bill.type
            balanceTextField.text = String(bill.balance)
        } else {
            nameTextField.text = BillCategory.bank.rawValue
            billTypeCell.textLabel?.text = BillCategory.bank.rawValue
        }
    }
}

// MARK: BillTypeTableViewControllerDelegate
extension NewBillTableViewController: BillTypeTableViewControllerDelegate {
    func getBillType(type: String) {
        billTypeCell.textLabel?.text = type
        tableView.reloadData()
    }
}
