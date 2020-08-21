//
//  ExVegetables.swift
//  Store
//
//  Created by Mohamed on 8/18/20.
//  Copyright © 2020 MohamedHamid. All rights reserved.
//

import UIKit

extension VegetablesVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VegetablesCell
        cell.updateView(product: products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        poshWithData(identifire: "DetailsOrderVC", myView: DetailsOrderVC.self) { (vc) in
            vc?.nameProduct = self.products[indexPath.row].nameProduct
            vc?.priceProduct = self.products[indexPath.row].priceProduct
        }
    }
}
