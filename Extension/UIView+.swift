//
//  UIView+.swift
//  HR-Checkin
//
//  Created by Ho Si Tuan on 13/03/2022.
//


import Foundation
import UIKit

//MARK: Set action to UIView
private var actionKey: Void?
extension UIView {
    func setAction(action: (() -> ())?) {
        self.isUserInteractionEnabled = true
        self.action = action
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pressed))
        self.addGestureRecognizer(tapGesture)
    }

    private var action: (() -> ())? {
        get {
            return objc_getAssociatedObject(self, &actionKey) as? () -> ()
        }
        set {
            objc_setAssociatedObject(self, &actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @objc private func pressed() {
        action?()
    }
}

extension Array where Element: UIView {
    func setAction(action: (() -> ())?) {
        for view in self {
            view.setAction(action: action)
        }
    }
}

extension UIView {
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        self.layer.maskedCorners = corners
        self.clipsToBounds = true
        self.cornerRadius = radius
    }
    
    @discardableResult
    public func addSubviews(_ subviews: UIView...) -> UIView {
        subviews.forEach { addSubview($0) }
        return self
    }
    
    @discardableResult
    public func addSubViews(_ subviews: [UIView]) -> UIView {
        subviews.forEach { addSubview($0) }
        return self
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
                
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
            
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: (layer.borderColor ?? UIColor.clear.cgColor))
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
}

extension UIView {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
}
