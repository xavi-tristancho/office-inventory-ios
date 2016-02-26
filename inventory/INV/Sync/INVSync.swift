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
    
    static func saveRecords(records : NSArray){
        let uiRealm = try! Realm()
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
    
    static func readRecords(record: Object.Type) -> [Object]?{
        
        let uiRealm = try! Realm()
        
        let records = uiRealm.objects(record)
        
        return Array(records)
    }
}
