//
//  UIImage+Extension.swift
//  MushroomSeller
//
//  Created by Pia on 15/10/2017.
//  Copyright © 2017 Pia. All rights reserved.
//

import UIKit

extension UIImage {
    static func fromURL(_ string: String) -> UIImage? {
        return (URL(string: string)
            .flatMap { try? Data(contentsOf: $0) }
            .flatMap { UIImage(data: $0) })
    }
}
