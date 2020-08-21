//
//  DetailsOrderVC.swift
//  Store
//
//  Created by Mohamed on 8/19/20.
//  Copyright © 2020 MohamedHamid. All rights reserved.
//

import UIKit

class DetailsOrderVC: UIViewController {
    
    // pass from vegetables VC
    var nameProduct = ""
    var priceProduct = ""
    
    // Edit
    var numberOfKilo : Double = 1
    
    // Send to Firebase
    var lat = ""
    var lon = ""
    
    var pathRecord = "noPath"
    
    // Outlets
    @IBOutlet weak var buttomScrollView: NSLayoutConstraint!
    
    @IBOutlet weak var nameProductL: UILabel!
    @IBOutlet weak var priceProductL: UILabel!
    
    @IBOutlet weak var numberOfKiloL: UILabel!
    @IBOutlet weak var PriceOfKiloL: UILabel!
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var locationB: RoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameProductL.text = nameProduct
        priceProductL.text = "Price: \(priceProduct) EGP"
        PriceOfKiloL.text = "Price: \(priceProduct) EGP"
        let gester = UITapGestureRecognizer(target: self, action: #selector(hide))
        view.addGestureRecognizer(gester)
    }
    
    @objc func hide () {
        view.endEditing(true)
        buttomScrollView.constant = 0
    }
    
    @IBAction func popButton(_ sender: Any) {
        popVC()
    }
    
    @IBAction func increaseDecreaseKilo(_ sender: UIButton) {
        
        if sender.tag == 1 { // increase
            numberOfKilo += 1
            numberOfKiloL.text = "\(numberOfKilo) Kilo"
            
            let totalPrice = Double(priceProduct)! * numberOfKilo
            PriceOfKiloL.text = "Price: \(totalPrice) EGP"
            
        }else{ // decrease
            
            guard numberOfKilo != 1 else {return}
            numberOfKilo -= 1
            numberOfKiloL.text = "\(numberOfKilo) Kilo"
            
            let totalPrice = Double(priceProduct)! * numberOfKilo
            PriceOfKiloL.text = "Price: \(totalPrice) EGP"
        }
        
    }
    
    @IBAction func increaseDecrease14Kilo(_ sender: UIButton) {
        
        if sender.tag == 1 { // increase
            numberOfKilo += 0.25
            numberOfKiloL.text = "\(numberOfKilo) Kilo"
            
            let totalPrice = Double(priceProduct)! * numberOfKilo
            PriceOfKiloL.text = "Price: \(totalPrice) EGP"
            
        }else{ // decrease
            
            guard numberOfKilo != 0.25 else {return}
            numberOfKilo -= 0.25
            numberOfKiloL.text = "\(numberOfKilo) Kilo"
            
            let totalPrice = Double(priceProduct)! * numberOfKilo
            PriceOfKiloL.text = "Price: \(totalPrice) EGP"
        }
        
    }
    
    @IBAction func LocationButton(_ sender: Any) {
        
        poshWithData(identifire: "LocationVC", myView: LocationVC.self) { (vc) in
            vc?.delegate = self
        }
    }
    
    @IBAction func voiceRecordButton(_ sender: Any) {
        poshWithData(identifire: "VoiceRecordVC", myView: VoiceRecordVC.self) { (vc) in
            vc?.delegate = self
        }
    }
    
    
    @IBAction func orderButton(_ sender: Any) {
        
        guard let userName = userNameTF.text , !userName.isEmpty else {
            presentAlertWith(msg: "Enter User Name") {}
            return
        }
        
        if locationB.titleLabel?.text == "" || locationB.titleLabel?.text == "Location" {
            presentAlertWith(msg: "Select Your Location") {}
            return
        }
        
        
        let orderDictionary = ["NamePerson": userName,
                               "NameProduct": nameProduct,
                               "NumberOfKilo": numberOfKiloL.text!,
                               "Price" : PriceOfKiloL.text!,
                               "Lat" : lat ,
                               "Lon" : lon ,
                               "PathRecord" : pathRecord]
        
        addOrder(dictionary: orderDictionary)
    }
    
    func addOrder (dictionary : [String:String]) {
        BaseFirebase.sendData(child: "Orders", dataDictionary: dictionary) { (success) in
            if success {
                self.presentAlertWith(msg: "Save Success ✔️") {}
                self.userNameTF.text = ""
                self.locationB.setTitle("Location", for: .normal)
                
            }else{
                self.presentAlertWith(msg: "Error ❌") {}
            }
        }
    }
    
}


extension DetailsOrderVC : SendPathRecord ,SendAddress , UITextFieldDelegate {
    func adress(name: String, lat: String, lon: String) {
        locationB.setTitle(name, for: .normal)
        self.lat = lat
        self.lon = lon
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        buttomScrollView.constant = 90
    }
    
    func path(url: String) {
        pathRecord = url
    }
}
