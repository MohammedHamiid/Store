//
//  MainVC.swift
//  Store
//
//  Created by Mohamed on 8/18/20.
//  Copyright © 2020 MohamedHamid. All rights reserved.
//

import UIKit
import Firebase

class MainVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func agentOrUserButton(_ sender: UIButton) {
        
        if sender.tag == 1 { // agent
            present (identifire : "LoginVC" )
        }else{ // user
            poshWithoutData(identifire: "VegetablesVC")
        }
    }
}

