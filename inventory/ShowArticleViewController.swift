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

    override func viewDidLoad() {
        super.viewDidLoad()
        form  +++=
            
        TextRow("name") {
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
        
        <<< DecimalRow("quantity") {
            $0.title = "Cantidad"
            $0.value = article!.quantity
        }
        
        form +++ Section("")
        
            <<< ButtonRow("Rows") {
                $0.title = "Guardar"
                $0.onCellSelection(didTapSaveButton)
        }
        
    }
    
    func didTapSaveButton(cell: ButtonCellOf<String>, row: ButtonRow) {
        
        let values = form.values()
        let editedArticle = Article(article: article!, eurekaDictionary: values)
        
        let uiRealm = try! Realm()
        do {
            try uiRealm.write({ () -> Void in
                    uiRealm.add(editedArticle, update: true)
            })
        } catch {
            print("DB Realm insert failed")
        }
    }
}

