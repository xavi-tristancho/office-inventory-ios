//
//  ArticlesService.swift
//  inventory
//
//  Created by Xavier Tristancho Bordoy on 24/2/16.
//  Copyright © 2016 xavitb3. All rights reserved.
//

import UIKit
import ObjectMapper

class ArticlesService: INVApiClient {

    func indexArticles(success: (response: [Article]) -> Void, failure: (error: NSError?) -> Void){
        
        self.request(.GET, uri: "articles", parameters: ["filter" : ["include" : ["family", "provider"]]], encoding: .URL, success: { (response) -> Void in
            
            let articles = Mapper<Article>().mapArray(response)
            success(response: articles!)
            
            }) { (error) -> Void in
                
        }
    }
}
