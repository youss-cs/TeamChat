//
//  GradienView.swift
//  TeamChat
//
//  Created by YouSS on 10/1/18.
//  Copyright © 2018 YouSS. All rights reserved.
//

import UIKit

@IBDesignable
class GradienView: UIView {

    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }

    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let gradienLayer = CAGradientLayer()
        gradienLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradienLayer.startPoint = CGPoint(x: 0, y: 0)
        gradienLayer.endPoint = CGPoint(x: 1, y: 1)
        gradienLayer.frame = self.bounds
        self.layer.insertSublayer(gradienLayer, at: 0)
    }
}
