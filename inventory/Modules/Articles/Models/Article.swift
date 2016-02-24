//
//  Article.swift
//  inventory
//
//  Created by Xavier Tristancho Bordoy on 24/2/16.
//  Copyright © 2016 xavitb3. All rights reserved.
//

import Foundation
import RealmSwift

class Article: Object {
    
    dynamic var id            = 0
    let family                = Family()
    let provider              = Provider()
    dynamic var name          = ""
    dynamic var reference     = ""
    dynamic var purchasePrice = 0
    dynamic var costPrice     = 0
    dynamic var sellPrice     = 0
    dynamic var quantity      = 0
    dynamic var createdAt     = NSDate(timeIntervalSince1970: 1)
    dynamic var updatedAt     = NSDate(timeIntervalSince1970: 1)
}
