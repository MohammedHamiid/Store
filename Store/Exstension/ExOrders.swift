//
//  ExOrders.swift
//  Store
//
//  Created by Mohamed on 8/20/20.
//  Copyright © 2020 MohamedHamid. All rights reserved.
//

import UIKit

extension OrdersVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderCell
        cell.updateView(order: orders[indexPath.row])
        cell.goLocation = {
            self.poshWithData(identifire: "ClientLocationVC", myView: ClientLocationVC.self) { (vc) in
                vc?.lat = self.orders[indexPath.row].lat
                vc?.lon = self.orders[indexPath.row].lon
            }
            cell.playRecord = {
                self.audioPlayer(path: self.orders[indexPath.row].pathRecord)
            }
        }
        return cell
    }
    
}

