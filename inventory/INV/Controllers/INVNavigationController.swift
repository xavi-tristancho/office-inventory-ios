//
//  INVNavigationController.swift
//  inventory
//
//  Created by Xavier Tristancho Bordoy on 25/2/16.
//  Copyright © 2016 xavitb3. All rights reserved.
//

import UIKit

class INVNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTitle()
        setUpBackButtonImage()
    }
    
    func setUpTitle(){
        navigationBar.barTintColor = UIColor(hexString: "#47b8e0")
        let titleFont = UIFont(name: "Avenir-Roman", size: 22)
        navigationBar.titleTextAttributes = [NSFontAttributeName: titleFont!]
    }
    
    func setUpBackButtonImage(){
        let backButton = UIBarButtonItem(image:UIImage(named: "back-button"), style:.Plain, target:self, action: "popViewController");
        backButton.tintColor = UIColor(hexString: "fff")
        navigationItem.leftBarButtonItem = backButton
    }
    
    func popViewController(){
        self.navigationController?.popViewControllerAnimated(true)
    }
}
