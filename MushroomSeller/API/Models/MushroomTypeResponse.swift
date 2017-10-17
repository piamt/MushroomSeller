//
//  MushroomTypeResponse.swift
//  MushroomSeller
//
//  Created by Pia on 13/10/2017.
//  Copyright © 2017 Pia. All rights reserved.
//

import Foundation

public enum MushroomType: String {
    case growing = "Growing mushrooms"
    case wild = "Wild mushrooms"
}

public struct MushroomTypeResponse {
    let type: MushroomType
    let imageName: String
}

extension MushroomTypeResponse: Decodable {

    private enum CodingKeys : String, CodingKey {
        case type
        case imageName = "image"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageName = try values.decode(String.self, forKey: .imageName)
        let typeRaw = try values.decode(String.self, forKey: .type)
        if typeRaw == "growing" {
            type = MushroomType.growing
        } else {
            type = MushroomType.wild
        }
    }
}
