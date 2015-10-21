//
//  Helper.swift
//  Debter
//
//  Created by Samu Tuominen on 10.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

class Helper: NSObject {
    
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
        } catch {
            print("Error when fetching")
        }
        
        return results
    }
    
    class func removeSelectedPerson(table: NSTableView, controller: NSArrayController, context: NSManagedObjectContext, button: NSButton) {
        
        let num = table.selectedRow
        guard num > -1 else {
            return
        }
        
        let person = controller.arrangedObjects[num] as! NSManagedObject
        context.deleteObject(person)
        
        do {
            try context.save()
        } catch {
            print("Error while saving after removing persons!")
        }
        
        controller.selectPrevious(self)
        if table.selectedColumnIndexes.count < 1 { button.enabled = false }
    }
    
    class func removeSelectedEvents(personTable: NSTableView, eventTable: NSTableView, controller: NSArrayController, context: NSManagedObjectContext, button: NSButton) {
        
        let selections = eventTable.selectedRowIndexes
        guard selections.count > 0 else {
            return
        }
        
        for item in selections {
            let obj = controller.arrangedObjects[item] as! NSManagedObject
            context.deleteObject(obj)
        }
        
        do {
            try context.save()
        } catch {
            print("Error while saving after removing events")
        }
        
        // Update totalcolums
        let columns = personTable.tableColumns as [NSTableColumn]
        for i in 0..<columns.count where columns[i].identifier == "total" {
            personTable.reloadDataForRowIndexes(personTable.selectedRowIndexes, columnIndexes: NSIndexSet(index: i))
        }
        if eventTable.selectedRowIndexes.count < 1 { button.enabled = false }
    }
    
    
    
}

