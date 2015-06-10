//
//  Helper.swift
//  Debter
//
//  Created by Samu Tuominen on 10.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

class Helper: NSObject {

    enum Virhe: ErrorType {
        case FetchVirhe
    }
    
    class func insertManagedObject(luokanNimi: String, moc: NSManagedObjectContext) -> AnyObject {
        let managedObject = NSEntityDescription.insertNewObjectForEntityForName(luokanNimi, inManagedObjectContext: moc) as NSManagedObject
        return managedObject
    }
    
    class func fetchEntities(luokanNimi: String, predicate: NSPredicate?, moc: NSManagedObjectContext) -> [AnyObject] {
        
        let request = NSFetchRequest(entityName: luokanNimi)
        
        if predicate != nil {
            request.predicate = predicate
        }
        
        request.returnsObjectsAsFaults = false
        
        var tulokset = [AnyObject]()
        
        do {
            tulokset = try moc.executeFetchRequest(request)
            return tulokset
        } catch Virhe.FetchVirhe {
            print("Virhe fetcatessa Helper-luokan fukntiolla")
        } catch {
            
        }
        
        return tulokset
    }
    
    
    
}

