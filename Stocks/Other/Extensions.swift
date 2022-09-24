//
//  Extensions.swift
//  Stocks
//
//  Created by Eliu Efraín Díaz Bravo on 03/08/22.
//

import UIKit

extension UIView {
    var width: CGFloat {
        frame.size.width
    }
    
    var height: CGFloat {
        frame.size.height
    }
    
    var top: CGFloat {
        frame.origin.y
    }
    var left: CGFloat {
        frame.origin.x
    }
    var right: CGFloat {
        left + width
    }
    var bottom: CGFloat {
        top + height
    }
    
}

