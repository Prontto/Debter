//
//  MainWindowController.swift
//  Debter
//
//  Created by Samu Tuominen on 11.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, EventAddedDelegate, DebtDelegate, ReceivableDelegate {
    
    @IBOutlet weak var segmentControl: NSSegmentedControl! // their debts = 0, my debts = 1
    
    // I have only two tabs and I think it's easier just changing windows contentViewController's than using TabViewController, especially when I working with NSVisualEffectView.
    private var recsVC: ReceivablesViewController?
    private var debtVC: DebtViewController?

    // ManagedObjectContext
    lazy var moc = CoreDataStackManager.sharedManager.managedObjectContext
    
    // For selected segment, 0 = Receivables, 1 = Debts
    private var current = 0
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        window?.appearance = NSAppearance(named: NSAppearanceNameVibrantDark)
        
        recsVC = storyboard?.instantiateControllerWithIdentifier("RecsVC") as? ReceivablesViewController
        debtVC = storyboard!.instantiateControllerWithIdentifier("DebtVC") as? DebtViewController
        
        debtVC?.delegate = self
        recsVC?.delegate = self
        
        window?.contentViewController = recsVC
        
        calculateTotalsForWindowsTitle()
        
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        guard segue.identifier == "addNewEventSegue" else {
            return
        }
        let addNewVC = segue.destinationController as! AddNewViewController
        addNewVC.titleDelegate = self
        addNewVC.debtDelegate = debtVC
        addNewVC.recDelegate = recsVC
    }
    
    // Keyboard shortcuts for Command + 1 & Command + 2
    override func keyDown(theEvent: NSEvent) {
        if theEvent.keyCode == 18 && current != 0 {
            changeViewToRecs()
            segmentControl.setSelected(true, forSegment: 0)
            segmentControl.setSelected(false, forSegment: 1)
        }
        if theEvent.keyCode == 19 && current != 1 {
            changeViewToDebt()
            segmentControl.setSelected(false, forSegment: 0)
            segmentControl.setSelected(true, forSegment: 1)
        }
    }
    
    private func changeViewToDebt() {
        debtVC?.view.frame = (contentViewController?.view.frame)!
        contentViewController = debtVC
        current = 1
    }
    
    private func changeViewToRecs() {
        recsVC?.view.frame = (contentViewController?.view.frame)!
        contentViewController = recsVC
        current = 0
    }
    
    // Delegates
    func newEventAdded(sender: AddNewViewController, isDebt: Bool, isReceivable: Bool) {
        calculateTotalsForWindowsTitle()
    }
    
    func debtOrCreditorDeleted(sender: DebtViewController) {
        calculateTotalsForWindowsTitle()
    }
    
    func recOrOwerDeleted(sender: ReceivablesViewController) {
        calculateTotalsForWindowsTitle()
    }
 
    @IBAction func selectedSegmentChanged(sender: AnyObject) {
        guard current != segmentControl.selectedSegment else {
            return
        }
        if segmentControl.selectedSegment == 0 { changeViewToRecs() }
        else if segmentControl.selectedSegment == 1 { changeViewToDebt() }
        else { print("This should never be executed!") }
    }
    
    func calculateTotalsForWindowsTitle() {
        
        let personsForMyDebts = Helper.fetchEntities("Creditor", predicate: nil, moc: moc)
        let personsForTheirDebts = Helper.fetchEntities("Ower", predicate: nil, moc: moc)
        
        var debtsTotal = 0.0
        var recsTotal = 0.0
        
        for person in personsForMyDebts as! [Creditor]{
            let events = person.events.allObjects as! [Event]
            
            for event in events {
                debtsTotal += event.sum.doubleValue
            }
        }
        
        for person in personsForTheirDebts as! [Ower]{
            let events = person.events.allObjects as! [Event]
            
            for event in events {
                recsTotal += event.sum.doubleValue
            }
        }
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        
        window?.title = "Their debts total: \(formatter.stringFromNumber(recsTotal)!)    -    My debts total: \(formatter.stringFromNumber(debtsTotal)!)"
        
    }
    
}







