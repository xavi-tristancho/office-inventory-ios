//
//  INVSync.swift
//  inventory
//
//  Created by Xavier Tristancho Bordoy on 26/2/16.
//  Copyright © 2016 xavitb3. All rights reserved.
//

import UIKit
import RealmSwift

class INVSync: NSObject {
    
    static let uiRealm = try! Realm();
    
    static func migrate () {
        
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config            
    }
    
    static func saveRecords(records : NSArray) {
        
        do {            
            try uiRealm.write({ () -> Void in
                for record in records{
                    uiRealm.add(record as! Object, update: true)
                }
            })
        } catch {
            print("DB Realm insert failed")
        }
    }
    
    static func saveRecord(record: Object) {

        do {
            try uiRealm.write({ () -> Void in
                uiRealm.add(record, update: true)
            })
        } catch {
            print("DB Realm insert failed")
        }
    }
    
    static func readRecords(record: Object.Type) -> [Object]? {
        
        let records = uiRealm.objects(record)
        
        return Array(records)
    }
    
    static func findRecords(record: Object.Type, filter: NSPredicate) -> [Object]? {
        
        let records = uiRealm.objects(record).filter(filter)
        
        return Array(records)
    }
}
