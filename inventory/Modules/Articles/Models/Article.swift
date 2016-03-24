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
    dynamic var provider      : Provider? = nil
    dynamic var name          = ""
    dynamic var reference     = ""
    dynamic var purchasePrice = 0.0
    dynamic var costPrice     = 0.0
    dynamic var sellPrice     = 0.0
    dynamic var quantity      = 0
    dynamic var createdAt     = NSDate(timeIntervalSince1970: 1)
    dynamic var updatedAt     = NSDate(timeIntervalSince1970: 1)
    dynamic var updated       = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    convenience init(article: Article, eurekaDictionary: [String : Any?]){
        self.init()
        
        self.id = article.id
        self.family = article.family
        self.provider = article.provider
        
        if let name = eurekaDictionary["name"] as? String {
            self.name = name
        }
        
        if let reference = eurekaDictionary["reference"] as? String {
            self.reference = reference
        }
        
        if let purchasePrice = eurekaDictionary["purchase_price"] as? Double {
            self.purchasePrice = purchasePrice
        }
        
        if let costPrice = eurekaDictionary["cost_price"] as? Double {
            self.costPrice = costPrice
        }
        
        if let sellPrice = eurekaDictionary["sell_price"] as? Double {
            self.sellPrice = sellPrice
        }
        
        if let quantity = eurekaDictionary["quantity"] as? Int {
            self.quantity = quantity
        }
        
        self.createdAt = article.createdAt
        self.updatedAt = article.updatedAt
        self.updated = article.updated;
    }
    
    func mapping(map: Map) {
        id            <- map["id"]
        family        <- map["family"]
        provider      <- map["provider"]
        name          <- map["name"]
        reference     <- map["reference"]
        purchasePrice <- map["purchase_price"]
        costPrice     <- map["cost_price"]
        sellPrice     <- map["sell_price"]
        quantity      <- map["quantity"]
        createdAt     <- map["created_at"]
        updatedAt     <- map["updated_at"]
    }
    
    func getJson() -> NSDictionary {
        
        let dict : NSDictionary = [
            "id" : self.id,
            "name" : self.name,
            "reference" : self.reference,
            "purchase_price" : self.purchasePrice,
            "cost_price" : self.costPrice,
            "sell_price" : self.sellPrice,
            "quantity" : self.quantity
        ]
        
        return dict
    }
}
