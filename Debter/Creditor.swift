//
//  Creditor.swift
//  Debter
//
//  Created by Samu Tuominen on 11.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//

import Foundation
import CoreData

@objc(Creditor)
class Creditor: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    var debtTotal: Double = 0.0
    var total: Double {
        get {
            var sum = 0.0
            for item in self.events?.allObjects as! [Event] {
                sum += item.sum!.doubleValue
            }
            return sum
        }
        set {
            debtTotal = newValue
        }
    }
}
