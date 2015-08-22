//
//  ReceivablesViewController.swift
//  Debter
//
//  Created by Samu Tuominen on 11.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

@objc protocol ReceivableDelegate {
    func recOrOwerDeleted(sender: ReceivablesViewController)
}

class ReceivablesViewController: NSViewController, EventAddedDelegate {

    @IBOutlet weak var owerTable: VibrancyTable! // id = "owerTable"
    @IBOutlet weak var incomeTable: VibrancyTable! // id = "incomeTable"
    @IBOutlet weak var removeOwerButton: NSButton!
    @IBOutlet weak var removeEventButton: NSButton!
    @IBOutlet weak var recsController: NSArrayController!
    @IBOutlet weak var owerController: NSArrayController!
    
    lazy var moc = CoreDataStackManager.sharedManager.managedObjectContext
    
    weak var delegate: ReceivableDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // EventAddedDelegate
    func newEventAdded(sender: AddNewViewController, isDebt: Bool, isReceivable: Bool) {
        guard isReceivable == true else{
            return
        }
        owerTable.reloadData()
    }
    
    @IBAction func removeOwer(sender: AnyObject) {
        Helper.removeSelectedPerson(owerTable, controller: owerController, context: moc, button: removeOwerButton)
        delegate?.recOrOwerDeleted(self)
    }
    
    @IBAction func removeEvent(sender: AnyObject) {
        Helper.removeSelectedEvents(owerTable, eventTable: incomeTable, controller: recsController, context: moc, button: removeEventButton)
        delegate?.recOrOwerDeleted(self)
    }
}

// MARK: NSTableViewDelegate
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
    
    // I think there is better way to do this...
    func tableViewSelectionDidChange(notification: NSNotification) {
        
        if owerController.canRemove { removeOwerButton.enabled = true }
        else { removeOwerButton.enabled = false }
        
        if recsController.canRemove { removeEventButton.enabled = true }
        else { removeEventButton.enabled = false }

        if notification.object!.identifier == "incomeTable" {
            if incomeTable.selectedRowIndexes.count > 0 {
                removeEventButton.enabled = true
            }
        }
        
        
    }
    
}
