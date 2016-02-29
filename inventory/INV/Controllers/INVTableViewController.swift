//
//  INVTableViewController.swift
//  inventory
//
//  Created by Xavier Tristancho Bordoy on 25/2/16.
//  Copyright © 2016 xavitb3. All rights reserved.
//

import UIKit
import BusyNavigationBar

class INVTableViewController: UITableViewController, Loadable {
    
    var options: BusyNavigationBarOptions!
    var navigation: UINavigationController!
    var refresh: UIRefreshControl!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        customInit()
    }
    
    func customInit(){
        options = BusyNavigationBarOptions()
        navigation = self.navigationController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    func setUpTableView(){
        self.tableView.backgroundColor = UIColor(hexString: "#9baec8")
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }        
    
    func setUpRefreshControl(selector: Selector){
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.backgroundColor = UIColor.clearColor()
        self.refreshControl?.tintColor = UIColor.blackColor()
        self.refreshControl?.addTarget(self, action: selector, forControlEvents: UIControlEvents.ValueChanged)
        refresh = refreshControl
    }
}
