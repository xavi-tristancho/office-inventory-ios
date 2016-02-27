//
//  DetailViewController.swift
//  inventory
//
//  Created by Xavier Tristancho Bordoy on 24/2/16.
//  Copyright © 2016 xavitb3. All rights reserved.
//

import UIKit
import Eureka

class ShowArticleViewController: FormViewController {

    var article: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        form +++= TextRow() {
            $0.title = "Nombre"
            $0.value = article!.name
        }
    }
}

