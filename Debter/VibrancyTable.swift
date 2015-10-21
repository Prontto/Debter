//
//  SaatavaTaulukko.swift
//  Debter
//
//  Created by Samu Tuominen on 11.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

class VibrancyTable: NSTableView {
    // Just overriding this method so I get that nice alternative row colors by default.
    override var allowsVibrancy: Bool { return true }
}
