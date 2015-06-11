//
//  MainWindowController.swift
//  Debter
//
//  Created by Samu Tuominen on 11.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    @IBOutlet weak var segmentControl: NSSegmentedControl! // receivables = 0, debts = 1
    
    var totalDebts = 0.0
    var totalReceivables = 0.0
    
    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.appearance = NSAppearance(named: NSAppearanceNameVibrantDark)
        
        /*saatavaVC = storyboard?.instantiateControllerWithIdentifier("SaatavaVC") as? SaatavaViewController
        self.contentViewController = saatavaVC*/
    }
    
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "addNewEvent" {
            let debtVC = contentViewController as! DebtViewController
            let addNewVC = segue.destinationController as! AddNewViewController
            addNewVC.delegate = debtVC
        }
    }

    @IBAction func selectedSegmentChanged(sender: AnyObject) {
        print(segmentControl.selectedSegment)
    }
    
}

