//
//  UIFont+Extension.swift
//  MushroomSeller
//
//  Created by Pia on 15/10/2017.
//  Copyright © 2017 Pia. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func mushroomFont(size: CGFloat = Style.FontSize.description) -> UIFont {
        guard let font = UIFont(name: "HelveticaNeue-Light", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
    static func mushroomTitleFont(size: CGFloat = Style.FontSize.title) -> UIFont {
        guard let font = UIFont(name: "HelveticaNeue-Bold", size: size) else {
            return UIFont.boldSystemFont(ofSize: size)
        }
        return font
    }
}
