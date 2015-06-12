//
//  ReceivablesViewController.swift
//  Debter
//
//  Created by Samu Tuominen on 11.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

class ReceivablesViewController: NSViewController, EventAddedDelegate {

    @IBOutlet weak var owerTable: VibrancyTable! // id = "owerTable"
    @IBOutlet weak var incomeTable: VibrancyTable! // id = "incomeTale"
    @IBOutlet weak var removeOwerButton: NSButton!
    @IBOutlet weak var removeEventButton: NSButton!
    
    @IBOutlet weak var recsController: NSArrayController!
    @IBOutlet weak var owerController: NSArrayController!
    lazy var moc = CoreDataStackManager.sharedManager.managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // EventAddedDelegate
    func newEventAdded(sender: AddNewViewController, isDebt: Bool, isReceivable: Bool) {
        guard isReceivable == true else {
            return
        }
        print("delegate toimii saatavissa")
    }
    
    @IBAction func removeOwer(sender: AnyObject) {
        
    }
    
    @IBAction func removeEvent(sender: AnyObject) {
        
        let selections = incomeTable.selectedRowIndexes
        
        guard selections.count > 0 else {
            return
        }
        
        for item in selections {
            let obj = recsController.arrangedObjects[item] as! Event
            moc.deleteObject(obj)
        }
        
        do {
            try moc.save()
        } catch {
            print("Error while saving after removing debts.")
        }
        
        let columns = owerTable.tableColumns as [NSTableColumn]
        for index in 0..<columns.count where columns[index].identifier == "total" {
            owerTable.reloadDataForRowIndexes(owerTable.selectedRowIndexes, columnIndexes: NSIndexSet(index: index))
        }
        
        if !recsController.canSelectPrevious { recsController.selectNext(self) }
        else { recsController.selectPrevious(self) }
        
        if incomeTable.selectedRowIndexes.count < 1 { removeEventButton.enabled = false }
    }
}


extension ReceivablesViewController: NSTableViewDelegate {
 
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let myView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        if tableColumn?.identifier == "total" {
            let obj = owerController.arrangedObjects[row] as! Ower
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
        
        if owerController.canRemove { removeOwerButton.enabled = true }
        else { removeOwerButton.enabled = false }
        
        if recsController.canRemove { removeEventButton.enabled = true }
        else { removeEventButton.enabled = false }
    }
    
    
}
