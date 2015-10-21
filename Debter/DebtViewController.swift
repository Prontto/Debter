//
//  DebtViewController.swift
//  Debter
//
//  Created by Samu Tuominen on 10.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

@objc protocol DebtDelegate {
    func debtOrCreditorDeleted(sender: DebtViewController)
}

class DebtViewController: NSViewController, EventAddedDelegate {
    
    @IBOutlet weak var creditorTable: VibrancyTable!
    @IBOutlet weak var debtTable: VibrancyTable!
    @IBOutlet weak var removeCreditorButton: NSButton!
    @IBOutlet weak var removeDebtButton: NSButton!
    @IBOutlet weak var creditorController: NSArrayController!
    @IBOutlet weak var debtController: NSArrayController!
    
    lazy var moc = CoreDataStackManager.sharedManager.managedObjectContext
    
    weak var delegate: DebtDelegate?
    
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
        
        let selected = creditorController.arrangedObjects as! [Ower]
        guard selected.count > 0 else {
            return
        }
        // Only one ower can be selected.
        moc.deleteObject(selected[0])
        do {
            try moc.save()
        } catch {
            print("Error while removing Ower")
        }
        
        delegate?.debtOrCreditorDeleted(self)
        
        if creditorController.arrangedObjects.count < 1 {
            removeCreditorButton.enabled = false
            removeDebtButton.enabled = false
        }
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
        
        delegate?.debtOrCreditorDeleted(self)
    }
}


extension DebtViewController: NSTableViewDelegate {
    
    func tableView(tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return SelectedRowView()
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        if creditorTable.selectedRowIndexes.count > 0 { removeCreditorButton.enabled = true }
        else { removeCreditorButton.enabled = false }
        
        if debtTable.selectedRowIndexes.count > 0 { removeDebtButton.enabled = true }
        else { removeDebtButton.enabled = false }
   
    }
}

