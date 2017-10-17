//
//  MushroomInfoViewModel.swift
//  MushroomSeller
//
//  Created by Pia on 13/10/2017.
//  Copyright (c) 2017 Pia. All rights reserved.
//

import Foundation
import UIKit

struct MushroomInfoViewModel {
    let scientificName: String
    let name: String
    let origin: String
    let type: MushroomType
    let priceKg: CGFloat
    let boxFormat: String
    let boxesNumber: Int
    let imageUrl: String
    
    init(fromResponse response: MushroomInfoResponse) {
        self.scientificName = response.scientificName
        self.name = response.commonName
        self.origin = response.origin
        self.type = response.type
        self.priceKg = response.priceKg
        self.boxFormat = response.boxFormat
        self.boxesNumber = response.boxesNumber
        self.imageUrl = response.imageUrl
    }
}
