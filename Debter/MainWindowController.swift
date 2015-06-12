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
    
    // I have only two tabs and I think it's easier just changing windows contentViewController's than using TabViewController, especially when I working with NSVisualEffectView.
    private var recsVC: ReceivablesViewController?
    private var debtVC: DebtViewController?
    
    // For selected segment, 0 = Receivables, 1 = Debts
    private var current = 0
    // If I choose to use these in windows title
    private var totalDebts = 0.0
    private var totalReceivables = 0.0
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        window?.title = "Debter"
        window?.appearance = NSAppearance(named: NSAppearanceNameVibrantDark)
        
        recsVC = storyboard?.instantiateControllerWithIdentifier("RecsVC") as? ReceivablesViewController
        debtVC = storyboard!.instantiateControllerWithIdentifier("DebtVC") as? DebtViewController
        
        window?.contentViewController = recsVC
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addNewEvent" {
            let addNewVC = segue.destinationController as! AddNewViewController
            addNewVC.titleDelegate = self
            addNewVC.debtDelegate = debtVC
            addNewVC.recDelegate = recsVC
        }
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
    
    // Delegate if I want window's title to be updated when user adds new events, so I can calculate my debts and receivables.
    func newEventAdded(sender: AddNewViewController, isDebt: Bool, isReceivable: Bool) {
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
