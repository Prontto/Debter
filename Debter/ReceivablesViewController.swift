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

    @IBOutlet weak var owerTable: VibrancyTable!
    @IBOutlet weak var incomeTable: VibrancyTable!
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
        guard isReceivable == true else {
            return
        }
        owerTable.reloadData()
    }
    
    @IBAction func removeOwer(sender: AnyObject) {
        let selected = owerController.arrangedObjects as! [Ower]
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
        
        delegate?.recOrOwerDeleted(self)
        
        if owerController.arrangedObjects.count < 1 {
            removeOwerButton.enabled = false
            removeEventButton.enabled = false
        }
        
    }
    
    @IBAction func removeEvent(sender: AnyObject) {
        Helper.removeSelectedEvents(owerTable, eventTable: incomeTable, controller: recsController, context: moc, button: removeEventButton)
        delegate?.recOrOwerDeleted(self)
        if incomeTable.selectedRowIndexes.count < 1 { removeEventButton.enabled = false }
    }
}

// MARK: NSTableViewDelegate
extension ReceivablesViewController: NSTableViewDelegate {

    func tableView(tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return SelectedRowView()
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        
        if owerTable.selectedRowIndexes.count > 0 { removeOwerButton.enabled = true }
        else { removeOwerButton.enabled = false }
        
        if incomeTable.selectedRowIndexes.count > 0 { removeEventButton.enabled = true }
        else { removeEventButton.enabled = false }
    }
    
}
