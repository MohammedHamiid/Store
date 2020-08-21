//
//  ExViewController.swift
//  Store
//
//  Created by Mohamed on 8/18/20.
//  Copyright © 2020 MohamedHamid. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func poshWithoutData (identifire : String) {
        let vc = storyboard?.instantiateViewController(identifier: identifire)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func poshWithData <T:UIViewController>(identifire : String , myView : T.Type ,completion:@escaping (T?) -> Void) {
        let vc = storyboard?.instantiateViewController(identifier: identifire) as T?
        completion(vc)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func popVC () {
        navigationController?.popViewController(animated: true)
    }
    
    func present (identifire : String ) {
        let vc = storyboard?.instantiateViewController(identifier: identifire)
        vc?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc?.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        self.present(vc!,animated: true, completion: nil)
    }
    
    func dismiss () {
        dismiss(animated: true, completion: nil)
    }
    
    func changeRoot (identifire : String) {
        let vc = self.storyboard?.instantiateViewController(identifier: identifire)
        self.view.window?.rootViewController = vc
    }
    
    @objc func dismissKeyboard () {
        view.endEditing(true)
    }

    func presentAlertWith(title: String = "Store", msg: String, _ completion: @escaping () ->Void) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                alert.dismiss(animated: true, completion: nil)
                completion()
            }
        }
    }
}
