//
//  UIColorExtension.swift
//  Voice-ChangingBowtie
//
//  Created by Satoshi Komatsu on 2018/12/12.
//  Copyright © 2018 Satoshi Komatsu. All rights reserved.
//

import UIKit

extension UIColor {
    static var lightBlue: UIColor {
        return UIColor.rgbColor(0x00ACED)
    }
    
    class func rgbColor(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >>  8) / 255.0,
            blue:  CGFloat( rgbValue & 0x0000FF)        / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
