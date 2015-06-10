//
//  LisaaUusiViewController.swift
//  Debter
//
//  Created by Samu Tuominen on 11.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

class LisaaUusiViewController: NSViewController {

    @IBOutlet var saatavaRadio: NSButton!
    @IBOutlet var velkaRadio: NSButton!
    @IBOutlet var nimiField: NSTextField!
    @IBOutlet var summaField: NSTextField!
    @IBOutlet var kuvaField: NSTextField!
    @IBOutlet var datePicker: NSDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    @IBAction func valmis(sender: AnyObject) {
    }
    
    @IBAction func peruuta(sender: AnyObject) {
    }
}
