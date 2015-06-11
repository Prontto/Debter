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
        creditorController.avoidsEmptySelection = false
        creditorTable.deselectAll(self)
    }
    
    // EventAddedDelegate
    func newEventAdded(sender: AddNewViewController, isDebt: Bool, isReceivable: Bool) {
        guard isDebt == true else {
            return
        }
    }
    
    
    @IBAction func removeCreditor(sender: AnyObject) {
        
        let selected = creditorTable.selectedRow
        guard selected > -1 else {
            print("This should never be printed, because button should be disabled now!")
            return
        }
        
        let person = creditorController.arrangedObjects[selected] as! Creditor
        moc.deleteObject(person)
        
        do {
            try moc.save()
        } catch {
            print("Error while saving after removing creditor")
        }

    }
    
    @IBAction func removeDebt(sender: AnyObject) {
        let selections = debtTable.selectedRowIndexes
        
        guard selections.count > 0 else {
            print("This should never be printed, because button should be disabled now!")
            return
        }
        
        for num in selections {
            let debt = debtController.arrangedObjects[num] as! Event
            let total: Double = debt.creditor!.sumOfEvents.doubleValue - debt.sum.doubleValue
            debt.creditor?.sumOfEvents = total
            moc.deleteObject(debt)
        }
        
        do {
            try moc.save()
        } catch {
            print("Error while saving after removing debts")
        }
        
        let columns = creditorTable.tableColumns as [NSTableColumn]
        for index in 0..<columns.count where columns[index].identifier == "total" {
            creditorTable.reloadDataForRowIndexes(creditorTable.selectedRowIndexes, columnIndexes: NSIndexSet(index: index))
        }
        if debtTable.selectedRowIndexes.count < 1 { removeDebtButton.enabled = false }
    }

}


extension DebtViewController: NSTableViewDelegate {
    
    // By default, XCode gives second selection color too white, so user can't see text anymore. That's why I sublassed NSTableRowView and made both selection colors blue.
    func tableView(tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return SelectedRowView()
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        
        guard creditorController.canRemove else {
            removeCreditorButton.enabled = false
            removeDebtButton.enabled = false
            return
        }
        
        if debtController.selectedObjects.count == 0 {
            removeDebtButton.enabled = false
        } else {
            removeCreditorButton.enabled = true
            removeDebtButton.enabled = true
            
        }
        
    }
}

