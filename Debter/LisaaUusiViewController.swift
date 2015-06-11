//
//  LisaaUusiViewController.swift
//  Debter
//
//  Created by Samu Tuominen on 11.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

@objc protocol TapahtumaLisattyDelegate {
    func tapahtumaLisattiin(sender: LisaaUusiViewController, onVelka: Bool, onSaatava: Bool)
}

class LisaaUusiViewController: NSViewController {

    // Miksi näissä ei oletuksena tullut weak -sanaa?
    @IBOutlet var saatavaRadio: NSButton!
    @IBOutlet var velkaRadio: NSButton!
    @IBOutlet var nimiField: NSTextField!
    @IBOutlet var summaField: NSTextField!
    @IBOutlet var kuvausField: NSTextField!
    @IBOutlet var datePicker: NSDatePicker!
    
    lazy var moc = CoreDataStackManager.sharedManager.managedObjectContext
    
    weak var delegate: TapahtumaLisattyDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.dateValue = NSDate()
    }
    
    private func lisaaVelka() {
        
        // Pakollisille kentille uusi guard -syntaksi
        guard nimiField.stringValue != "" && summaField.stringValue != "" else {
            return
        }
        
        let uusi = Helper.insertManagedObject("Velka", moc: moc) as! Velka
        uusi.summa = summaField.doubleValue
        uusi.pvm = datePicker.dateValue
        uusi.kuvaus = kuvausField.stringValue
        let person = Helper.insertManagedObject("Velkoja", moc: moc) as! Velkoja
        person.nimi = nimiField.stringValue
        uusi.velkoja = person
        
        delegate?.tapahtumaLisattiin(self, onVelka: true, onSaatava: false)
    }
    
    private func tyhjennaKentat() {
        let kentat = [nimiField, summaField, kuvausField]
        for item in kentat {
            item.stringValue = ""
        }
    }
    
    
    
    
    @IBAction func valmis(sender: AnyObject) {
        lisaaVelka()
        tyhjennaKentat()
    }
    
    @IBAction func peruuta(sender: AnyObject) {
        
        let req = NSFetchRequest(entityName: "Velka")
        req.propertiesToFetch = ["summa"]
        req.returnsDistinctResults = true
        req.resultType = NSFetchRequestResultType.DictionaryResultType
        
        do {
            let tulokset = try moc.executeFetchRequest(req)
            print("Tuloksia löytyi \(tulokset.count) kappaletta")
            
            for item in tulokset {
                if let value = item["summa"] {
                    print(value!)
                }
            }
        } catch {
            print("Error")
        }
        
        
        tyhjennaKentat()
        //dismissViewController(self)
    }
    
    
}
