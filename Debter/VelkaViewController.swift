//
//  ViewController.swift
//  Debter
//
//  Created by Samu Tuominen on 10.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

class VelkaViewController: NSViewController {

    private enum KolumninTunniste: String {
        case Pvm = "pvm"
        case Summa = "summa"
        case Kuvaus = "kuvaus"
        case Nimi = "nimi"
    }
    
    private var velat = [Velka]()
    private var velkojat = [Velkoja]()
    
    /*lazy var moc: NSManagedObjectContext = {
        let appi = NSApplication.sharedApplication().delegate as! AppDelegate
        let moc = appi.managedObjectContext
        return moc
    }()*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*let mina = Helper.insertManagedObject("Velkoja", moc: moc) as! Velkoja
        mina.nimi = "Samu Tuominen"
        
        let testi = Helper.insertManagedObject("Velka", moc: moc) as! Velka
        testi.pvm = NSDate()
        testi.summa = 4.5
        testi.kuvaus = "Sätkäpurut"
        testi.velkoja = mina*/
        
        //updateTableView()
        
        
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    /*func updateTableView() {
        let velkaTulokset = Helper.fetchEntities("Velka", predicate: nil, moc: moc)
        let velkojaTulokset = Helper.fetchEntities("Velkoja", predicate: nil, moc: moc)
        velat = velkaTulokset as! [Velka]
        velkojat = velkojaTulokset as! [Velkoja]
    }*/

}

extension VelkaViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return velat.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        // Jotain pitää palauttaa, mutta aina ei palautettavaa löydy, joten tämä Applelta pöllitty käytäntö määritellä alussa optional palautusView vaikuttaa loistavalta.
        let palautusView: NSView?
        let identifier = tableColumn!.identifier
        
        if let tunniste = KolumninTunniste(rawValue: identifier) {
            
            let solu = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
            let textField = solu.textField!
            
            let velka = velat[row]
            let velkoja = velkojat[row]
            
            switch tunniste {
                
            case .Pvm:
                textField.objectValue = velka.pvm
                
            case .Summa:
                textField.doubleValue = velka.summa.doubleValue
                
            case .Kuvaus:
                textField.stringValue = velka.kuvaus
                
            case .Nimi:
                textField.stringValue = velkoja.nimi
            }
            
            palautusView = solu
            
        } else {
            palautusView = nil
        }
        
        return palautusView
    }
    
    
    
}



