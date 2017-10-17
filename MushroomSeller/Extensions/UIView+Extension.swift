//
//  UIView+Extension.swift
//  MushroomSeller
//
//  Created by Pia on 13/10/2017.
//  Copyright © 2017 Pia. All rights reserved.
//

import UIKit
import Cartography

extension UIView {
    func addSubviewAndFillSuperview(_ view: UIView) {
        addSubview(view)
        
        constrain(view) { view in
            let parent = view.superview!
            
            view.top == parent.top
            view.bottom == parent.bottom
            view.leading == parent.leading
            view.trailing == parent.trailing
        }
    }
}
