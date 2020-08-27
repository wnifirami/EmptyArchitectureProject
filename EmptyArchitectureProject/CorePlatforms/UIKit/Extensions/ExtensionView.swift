//
//  ExtensionView.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/19/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import Foundation



import UIKit

@IBDesignable
class CustomView: UIView {
    
    @IBInspectable var boorderColor: UIColor? {
        didSet {
            self.layer.borderColor = boorderColor?.cgColor
        }
    }
    
    @IBInspectable var boorderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = boorderWidth
        }
    }
    
    @IBInspectable var coornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = coornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var topLeftCornerRadius : CGFloat = 0 {
        didSet {
            self.roundCornersWithLayerMask(cornerRadii: topLeftCornerRadius,corners: [.topLeft])
        }
    }
    @IBInspectable var topRightCornerRadius : CGFloat = 0 {
        didSet {
            self.roundCornersWithLayerMask(cornerRadii: topRightCornerRadius,corners: [.topRight])
        }
    }
    @IBInspectable var shaadowColor: UIColor? {
        didSet {
            self.layer.shadowColor = shaadowColor?.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
            self.layer.masksToBounds = false
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
}
extension UIView {
    func roundCornersWithLayerMask(cornerRadii: CGFloat, corners: UIRectCorner) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
    
    func roundLeftCorners(cornerRadii: CGFloat) {
        roundCorners(cornerRadii: cornerRadii, maskedCorners: [.layerMinXMinYCorner, .layerMinXMaxYCorner], rectCorners: [.bottomLeft , .topLeft])
    }
    
    func roundRightCorners(cornerRadii: CGFloat) {
        roundCorners(cornerRadii: cornerRadii, maskedCorners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner], rectCorners: [.topRight , .bottomRight])
    }
    
    func roundAllCorners(cornerRadii: CGFloat) {
        roundCorners(cornerRadii: cornerRadii, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner], rectCorners: [.allCorners])
    }
    
    func roundCorners(cornerRadii: CGFloat, maskedCorners: CACornerMask, rectCorners: UIRectCorner) {
        if #available(iOS 11.0, *){
            clipsToBounds = false
            layer.cornerRadius = cornerRadii
            layer.maskedCorners = maskedCorners
        } else {
            let rectShape = CAShapeLayer()
            rectShape.bounds = frame
            rectShape.position = center
            rectShape.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: rectCorners, cornerRadii: CGSize(width: cornerRadii, height: cornerRadii)).cgPath
            layer.mask = rectShape
        }
    }
    
    
    //corner Radius
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    //border Width
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    //border Color
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    // shadow color
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        
        set {
            if let color = newValue {
                self.clipsToBounds = false
                self.layer.shadowColor = color.cgColor
                self.layer.shadowOffset = CGSize(width: 0, height: 3)
                self.layer.shadowOpacity = 0.1
                self.layer.shadowRadius = 5.0
            }
        }
    }
    
    //Add animation fade in
    func fadeIn() {
        self.alpha -= 10
        self.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.alpha += 10
        }
    }
    
    //Add animation fade out
    func fadeOut() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha -= 10
        }, completion: { _ in
            self.isHidden = true
            self.alpha += 10
        })
    }
    
    func slideDown() {
        if !isHidden {
            return
        }
        self.center.y -= self.bounds.height + 8
        self.isHidden = false
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.center.y += self.bounds.height + 8
        }, completion: nil)
    }
    
    func showAnimated() {
        self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.alpha -= 3
        self.isHidden = false
        
        UIView.animate(withDuration: 0.5) {
            self.transform = CGAffineTransform.identity
            self.alpha += 3
        }
    }
    
}
extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

extension UIView {
    
    func subviewsRecursive() -> [UIView] {
        
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
        
    }
    
}
