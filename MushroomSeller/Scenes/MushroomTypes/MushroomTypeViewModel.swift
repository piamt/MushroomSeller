//
//  MushroomTypeViewModel.swift
//  MushroomSeller
//
//  Created by Pia on 13/10/2017.
//  Copyright © 2017 Pia. All rights reserved.
//

import Foundation

struct MushroomTypeViewModel {
    let type: MushroomType
    let imageName: String
    
    init(fromResponse response: MushroomTypeResponse) {
        self.type = response.type
        self.imageName = response.imageName
    }
}
