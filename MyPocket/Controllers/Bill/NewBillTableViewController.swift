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
    
    
    var delegate: NewBillTableViewControllerDelegate!
    var bill: Bill!
    var identifier: String!
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        getInformation()
    }

    // MARK: Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: IB Actions
    @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
        guard let nameTF = nameTextField.text, !nameTF.isEmpty else { return }
        
        switch identifier {
        case "currentBill":
            DispatchQueue.main.async {
                StorageManager.shared.update(name: nameTF)
            }
            
            dismiss(animated: true) {
                self.delegate.updateBill()
            }
        default:
            let newBill = Bill()
            newBill.name = nameTF
            
            DispatchQueue.main.async {
                StorageManager.shared.save(bill: newBill)
            }
            
            dismiss(animated: true) {
                self.delegate.saveNewBill()
            }
        }
    }
    
    private func saveBill() {
    }
    
    private func getInformation() {
        if identifier == "currentBill" {
            title = bill.name
            
            nameTextField.text = bill.name
            return
        }
    }
}
