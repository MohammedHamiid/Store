//
//  OrderCell.swift
//  Store
//
//  Created by Mohamed on 8/19/20.
//  Copyright © 2020 MohamedHamid. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {
    
    var goLocation : (()->())?
    var playRecord : (()->())?
    
    @IBOutlet weak var nameUserL: UILabel!
    @IBOutlet weak var nameProductL: UILabel!
    @IBOutlet weak var numberOfKiloL: UILabel!
    @IBOutlet weak var priceProductL: UILabel!
    
    @IBOutlet weak var recordB: RoundButton!
    
    
    func updateView (order:OrdersModel) {
        nameUserL.text = order.nameUser
        nameProductL.text = order.nameProduct
        numberOfKiloL.text = order.numberOfKilo
        priceProductL.text = order.priceProduct
        
        if order.pathRecord == "noPath"{
            recordB.isEnabled = false
            recordB.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 0.1962221746)
        }else{
            recordB.isEnabled = true
            recordB.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        }
    }
    
    @IBAction func goLocationButton(_ sender: Any) {
        self.goLocation?()
    }
    
    @IBAction func recordButton(_ sender: Any) {
        self.playRecord?()
    }
    
}
