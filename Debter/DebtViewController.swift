//
//  DebtViewController.swift
//  Debter
//
//  Created by Samu Tuominen on 10.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

class DebtViewController: NSViewController {
    
    private enum ColumnIdentifier: String {
        case Date = "date"
        case Sum = "sum"
        case Description = "desc"
        case Name = "name"
    }
    
    @IBOutlet weak var creditorTable: VibrancyTable!
    @IBOutlet weak var debtTable: VibrancyTable!
    
    // Datastores
    private var debts = [Event]()
    private var creditors = [Creditor]()
    
    lazy var moc = CoreDataStackManager.sharedManager.managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateCreditorTable()

    }

    private func updateCreditorTable() {
        
        let fetchResults = Helper.fetchEntities("Creditor", predicate: nil, moc: moc) as! [Creditor]
        creditors = fetchResults
        
        guard creditors.count > 0 else {
            return
        }
        
        creditorTable.reloadData()
    }
    
    private func returnSelectedCreditor() -> Creditor? {
        let num = creditorTable.selectedRow
        guard num < creditors.count && num > -1 else {
            return nil
        }
        return creditors[num]
    }
    
    @IBAction func test(sender: AnyObject) {
        if let obj = returnSelectedCreditor() {
            print(obj.name)
        }
    }

}

// MARK: - NSTableViewDelegate
extension DebtViewController: NSTableViewDelegate {
    
    func tableView(tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return SelectedRowView()
    }
}

