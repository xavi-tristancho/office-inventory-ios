//
//  ArticlesService.swift
//  inventory
//
//  Created by Xavier Tristancho Bordoy on 24/2/16.
//  Copyright © 2016 xavitb3. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class ArticlesService: INVApiClient {

    func indexArticles(offline: Bool, success: (response: [Article]) -> Void, failure: (error: NSError?) -> Void){
        
        if offline {
            let articles = INVSync.readRecords(Article) as! [Article]
            
            if articles.count == 0 {
                requestIndexArticles(success, failure: failure)
            }
            else {
                success(response: articles)
            }
        }
        else{
            requestIndexArticles(success, failure: failure)
        }
    }
    
    func requestIndexArticles(success: (response: [Article]) -> Void, failure: (error: NSError?) -> Void){
        self.request(.GET, uri: "articles", parameters: ["filter" : ["include" : ["family", "provider"]]], encoding: .URL, success: { (response) -> Void in
            
            let articles = Mapper<Article>().mapArray(response)!
            success(response: articles)
            INVSync.saveRecords(articles)
            
            }) { (error) -> Void in
                
                failure(error: error)
        }
    }
}
