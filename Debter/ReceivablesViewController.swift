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
        
    }
}


extension ReceivablesViewController: NSTableViewDelegate {
    
}
