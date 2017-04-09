//
//  UIControlEventsExtension.swift
//  Molad
//
//  Created by Haskel Ash on 4/9/17.
//  Copyright © 2017 HaskelAsh. All rights reserved.
//

import UIKit

extension UIControlEvents {
    static var crossLeftToRight: UIControlEvents {
        return UIControlEvents(rawValue: 0b0001 << 24)
    }
    static var crossRightToLeft: UIControlEvents {
        return UIControlEvents(rawValue: 0b0010 << 24)
    }
}
