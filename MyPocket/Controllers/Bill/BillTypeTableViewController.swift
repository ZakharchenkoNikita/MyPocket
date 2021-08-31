//
//  BillTypeTableViewController.swift
//  MyPocket
//
//  Created by Nikita on 22.08.21.
//

import UIKit

class BillTypeTableViewController: UITableViewController {
    
    // MARK: Properties
    var delegate: BillTypeTableViewControllerDelegate!
    var billType: String!
    
    // MARK: Private properties
    private let billsType = BillType.allCases
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        billsType.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "billType", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        let bill = billsType[indexPath.row]
        
        content.image = UIImage(named: bill.rawValue)
        content.text = bill.rawValue
        
        cell.accessoryType = billType == bill.rawValue ? .checkmark : .none
        cell.contentConfiguration = content
        
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate.getBillType(type: billsType[indexPath.row].rawValue)
        navigationController?.popViewController(animated: true)
    }
}
