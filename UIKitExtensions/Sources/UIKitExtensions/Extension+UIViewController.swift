//
//  Extension+UIViewController.swift
//  DictionaryApp
//
//  Created by Emre Cambolat on 30.05.2023.
//

import UIKit

public extension UIViewController {
    func showToast(_ message : String, font: UIFont = UIFont.boldSystemFont(ofSize: 14.0)) {
        let toastLabel = UILabel(frame: CGRect.zero)
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 0.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        
        let maxSize = CGSize(width: self.view.frame.size.width * 0.8, height: self.view.frame.size.height * 0.8)
        let expectedSize = toastLabel.sizeThatFits(maxSize)
        
        var adjustedWidth = expectedSize.width + 24
        var adjustedHeight = expectedSize.height + 16
        
        if adjustedWidth > maxSize.width {
            adjustedWidth = maxSize.width
            adjustedHeight = expectedSize.height * ((expectedSize.width / maxSize.width).rounded(.up)) + 10
        }
        
        let x = (self.view.frame.width - adjustedWidth) / 2
        let y = self.view.frame.height - adjustedHeight - 100
        
        toastLabel.frame = CGRect(x: x, y: y, width: adjustedWidth, height: adjustedHeight)
        
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 2.5, options: .curveEaseInOut, animations: {
                toastLabel.alpha = 0.0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
}
