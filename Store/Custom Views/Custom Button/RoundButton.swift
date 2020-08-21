//
//  RoundButton.swift
//  Store
//
//  Created by Mohamed on 8/18/20.
//  Copyright © 2020 MohamedHamid. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
    
    @IBInspectable var dgree : CGFloat = 0 {
        didSet{
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var color : UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) {
        didSet{
            self.setNeedsLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = dgree
        layer.borderWidth = 2
        layer.borderColor = color.cgColor
        
    }
    
}
