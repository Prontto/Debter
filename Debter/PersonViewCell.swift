//
//  HenkiloSolu.swift
//  Debter
//
//  Created by Samu Tuominen on 11.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

class PersonViewCell: NSView {

    @IBOutlet weak var sumField: NSTextField!
    @IBOutlet weak var nameField: NSTextField!
    
    var name: String {
        get {
            return nameField.stringValue
        } set {
            nameField.stringValue = newValue
        }
    }
    
    var sum: Double {
        get {
            return sumField.doubleValue
        } set {
            sumField.doubleValue = newValue
        }
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
    }
    
}
