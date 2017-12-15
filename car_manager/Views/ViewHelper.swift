//
//  ViewHelper.swift
//  car_manager
//
//  Created by 沐阳 on 2017/12/12.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import Foundation
extension UILabel{
    @IBInspectable var cornerRadius: CGFloat{
        get{
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
        }
    }
}

import UIKit
@IBDesignable class ArcView: UILabel{
    
}
