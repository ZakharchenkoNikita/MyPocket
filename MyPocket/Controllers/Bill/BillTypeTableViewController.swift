//
//  BillTypeTableViewController.swift
//  MyPocket
//
//  Created by Nikita on 22.08.21.
//

import UIKit

class BillTypeTableViewController: UITableViewController {

    var delegate: BillTypeTableViewControllerDelegate!
    
    private let billType = BillCategory.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        billType.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "billType", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.image = UIImage(systemName: "wallet.pass.fill")
        content.imageProperties.tintColor = .gray
        
        let bill = billType[indexPath.row]
        content.text = bill.rawValue

        cell.contentConfiguration = content

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate.getBillType(type: billType[indexPath.row].rawValue)
        navigationController?.popViewController(animated: true)
    }
}
