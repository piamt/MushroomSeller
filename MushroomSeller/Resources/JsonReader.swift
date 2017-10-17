//
//  JsonReader.swift
//  JumpingClash
//
//  Created by Pia Muñoz on 1/8/17.
//  Copyright © 2017 Narada Robotics. All rights reserved.
//

import Foundation

class JsonReader {
    
    static public func readJson(_ name: String) -> Data? {
    
        guard let file = Bundle.main.url(forResource: name, withExtension: "json"),
            let jsonData = try? Data(contentsOf: file) else {
            return nil
        }
        return jsonData
    }
}
