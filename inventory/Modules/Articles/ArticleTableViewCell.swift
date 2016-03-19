//
//  ArticleTableViewCell.swift
//  inventory
//
//  Created by Xavier Tristancho Bordoy on 19/3/16.
//  Copyright © 2016 xavitb3. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var cost: UILabel!
    @IBOutlet var quantity: UILabel!
    @IBOutlet var total: UILabel!
    

    func configure(article: Article){
        
        title.text = article.name;
        cost.text = String(article.costPrice) + " €";
        quantity.text = String(article.quantity);
        total.text = String(article.costPrice * Double(article.quantity)) + " €";
    }
}
