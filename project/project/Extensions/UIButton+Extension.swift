//
//  UIButton+Extension.swift
//  project
//
//  Created by Mohammad Bitar on 9/25/20.
//

import UIKit

@IBDesignable
extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable  var cornerRadius: CGFloat {
        set {
            if Helpers.isIpad() {
                layer.cornerRadius = 20
            } else {
                layer.cornerRadius = newValue
            }
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var setShadow: Bool {
        set {
            if newValue {
                self.dropShadow(color: self.shadowColor ?? UIColor.clear)
            }
        }
        get {
            return true
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.shadowColor = uiColor.cgColor
        }
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
