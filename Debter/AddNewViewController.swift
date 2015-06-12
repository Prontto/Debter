//
//  AddNewViewController.swift
//  Debter
//
//  Created by Samu Tuominen on 11.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

@objc protocol EventAddedDelegate {
    func newEventAdded(sender: AddNewViewController, isDebt: Bool, isReceivable: Bool)
}

class AddNewViewController: NSViewController {

    @IBOutlet weak var recRadioButton: NSButton!
    @IBOutlet weak var debtRadioButton: NSButton!
    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var sumField: NSTextField!
    @IBOutlet weak var descField: NSTextField!
    @IBOutlet weak var datePicker: NSDatePicker!
    
    lazy var moc = CoreDataStackManager.sharedManager.managedObjectContext
    
    weak var debtDelegate: EventAddedDelegate?
    weak var recDelegate: EventAddedDelegate?
    weak var titleDelegate: EventAddedDelegate?
    
    // For current selected radiobutton, 0 = receivable & 1 = debt
    var current = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.dateValue = NSDate()
        recRadioButton.state = 1
        debtRadioButton.state = 0
    }
    
    /// Add new Debt and if someone with same name exists, this new debt will be inserted to his debts.
    private func addDebt() {
        
        // Check that user have leaved these fields empty.
        guard nameField.stringValue != "" && sumField.stringValue != "" else {
            return
        }
    
        defer {
            debtDelegate?.newEventAdded(self, isDebt: true, isReceivable: false)
            emptyFields()
            dismissViewController(self)
        }
        
        let predi = NSPredicate(format: "name == %@", nameField.stringValue)
        let fetchResults =  Helper.fetchEntities("Creditor", predicate: predi, moc: moc) as! [Creditor]
        
        guard fetchResults.count > 0 else {
            
            let person = Helper.insertManagedObject("Creditor", moc: moc) as! Creditor
            person.name = nameField.stringValue
            
            let newDebt = Helper.insertManagedObject("Event", moc: moc) as! Event
            newDebt.sum = sumField.doubleValue
            newDebt.date = datePicker.dateValue
            newDebt.desc = descField.stringValue
            newDebt.creditor = person
        
            return
        }
        
        let newDebt = Helper.insertManagedObject("Event", moc: moc) as! Event
        newDebt.sum = sumField.doubleValue
        newDebt.date = datePicker.dateValue
        newDebt.desc = descField.stringValue
        newDebt.creditor = fetchResults[0]
    }
    
    /// Add new receivable and if someone with same name exists, this new debt will be inserted to his receivables.
    private func addReceivable() {
        guard nameField.stringValue != "" && sumField.stringValue != "" else {
            return
        }
        
        defer {
            recDelegate?.newEventAdded(self, isDebt: false, isReceivable: true)
            emptyFields()
            dismissViewController(self)
        }
        
        let predi = NSPredicate(format: "name == %@", nameField.stringValue)
        let fetchResults =  Helper.fetchEntities("Ower", predicate: predi, moc: moc) as! [Ower]
        
        guard fetchResults.count > 0 else {
            
            let person = Helper.insertManagedObject("Ower", moc: moc) as! Ower
            person.name = nameField.stringValue
            
            let newRec = Helper.insertManagedObject("Event", moc: moc) as! Event
            newRec.sum = sumField.doubleValue
            newRec.date = datePicker.dateValue
            newRec.desc = descField.stringValue
            newRec.ower = person
            
            return
        }
        
        let newRec = Helper.insertManagedObject("Event", moc: moc) as! Event
        newRec.sum = sumField.doubleValue
        newRec.date = datePicker.dateValue
        newRec.desc = descField.stringValue
        newRec.ower = fetchResults[0]
    }
    
    private func emptyFields() {
        let fields = [nameField, sumField, descField]
        for item in fields {
            item.stringValue = ""
        }
    }
    
    // MARK: - IBActions
    @IBAction func ready(sender: AnyObject) {
        if recRadioButton.state == 1 { addReceivable() }
        else if debtRadioButton.state == 1 { addDebt() }
        else { print("Something IS WRONG with radiobuttons!") }
    }
    
    @IBAction func cancel(sender: AnyObject) {
        emptyFields()
        dismissViewController(self)
    }
    
    @IBAction func recSelected(sender: AnyObject) {
        guard current == 1 else {
            return
        }
        recRadioButton.state = 1
        debtRadioButton.state = 0
        current = 0
    }
    
    @IBAction func debtSelected(sender: AnyObject) {
        guard current == 0 else {
            return
        }
        recRadioButton.state = 0
        debtRadioButton.state = 1
        current = 1
    }
    
    
}
