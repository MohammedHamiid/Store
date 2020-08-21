//
//  AddProductVC.swift
//  Store
//
//  Created by Mohamed on 8/18/20.
//  Copyright © 2020 MohamedHamid. All rights reserved.
//

import UIKit

class AddProductVC: UIViewController {
    
    @IBOutlet weak var nameProductTF: UITextField!
    @IBOutlet weak var priceProductTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gester = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gester)
    }
    
    @IBAction func popButton(_ sender: Any) {
        popVC()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let nameProduct = nameProductTF.text , !nameProduct.isEmpty else {
            presentAlertWith(msg: "Enter Name Of Product") {}
            return
        }
        
        guard let priceProduct = priceProductTF.text , !priceProduct.isEmpty else {
            presentAlertWith(msg: "Enter Price Of Product") {}
            return
        }
        
        let productDictionary = ["Name": nameProduct,"Price": priceProduct ]
        addProduct(dictionary: productDictionary)
    }
    
    func addProduct (dictionary : [String:String]) {
        BaseFirebase.sendData(child: "Products", dataDictionary: dictionary) { (success) in
            if success {
                self.presentAlertWith(msg: "Save Success ✔️") {}
                self.nameProductTF.text = ""
                self.priceProductTF.text = ""
                
            }else{
                self.presentAlertWith(msg: "Error ❌") {}
            }
        }
    }
    
}
