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
        saatavaRadio.state = 1
        velkaRadio.state = 0
        
        print("didload")
    }
    
    private func lisaaVelka() {
        
        // Pakollisille kentille uusi guard -syntaksi
        guard nimiField.stringValue != "" && summaField.stringValue != "" else {
            print("Ehdot eivät täyttyneet")
            return
        }
        
        // Jos yllä olevat ehdot täyttyvät, tämä lause suoritetaan viimeisenä.
        defer {
            delegate?.tapahtumaLisattiin(self, onVelka: true, onSaatava: false)
            tyhjennaKentat()
            dismissViewController(self)
        }
        
        
        let predi = NSPredicate(format: "nimi == %@", nimiField.stringValue)
        let fetch =  Helper.fetchEntities("Velkoja", predicate: predi, moc: moc) as! [Velkoja]
        
        print("Tuloksia samalla nimellä \(fetch.count) kappaletta")
        
        
        guard fetch.count > 0 else {
            
            // Jos fetch ei löydä saman nimistä velkojaa, niin tehdään uusi.
            let person = Helper.insertManagedObject("Velkoja", moc: moc) as! Velkoja
            person.nimi = nimiField.stringValue
            
            let uusiVelka = Helper.insertManagedObject("Velka", moc: moc) as! Velka
            uusiVelka.summa = summaField.doubleValue
            uusiVelka.pvm = datePicker.dateValue
            uusiVelka.kuvaus = kuvausField.stringValue
            uusiVelka.velkoja = person
            return
        }
        
        // Uusi velka, joka lisätään vanhan velkojan velkoihin.
        let uusiVelka = Helper.insertManagedObject("Velka", moc: moc) as! Velka
        uusiVelka.summa = summaField.doubleValue
        uusiVelka.pvm = datePicker.dateValue
        uusiVelka.kuvaus = kuvausField.stringValue
        // Fetch sisältää varmasti yhden tuloksen, joka on myös maksimi mitä sen pitäisi sisältääkään.
        uusiVelka.velkoja = fetch[0]
    }
    
    private func lisaaSaatava() {
        
        guard nimiField.stringValue != "" && summaField.stringValue != "" else {
            return
        }
        
        defer {
            delegate?.tapahtumaLisattiin(self, onVelka: true, onSaatava: false)
            tyhjennaKentat()
            dismissViewController(self)
        }
        
        let predi = NSPredicate(format: "nimi == %@", nimiField.stringValue)
        let fetch =  Helper.fetchEntities("Velallinen", predicate: predi, moc: moc) as! [Velallinen]
        
        guard fetch.count > 0 else {
            
            let person = Helper.insertManagedObject("Velallinen", moc: moc) as! Velallinen
            person.nimi = nimiField.stringValue
            
            let uusiSaatava = Helper.insertManagedObject("Saatava", moc: moc) as! Saatava
            uusiSaatava.summa = summaField.doubleValue
            uusiSaatava.pvm = datePicker.dateValue
            uusiSaatava.kuvaus = kuvausField.stringValue
            uusiSaatava.velallinen = person
            return
        }
        let uusiSaatava = Helper.insertManagedObject("Saatava", moc: moc) as! Saatava
        uusiSaatava.summa = summaField.doubleValue
        uusiSaatava.pvm = datePicker.dateValue
        uusiSaatava.kuvaus = kuvausField.stringValue
        uusiSaatava.velallinen = fetch[0]
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
    
    @IBAction func saatavaValittu(sender: AnyObject) {
        saatavaRadio.state = 1
        velkaRadio.state = 0
    }
    
    @IBAction func velkaValittu(sender: AnyObject) {
        saatavaRadio.state = 0
        velkaRadio.state = 1
    }
    
    
}
