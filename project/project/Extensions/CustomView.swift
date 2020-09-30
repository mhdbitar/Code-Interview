//
//  CustomView.swift
//  project
//
//  Created by Mohammad Bitar on 9/26/20.
//

import UIKit

@IBDesignable
class CustomView: UIView {

    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .lightGray {
        didSet {
            self.layer.borderColor = borderColor.cgColor
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
}

extension UIView {
    
    func addBorder(width: CGFloat, corner: CGFloat, color: CGColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color
        self.layer.cornerRadius = corner
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

