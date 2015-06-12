//
//  MainWindowController.swift
//  Debter
//
//  Created by Samu Tuominen on 11.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, EventAddedDelegate {
    
    @IBOutlet weak var segmentControl: NSSegmentedControl! // receivables = 0, debts = 1
    
    // I have only two tabs and I think it's easier just changing windows contentviewcontroller's than TabViewController, especially when I using NSVisualEffectView.
    private var recsVC: ReceivablesViewController?
    private var debtVC: DebtViewController?
    
    // For selected segment, 0 = Receivables, 1 = Debts
    private var current = 0
    // If I choose to use these in windows title
    private var totalDebts = 0.0
    private var totalReceivables = 0.0
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.appearance = NSAppearance(named: NSAppearanceNameVibrantDark)
        
        recsVC = storyboard?.instantiateControllerWithIdentifier("RecsVC") as? ReceivablesViewController
        debtVC = storyboard?.instantiateControllerWithIdentifier("DebtVC") as? DebtViewController
    }
    
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "addNewEvent" {
            let addNewVC = segue.destinationController as! AddNewViewController
            addNewVC.titleDelegate = self
            addNewVC.debtDelegate = debtVC
        }
    }
    
    override func keyDown(theEvent: NSEvent) {
        if theEvent.keyCode == 18 {
            guard current != 0 else {
                return
            }
            changeViewToRecs()
        }
        
        if theEvent.keyCode == 19 {
            guard current != 1 else {
                return
            }
            changeViewToDebt()
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
    
    // Delegate
    func newEventAdded(sender: AddNewViewController, isDebt: Bool, isReceivable: Bool) {
        window?.title = "Samu Tuominen"
    }
    
    

    @IBAction func selectedSegmentChanged(sender: AnyObject) {
        guard current != segmentControl.selectedSegment else {
            return
        }
        if segmentControl.selectedSegment == 0 { changeViewToRecs() }
        else if segmentControl.selectedSegment == 1 { changeViewToDebt() }
        else { print("This should never be executed!") }
    }
    
}

