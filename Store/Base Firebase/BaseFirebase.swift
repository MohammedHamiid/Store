//
//  BaseFirebase.swift
//  Store
//
//  Created by Mohamed on 8/20/20.
//  Copyright © 2020 MohamedHamid. All rights reserved.
//

import Foundation
import Firebase

class BaseFirebase {
    
    // MARK:- Send Data To Fire Base
    class func sendData (child : String ,dataDictionary : [String : String] , compeletion : @escaping (_ sucsses : Bool) -> Void ) {
        let productsDB = Database.database().reference().child(child)
        let productDictionary = dataDictionary
        
        productsDB.childByAutoId().setValue(productDictionary) {
            (error, reference) in
            
            if error != nil {
                print(error!)
                compeletion(false)
            }
            else {
                compeletion(true)
            }
            
        }
    }
    
    
    // MARK:- Retrive Data From Friebase
    class func retrieveData(child : String , compeletion : @escaping (_ data : [String : String]?) -> Void) {
        let messageDB = Database.database().reference().child(child)
        messageDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            compeletion(snapshotValue)
        }
    }
}
