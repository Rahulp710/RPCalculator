//
//  RPButton.swift
//  RPCalculator
//
//  Created by Rahul Sharma on 1/29/19.
//  Copyright © 2019 Rahul Patil. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RPButton: UIButton {
    
    @IBInspectable var applyGradientColor : UIColor?
    @IBInspectable var selectedBackgroundColor : UIColor?
    @IBInspectable var nonHighlightedBackgroundColor : UIColor?
    
    override var isSelected :Bool {
        get {
            return super.isSelected
        }
        set {
            if newValue {
                self.backgroundColor = selectedBackgroundColor
            }
            else {
                self.backgroundColor = nonHighlightedBackgroundColor
            }
            super.isSelected = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0 ? true : false
            self.clipsToBounds = cornerRadius > 0 ? true : false
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        if let applyGradientColor = self.applyGradientColor {
            if let sublayers = self.layer.sublayers, sublayers.count == 2 {
                self.layer.sublayers?.removeFirst()
            }
            self.applyGradient(colours: [applyGradientColor.withAlphaComponent(0),
                                         applyGradientColor.withAlphaComponent(0.1),
                                         applyGradientColor.withAlphaComponent(0.2),
                                         applyGradientColor.withAlphaComponent(0.35),
                                         applyGradientColor.withAlphaComponent(0.5),
                                         applyGradientColor.withAlphaComponent(0.7),
                                         applyGradientColor])
        }
    }
}
