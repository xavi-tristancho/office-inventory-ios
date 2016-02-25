//
//  INVTableViewController.swift
//  inventory
//
//  Created by Xavier Tristancho Bordoy on 25/2/16.
//  Copyright © 2016 xavitb3. All rights reserved.
//

import UIKit
import BusyNavigationBar

class INVTableViewController: UITableViewController {

    var options = BusyNavigationBarOptions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpNavigationLoader()
    }
    
    func setUpTableView(){
        self.tableView.backgroundColor = UIColor(hexString: "#9baec8")
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    func setUpNavigationLoader(){
        self.options = BusyNavigationBarOptions()
        options.animationType = .Stripes
        options.color = UIColor(hexString: "#fff")
    }
    
    func startLoader(){
        self.navigationController?.navigationBar.start(options)
    }
    
    func stopLoader(){
        self.navigationController?.navigationBar.stop()
        self.refreshControl?.endRefreshing()
    }
    
    func setUpRefreshControl(selector: Selector){
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.backgroundColor = UIColor.clearColor()
        self.refreshControl?.tintColor = UIColor.blackColor()
        self.refreshControl?.addTarget(self, action: selector, forControlEvents: UIControlEvents.ValueChanged)
    }
}
