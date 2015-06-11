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
    
    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.appearance = NSAppearance(named: NSAppearanceNameVibrantDark)
        self.window?.title = "Debter"
        
        /*saatavaVC = storyboard?.instantiateControllerWithIdentifier("SaatavaVC") as? SaatavaViewController
        self.contentViewController = saatavaVC*/
    }
    
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addNewEvent" {
            print("Segue oikein")
        }
    }
    
    @IBAction func selectedSegmentChanged(sender: AnyObject) {
        print(segmentControl.selectedSegment)
    }
    

}

