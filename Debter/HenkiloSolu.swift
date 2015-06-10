//
//  HenkiloSolu.swift
//  Debter
//
//  Created by Samu Tuominen on 11.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

class HenkiloSolu: NSView {

    @IBOutlet weak var summakentta: NSTextField!
    @IBOutlet weak var nimikentta: NSTextField!
    
    var nimi: String {
        get {
            return nimikentta.stringValue
        } set {
            nimikentta.stringValue = newValue
        }
    }
    
    var summa: Double {
        get {
            return summakentta.doubleValue
        } set {
            summakentta.doubleValue = newValue
        }
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
}
