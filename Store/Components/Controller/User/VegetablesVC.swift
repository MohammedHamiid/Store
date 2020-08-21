//
//  VegetablesVC.swift
//  Store
//
//  Created by Mohamed on 8/18/20.
//  Copyright © 2020 MohamedHamid. All rights reserved.
//

import UIKit
import Firebase

class VegetablesVC: UIViewController {
    
    var products = [ProductsModel]()
    @IBOutlet weak var productsTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsTV.register(UINib(nibName: "VegetablesCell", bundle: nil) , forCellReuseIdentifier: "cell")
        retrieveProducts()
    }
    
    @IBAction func changeRootButton(_ sender: Any) {
        changeRoot(identifire: "MainVC")
    }
    
    func retrieveProducts () {
        BaseFirebase.retrieveData(child: "Products") { (snapshotValue) in
            
            let productName = snapshotValue!["Name"]!
            let productPrice = snapshotValue!["Price"]!
            
            let product = ProductsModel()
            product.nameProduct = productName
            product.priceProduct = productPrice
            
            self.products.append(product)
            self.productsTV.reloadData()
        }
    }
    
}
