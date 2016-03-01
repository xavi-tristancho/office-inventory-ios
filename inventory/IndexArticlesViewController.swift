//
//  IndexArticlesViewController.swift
//  inventory
//
//  Created by Xavier Tristancho Bordoy on 24/2/16.
//  Copyright © 2016 xavitb3. All rights reserved.
//

import UIKit

class IndexArticlesViewController: INVTableViewController {

    var articlesService : ArticlesService!
    var detailViewController: ShowArticleViewController? = nil
    var articles = [Article]()
    var tappedIndexPath : NSIndexPath?
    
    override func customInit(){
        super.customInit()
        articlesService = ArticlesService()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpRefreshControl("indexArticlesApi")

//        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
//        self.navigationItem.rightBarButtonItem = addButton
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ShowArticleViewController
        }                
        
        indexArticles(true)
    }
    
    func indexArticlesApi(){
        indexArticles(false)
    }
    
    func indexArticles(offline: Bool){
        
        self.startLoader()
        articlesService.indexArticles(offline, success: { (response) -> Void in
            
            self.articles = response
            self.tableView.reloadData()
            self.stopLoader()
            
            }) { (error) -> Void in

                self.stopLoader()
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
        
        if tappedIndexPath != nil{
            self.tableView.reloadRowsAtIndexPaths([tappedIndexPath!], withRowAnimation: .None)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = articles[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! ShowArticleViewController
                controller.article = object
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let article = articles[indexPath.row]
        cell.textLabel!.text = article.name
        
        tappedIndexPath = indexPath
        
        return cell
    }
}

