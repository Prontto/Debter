//
//  MainWindowController.swift
//  Debter
//
//  Created by Samu Tuominen on 11.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        //self.window?.appearance = NSAppearance(named: NSAppearanceNameVibrantDark)
        self.window?.titleVisibility = .Hidden
    }

}
