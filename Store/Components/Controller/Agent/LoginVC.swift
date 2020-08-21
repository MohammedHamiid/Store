//
//  LoginVC.swift
//  Store
//
//  Created by Mohamed on 8/18/20.
//  Copyright © 2020 MohamedHamid. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gester = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gester)
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        dismiss()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let password = passwordTF.text , !password.isEmpty else {
            presentAlertWith(msg: "Enter Password") {}
            return
        }
        
        if password == "123" {
            poshWithoutData(identifire: "StoreProductsVC")
        }else {
            presentAlertWith(msg: "Error Password ❌") {}
        }
    }
    
    
}
