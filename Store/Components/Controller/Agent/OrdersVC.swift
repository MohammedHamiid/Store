//
//  OrdersVC.swift
//  Store
//
//  Created by Mohamed on 8/19/20.
//  Copyright © 2020 MohamedHamid. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class OrdersVC: UIViewController {
    
    var orders = [OrdersModel]()
    
    @IBOutlet weak var orderTV: UITableView!
    
    // Sound from url
    var player: AVPlayer?
    func audioPlayer(path : String) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            player = AVPlayer(url: URL.init(string: path)!)
            let controller = AVPlayerViewController()
            controller.player = player
            controller.showsPlaybackControls = false
            player?.play()
        } catch {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveOrders()
    }
    
    @IBAction func popButton(_ sender: Any) {
        popVC()
    }
    
    
    func retrieveOrders () {
        BaseFirebase.retrieveData(child: "Orders") { (snapshotValue) in
            let userName = snapshotValue!["NamePerson"]!
            let productName = snapshotValue!["NameProduct"]!
            let numberKilo = snapshotValue!["NumberOfKilo"]!
            let price = snapshotValue!["Price"]!
            let lat = snapshotValue!["Lat"]!
            let lon = snapshotValue!["Lon"]!
            let path = snapshotValue!["PathRecord"]!
            
            let order = OrdersModel()
            order.nameUser = userName
            order.nameProduct = productName
            order.numberOfKilo = numberKilo
            order.priceProduct = price
            order.lat = lat
            order.lon = lon
            order.pathRecord = path
            
            self.orders.append(order)
            self.orderTV.reloadData()
        }
    }
}
