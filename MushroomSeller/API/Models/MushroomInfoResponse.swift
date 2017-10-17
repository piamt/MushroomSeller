//
//  MushroomInfoResponse.swift
//  MushroomSeller
//
//  Created by Pia on 15/10/2017.
//  Copyright © 2017 Pia. All rights reserved.
//

import Foundation
import UIKit

public struct MushroomInfoResponse {
    let scientificName: String
    let commonName: String
    let origin: String
    let type: MushroomType
    let priceKg: CGFloat
    let boxFormat: String
    let boxesNumber: Int
    let imageUrl: String
    
    init(withResponse response: MushroomInfoResponse, andScientificName name: String) {
        self.scientificName = name
        self.commonName = response.commonName
        self.origin = response.origin
        self.type = response.type
        self.priceKg = response.priceKg
        self.boxFormat = response.boxFormat
        self.boxesNumber = response.boxesNumber
        self.imageUrl = response.imageUrl
    }
}

extension MushroomInfoResponse: Decodable {
    
    private enum CodingKeys : String, CodingKey {
        case commonName = "common_name"
        case origin
        case type
        case priceKg = "price_kg"
        case boxFormat = "box_format"
        case boxesNumber = "boxes_number"
        case imageUrl = "image_url"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        commonName = try values.decode(String.self, forKey: .commonName)
        scientificName = commonName
        origin = try values.decode(String.self, forKey: .origin)
        priceKg = try values.decode(CGFloat.self, forKey: .priceKg)
        boxFormat = try values.decode(String.self, forKey: .boxFormat)
        boxesNumber = try values.decode(Int.self, forKey: .boxesNumber)
        imageUrl = try values.decode(String.self, forKey: .imageUrl)
        
        let typeRaw = try values.decode(String.self, forKey: .type)
        if typeRaw == "growing" {
            type = MushroomType.growing
        } else {
            type = MushroomType.wild
        }
    }
}
