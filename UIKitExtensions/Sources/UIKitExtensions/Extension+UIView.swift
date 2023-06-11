//
//  Extension+UIView.swift
//  DictionaryApp
//
//  Created by Emre Cambolat on 27.05.2023.
//

import UIKit

public extension UIView {
    
    @IBInspectable var circular: Bool {
        get { self.layer.cornerRadius == min(self.frame.size.width, self.frame.size.height) / 2.0 }
        set {
            if newValue {
                self.layer.cornerRadius = min(self.frame.size.width, self.frame.size.height) / 2.0
                self.layer.masksToBounds = true
            } else {
                self.layer.cornerRadius = 0
                self.layer.masksToBounds = false
            }
        }
    }
    
    @IBInspectable
    var borderRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
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
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set { layer.shadowColor = newValue?.cgColor }
    }
    
    @IBInspectable var shadowOpacity: CGFloat {
        get { CGFloat(layer.shadowOpacity) }
        set { layer.shadowOpacity = Float(newValue) }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get { layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get { layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
}
