//
//  Style.swift
//  MushroomSeller
//
//  Created by Pia on 15/10/2017.
//  Copyright © 2017 Pia. All rights reserved.
//

import UIKit

struct Style {
    struct MTypes {
        static let imageWild: String = "seta_silvestre"
        
        static let imageGrowing: String = "seta_cultivo"
        
        static let titleColor: UIColor = UIColor.black
        
        static let collectionBGColor: UIColor = UIColor.BrandBG()
        
        static let collectionCellColor: UIColor = UIColor.white
        
        static let title: String = "Select mushroom types"
    }
    
    struct MList {
        
        static let detailCellColor: UIColor = UIColor.white
        
        static let nameDetail: String = "Name:"
        
        static let scientificNameDetail: String = "Scientific name:"
        
        static let numberBoxesDetail: String = "Number of boxes:"
        
        static let boxFormatDetail: String = "Box format:"
        
        static let priceDetail: String = "Price kg:"
        
        struct DetailView {
            
            static let leading: CGFloat = 5.0
            
            static let widthPerc: CGFloat = 0.3
            
            static let stackLeadingTrailing: CGFloat = 3.0
        }
    }
    
    struct FontSize {
        static let title: CGFloat = 20.0
        
        static let description: CGFloat = 18.0
    }
}
