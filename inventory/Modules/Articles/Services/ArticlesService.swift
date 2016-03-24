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
    
    func updateArticle(article: Article, success: () -> Void, failure: (error: NSError?) -> Void) {
        
        let json = article.getJson()
        let uiRealm = try! Realm();
        
        self.request(.PUT, uri: "articles/\(article.id)", parameters: json, encoding: .JSON, success: { (response) -> Void in
            
            do {
                try uiRealm.write({ () -> Void in
                    article.updated = true;
                    uiRealm.add(article, update: true)
                })
            } catch {
                print("DB Realm insert failed")
            }
            
            success()
            
            }) { (error) -> Void in
            
                do {
                    try uiRealm.write({ () -> Void in
                        article.updated = false;
                        uiRealm.add(article, update: true)
                    })
                } catch {
                    print("DB Realm insert failed")
                }
                
                failure(error: error)
        }
    }
}
