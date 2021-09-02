//
//  NewBillTableViewController.swift
//  MyPocket
//
//  Created by Nikita on 02.09.21.
//

import UIKit

class NewBillTableViewController: UITableViewController {

    @IBOutlet weak var balanceTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    var delegate: NewBillTableViewControllerDelegate!

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    @IBAction func saveButtonPressed() {
        saveBill()
    }
    
    private func saveBill() {
        guard let name = nameTextField.text else { return }
        guard let balance = balanceTextField.text else { return }
        
        guard !balance.isEmpty || !name.isEmpty else {
            callErrorAlert(message: "Name is required. Initial balance is required.")
            return
        }
        
        guard !name.isEmpty else {
            callErrorAlert(message: "Name is required.")
            return
        }
        guard !balance.isEmpty else {
            callErrorAlert(message: "An initial balance is required.")
            return
        }
        
        let newBill = Bill()
        newBill.name = name
        newBill.balance = Double(balance) ?? 0.00
        
        StorageManager.shared.saveObject(object: newBill)
        dismiss(animated: true) { [unowned self] in
            self.delegate.updateTableView()
        }
    }
    
    private func callErrorAlert(message: String) {
        let alert = UIAlertController(title: "Upps", message: message, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Сontinue", style: .destructive, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
