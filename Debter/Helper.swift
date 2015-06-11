//
//  Helper.swift
//  Debter
//
//  Created by Samu Tuominen on 10.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

/// Helper class for inserting entities and fetching them.
class Helper: NSObject {

    enum MyError: ErrorType {
        case FetchError
    }
    
    class func insertManagedObject(className: String, moc: NSManagedObjectContext) -> AnyObject {
        let managedObject = NSEntityDescription.insertNewObjectForEntityForName(className, inManagedObjectContext: moc) as NSManagedObject
        return managedObject
    }
    
    class func fetchEntities(className: String, predicate: NSPredicate?, moc: NSManagedObjectContext) -> [AnyObject] {
        
        let request = NSFetchRequest(entityName: className)
        
        if predicate != nil {
            request.predicate = predicate
        }
        
        request.returnsObjectsAsFaults = false
        
        var results = [AnyObject]()
        
        do {
            results = try moc.executeFetchRequest(request)
            return results
        } catch MyError.FetchError {
            print("Error when fetching")
        } catch {
            
        }
        
        return results
    }
    
    
    
}

