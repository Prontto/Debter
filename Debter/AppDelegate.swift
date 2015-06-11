//
//  AppDelegate.swift
//  Debter
//
//  Created by Samu Tuominen on 10.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        let moc = CoreDataStackManager.sharedManager.managedObjectContext
        let tulokset = Helper.fetchEntities("Velkoja", predicate: nil, moc: moc)
        print("Velkoja löytyi \(tulokset.count) kappaletta")
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        
        do {
            try CoreDataStackManager.sharedManager.managedObjectContext.save()
        } catch {
            print("Error seivatessa")
        }
        
    }

    

}

