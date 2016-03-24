//
//  DetailViewController.swift
//  inventory
//
//  Created by Xavier Tristancho Bordoy on 24/2/16.
//  Copyright © 2016 xavitb3. All rights reserved.
//

import UIKit
import Eureka
import RealmSwift

class ShowArticleViewController: FormViewController {

    var article: Article?
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        save()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (article != nil)
        {            
            form  +++=
                
                LabelRow("family") {
                    $0.title = "Familia"
                    $0.value = article!.family?.name
                }
                
                <<< LabelRow("provider") {
                    $0.title = "Proveedor"
                    $0.value = article!.provider?.name
                }
                
                <<< TextRow("name") {
                    $0.title = "Nombre"
                    $0.value = article!.name
                }
                
                <<< TextRow("reference") {
                    $0.title = "Referencia"
                    $0.value = article!.reference
                }
                
                <<< DecimalRow("purchase_price") {
                    $0.title = "Precio de Compra"
                    $0.value = article!.purchasePrice
                }
                
                <<< DecimalRow("cost_price") {
                    $0.title = "Precio de Coste"
                    $0.value = article!.costPrice
                }
                
                <<< DecimalRow("sell_price") {
                    $0.title = "Precio de Venta"
                    $0.value = article!.sellPrice
                }
                
                <<< IntRow("quantity") {
                    $0.title = "Cantidad"
                    $0.value = article!.quantity
            }
        }
    }
    
    func save(){
        
        if (article != nil)
        {            
            let values = form.values()
            let editedArticle = Article(article: article!, eurekaDictionary: values)                        
            
            let articleService = ArticlesService()
            articleService.updateArticle(editedArticle, success: { (response) -> Void in
                
                }, failure: { (error) -> Void in
                    
            })
        }
    }
}

