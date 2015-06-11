//
//  MainWindowController.swift
//  Debter
//
//  Created by Samu Tuominen on 11.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    enum SegueTunniste: String {
        case LisaaUusi = "lisaaTapahtuma"
    }
    
    @IBOutlet var mySegmentControl: NSSegmentedControl! // Saatavat = 0, Velat = 1
    
    override func windowDidLoad() {
        super.windowDidLoad()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        self.window?.appearance = NSAppearance(named: NSAppearanceNameVibrantDark)
        self.window?.titleVisibility = .Hidden
        
        
        /*saatavaVC = storyboard?.instantiateControllerWithIdentifier("SaatavaVC") as? SaatavaViewController
        self.contentViewController = saatavaVC*/
    }
    
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "lisaaTapahtuma" {
            print("Segue oikein")
        }
    }
    
    @IBAction func segmentVaihtui(sender: AnyObject) {
        print(mySegmentControl.selectedSegment)
    }
    

}

