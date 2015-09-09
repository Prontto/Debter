//
//  SettingsWindowController.swift
//  Debter
//
//  Created by Samu Tuominen on 9.9.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

class SettingsWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    convenience init() {
        self.init(windowNibName: "SettingsWindowController")
    }
    
    // At least there must be one setting where user can choose if they want accept different debts with same owner names....
}
