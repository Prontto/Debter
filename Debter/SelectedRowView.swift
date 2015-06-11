//
//  SelectedRowView.swift
//  Debter
//
//  Created by Samu Tuominen on 11.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

class SelectedRowView: NSTableRowView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        if selected {
            NSColor(SRGBRed: 75/255, green: 109/255, blue: 255/255, alpha: 1).set()
            NSRectFill(dirtyRect)
        }
    }
    
}
