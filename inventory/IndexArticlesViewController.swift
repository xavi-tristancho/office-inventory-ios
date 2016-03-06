//
//  IndexArticlesViewController.swift
//  inventory
//
//  Created by Xavier Tristancho Bordoy on 24/2/16.
//  Copyright © 2016 xavitb3. All rights reserved.
//

import UIKit

class IndexArticlesViewController: INVTableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    var articlesService : ArticlesService!
    var detailViewController: ShowArticleViewController? = nil
    var articles = [Article]()
    var filteredArticles = [Article]()
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
        
        setUpSearchController()
    }
    
    func setUpSearchController(){
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredArticles = articles.filter { article in
            return article.name.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }
    
    func indexArticlesApi(){
        indexArticles(false)
    }
    
    func indexArticles(offline: Bool){
        
        self.startLoader()
        articlesService.indexArticles(offline, success: { (response) -> Void in
            
            self.articles = response
            self.articles.sortInPlace { $0.name < $1.name }
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
                tappedIndexPath = indexPath
                let article = getArticleForCell(indexPath)
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! ShowArticleViewController
                controller.article = article
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredArticles.count
        }
        return articles.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let article = getArticleForCell(indexPath)
        
        cell.textLabel!.text = article.name
        
        return cell
    }
    
    func getArticleForCell(indexPath: NSIndexPath) -> Article {
        
        let article : Article
        
        if searchController.active && searchController.searchBar.text != "" {
            article = filteredArticles[indexPath.row]
        } else {
            article = articles[indexPath.row]
        }
        
        return article;
    }
    
    
    @IBAction func didTapSeeTotal(sender: UIBarButtonItem) {
        
        var total = 0.0
        
        for article in articles {
            total =  total + Double(article.quantity) * article.costPrice
        }
        
        let ac = UIAlertController(title: "Total Inventario", message: "Tienes un total de \(total)€ en stock", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "Cerrar", style: .Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
        
    }
}

extension IndexArticlesViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
