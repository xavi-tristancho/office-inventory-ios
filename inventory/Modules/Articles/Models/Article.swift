//
//  Article.swift
//  inventory
//
//  Created by Xavier Tristancho Bordoy on 24/2/16.
//  Copyright © 2016 xavitb3. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Article: Object, Mappable {
    
    dynamic var id            = 0
    dynamic var family        : Family? = nil
    dynamic var name          = ""
    dynamic var reference     = ""
    dynamic var purchasePrice = 0
    dynamic var costPrice     = 0
    dynamic var sellPrice     = 0
    dynamic var quantity      = 0
    dynamic var createdAt     = NSDate(timeIntervalSince1970: 1)
    dynamic var updatedAt     = NSDate(timeIntervalSince1970: 1)
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id            <- map["id"]
        family        <- map["family"]
//        provider      <- map["provider"]
        name          <- map["name"]
        reference     <- map["reference"]
        purchasePrice <- map["purchase_price"]
        costPrice     <- map["cost_price"]
        sellPrice     <- map["sell_price"]
        quantity      <- map["quantity"]
        createdAt     <- map["created_at"]
        updatedAt     <- map["updated_at"]
    }
}
