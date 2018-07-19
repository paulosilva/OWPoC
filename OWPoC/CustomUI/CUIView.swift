//
//  CUIView.swift
//  OWPoC
//
//  Created by Paulo Silva on 05/07/2018.
//  Copyright © 2018 Paulo Silva. All rights reserved.
//

import UIKit

@IBDesignable
class CUIView: UIView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
        
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
//    @IBInspectable
//    var maskedCorners: CACornerMask {
//        get {
//            return layer.maskedCorners
//        }
//        set {
//            layer.maskedCorners = newValue
//        }
//    }
    
}

