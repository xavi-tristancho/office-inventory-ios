//
//  Loadable.swift
//  inventory
//
//  Created by Xavier Tristancho Bordoy on 29/2/16.
//  Copyright © 2016 xavitb3. All rights reserved.
//

import Foundation
import BusyNavigationBar

protocol Loadable {
    
    var options: BusyNavigationBarOptions! { get set }
    var navigation: UINavigationController! { get set }
    var refresh: UIRefreshControl! { get set }
    
    func startLoader()
    func stopLoader()
}

extension Loadable {
    
    func startLoader(){
        navigation.navigationBar.start(options)
    }
    
    func stopLoader(){
        navigation.navigationBar.stop()
        refresh!.endRefreshing()
    }
}