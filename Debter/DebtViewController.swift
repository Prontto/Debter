//
//  DebtViewController.swift
//  Debter
//
//  Created by Samu Tuominen on 10.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

class DebtViewController: NSViewController, EventAddedDelegate {
    
    @IBOutlet weak var creditorTable: VibrancyTable! // id = "creditorTable"
    @IBOutlet weak var debtTable: VibrancyTable! // id = "debtTable"
    @IBOutlet weak var removeCreditorButton: NSButton!
    @IBOutlet weak var removeDebtButton: NSButton!
    @IBOutlet weak var creditorController: NSArrayController!
    @IBOutlet weak var debtController: NSArrayController!
    
    lazy var moc = CoreDataStackManager.sharedManager.managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // EventAddedDelegate
    func newEventAdded(sender: AddNewViewController, isDebt: Bool, isReceivable: Bool) {
        guard isDebt == true else {
            return
        }
        if creditorTable != nil {
            creditorTable.reloadData()
        }
    }
    
    
    @IBAction func removeCreditor(sender: AnyObject) {
        Helper.removeSelectedPerson(creditorTable, controller: creditorController, context: moc, button: removeCreditorButton)
    }
    
    @IBAction func removeDebt(sender: AnyObject) {
        let selections = debtTable.selectedRowIndexes
        guard selections.count > 0 else {
            return
        }
        
        for item in selections {
            let obj = debtController.arrangedObjects[item] as! Event
            moc.deleteObject(obj)
        }
        
        do {
            try moc.save()
        } catch {
            print("Error while saving after removing debts")
        }
        
        // Update totalcolumn
        let columns = creditorTable.tableColumns as [NSTableColumn]
        for index in 0..<columns.count where columns[index].identifier == "total" {
            creditorTable.reloadDataForRowIndexes(creditorTable.selectedRowIndexes, columnIndexes: NSIndexSet(index: index))
        }
        if debtTable.selectedRowIndexes.count < 1 { removeDebtButton.enabled = false }
    }
}


extension DebtViewController: NSTableViewDelegate {
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let myView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        if tableColumn?.identifier == "total" {
            let obj = creditorController.arrangedObjects[row] as! Creditor
            var sum = 0.0
            for item in obj.events?.allObjects as! [Event]{
                sum += item.sum.doubleValue
            }
            myView.textField?.doubleValue = sum

        }
        return myView
    }
    
    func tableView(tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return SelectedRowView()
    }
    
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        if creditorController.canRemove { removeCreditorButton.enabled = true }
        else { removeCreditorButton.enabled = false }
        
        if debtController.canRemove { removeDebtButton.enabled = true }
        else { removeDebtButton.enabled = false }
    }
}

