//
//  Provider.swift
//  inventory
//
//  Created by Xavier Tristancho Bordoy on 24/2/16.
//  Copyright © 2016 xavitb3. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Provider: Object, Mappable {

    dynamic var id   = 0
    dynamic var name = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id   <- map["id"]
        name <- map["name"]
    }
}
