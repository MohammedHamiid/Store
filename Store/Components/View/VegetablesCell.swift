//
//  VegetablesCell.swift
//  Store
//
//  Created by Mohamed on 8/18/20.
//  Copyright © 2020 MohamedHamid. All rights reserved.
//

import UIKit

class VegetablesCell: UITableViewCell {
    
    @IBOutlet weak var nameProductL: UILabel!
    @IBOutlet weak var priceProductL: UILabel!
    
    func updateView (product:ProductsModel) {
        nameProductL.text = product.nameProduct
        priceProductL.text = "Price : \(product.priceProduct) EGP"
    }
    
}
